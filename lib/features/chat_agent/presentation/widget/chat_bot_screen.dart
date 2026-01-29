import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machinfy_agent/core/assets.dart';
import 'package:machinfy_agent/core/constants.dart';
import 'package:machinfy_agent/core/typography.dart';
import 'package:machinfy_agent/features/chat_agent/cubit/chat_cubit.dart';
import 'package:machinfy_agent/features/chat_agent/presentation/widget/message_bubble.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

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
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is ChatSuccess || state is ChatError) {
          _scrollToBottom();
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            // Chat messages area
            Expanded(
              child: state.messages.isEmpty
                  ? Center(
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
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        final message = state.messages[index];
                        return MessageBubble(message: message);
                      },
                    ),
            ),

            // Error message display
            if (state is ChatError)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                color: kErrormsg!.withValues(alpha: 0.1),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: kErrormsg, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        state.errorMessage,
                        style: Style.bodysmall.copyWith(color: kErrormsg),
                      ),
                    ),
                  ],
                ),
              ),

            // Input area
            Container(
              decoration: BoxDecoration(
                color: kSendAndCircularIndicator,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
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
                          decoration: InputDecoration(
                            hintText: 'Type your message...',
                            hintStyle: Style.bodysmall.copyWith(
                              color: Colors.grey[400],
                            ),
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
                            fillColor: Colors.grey[50],
                          ),
                          maxLines: null,
                          textInputAction: TextInputAction.send,
                          onSubmitted: (value) {
                            if (value.trim().isNotEmpty &&
                                state is! ChatLoading) {
                              context.read<ChatCubit>().sendMessage(value);
                              _messageController.clear();
                            }
                          },
                          enabled: state is! ChatLoading,
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
                              : () {
                                  if (_messageController.text
                                      .trim()
                                      .isNotEmpty) {
                                    context.read<ChatCubit>().sendMessage(
                                      _messageController.text,
                                    );
                                    _messageController.clear();
                                  }
                                },
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
