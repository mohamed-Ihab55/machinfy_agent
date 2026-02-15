import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:machinfy_agent/core/assets.dart';
import 'package:machinfy_agent/core/constants.dart';
import 'package:machinfy_agent/core/typography.dart';
import 'package:machinfy_agent/features/chat_agent/cubit/chat_cubit.dart';
import 'package:machinfy_agent/features/chat_agent/models/chat_message.dart';
import 'package:machinfy_agent/features/chat_agent/presentation/widget/message_bubble.dart';

class ChatBotScreenBody extends StatefulWidget {
  const ChatBotScreenBody({super.key});

  @override
  State<ChatBotScreenBody> createState() => _ChatBotScreenBodyState();
}

class _ChatBotScreenBodyState extends State<ChatBotScreenBody> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Global chat (لو عايزاه per-user قولّي واغيّره لك)
  final CollectionReference<Map<String, dynamic>> _messagesRef =
      FirebaseFirestore.instance.collection('messages');

  // لمنع تكرار حفظ نفس ردّ الـassistant
  String? _lastSavedAssistant;

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _saveMessage({
    required String content,
    required MessageRole role,
  }) async {
    await _messagesRef.add({
      'content': content.trim(),
      'role': role.name, // user / assistant
      'timestamp': FieldValue.serverTimestamp(),
      // اختياري لو عايزة تعرفي صاحب الرسالة
      'uid': FirebaseAuth.instance.currentUser?.uid,
      'email': FirebaseAuth.instance.currentUser?.email,
    });
  }

  Future<void> _sendUserMessage(ChatState state, String raw) async {
    final text = raw.trim();
    if (text.isEmpty) return;
    if (state is ChatLoading) return;

    // 1) حفظ رسالة المستخدم في Firestore
    await _saveMessage(content: text, role: MessageRole.user);

    // 2) ابعتي للـCubit عشان يجيب رد AI
    context.read<ChatCubit>().sendMessage(text);

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) async {
        if (state is ChatSuccess) {
          // نفترض آخر رسالة في state.messages هي ردّ assistant
          final last = state.messages.isNotEmpty ? state.messages.last : null;

          if (last != null && last.role == MessageRole.assistant) {
            final txt = last.content.trim();
            if (txt.isNotEmpty && txt != _lastSavedAssistant) {
              _lastSavedAssistant = txt;
              await _saveMessage(content: txt, role: MessageRole.assistant);
            }
          }

          _scrollToBottom();
        }

        if (state is ChatError) {
          _scrollToBottom();
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: _messagesRef
                    .orderBy('timestamp', descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final docs = snapshot.data?.docs ?? [];

                  if (docs.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AssetsData.logo, width: 80),
                          const SizedBox(height: 16),
                          Text(
                            'Start a conversation',
                            style: Style.bodysmall.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  // انزل لآخر الشات بعد كل تحديث
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) => _scrollToBottom(),
                  );

                  final messages = docs.map((d) {
                    final data = d.data();

                    // serverTimestamp ممكن يطلع null أول snapshot
                    final safe = {
                      ...data,
                      'timestamp': data['timestamp'] ?? Timestamp.now(),
                    };

                    return ChatMessage.fromMap(safe);
                  }).toList();

                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return MessageBubble(message: messages[index]);
                    },
                  );
                },
              ),
            ),

            if (state is ChatError)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                color: kErrormsg!,
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: kErrormsg, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        state.errorMessage,
                        style: Style.bodysmall.copyWith(color: kTexttErrormsg),
                      ),
                    ),
                  ],
                ),
              ),

            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          enabled: state is! ChatLoading,
                          style: Theme.of(context).textTheme.bodyLarge,
                          decoration: InputDecoration(
                            hintText: 'Type your message...',
                            hintStyle: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.grey[600]),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide(color: kBorderTextField!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide(color: kBorderTextField!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: const BorderSide(
                                color: kPrimaryColor,
                                width: 2,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surface,
                          ),
                          maxLines: null,
                          textInputAction: TextInputAction.send,
                          onSubmitted: (value) =>
                              _sendUserMessage(state, value),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: state is ChatLoading
                              ? kSecondaryColor
                              : kPrimaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: state is ChatLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      kSendAndCircularIndicator,
                                    ),
                                  ),
                                )
                              : const Icon(
                                  Icons.send,
                                  color: kSendAndCircularIndicator,
                                ),
                          onPressed: state is ChatLoading
                              ? null
                              : () => _sendUserMessage(
                                  state,
                                  _messageController.text,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
