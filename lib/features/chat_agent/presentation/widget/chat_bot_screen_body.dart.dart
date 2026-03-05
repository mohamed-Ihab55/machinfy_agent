import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machinfy_agent/features/chat_agent/presentation/widget/chat_error_banner.dart';
import 'package:machinfy_agent/features/chat_agent/presentation/widget/chat_input_field.dart';
import 'package:machinfy_agent/features/chat_agent/presentation/widget/chat_messages_list.dart';
import 'package:machinfy_agent/features/chat_agent/presentation/widget/chat_repository.dart';

import '../../cubit/chat_cubit.dart';
import '../../models/chat_message.dart';

class ChatBotScreenBody extends StatefulWidget {
  const ChatBotScreenBody({super.key});

  @override
  State<ChatBotScreenBody> createState() => _ChatBotScreenBodyState();
}

class _ChatBotScreenBodyState extends State<ChatBotScreenBody> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ChatRepository _repo = ChatRepository();

  String? _lastAssistant;

  /// Scroll to the last message
  void _scrollBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  /// Send user message
  Future<void> _send(ChatState state) async {
    final text = _controller.text.trim();

    if (text.isEmpty || state is ChatLoading) return;

    await _repo.saveMessage(content: text, role: MessageRole.user);

    context.read<ChatCubit>().sendMessage(text);

    _controller.clear();

    _scrollBottom();
  }

  /// Handle assistant response and save it
  Future<void> _handleAssistant(ChatSuccess state) async {
    final last = state.messages.last;

    if (last.role != MessageRole.assistant) return;

    if (last.content == _lastAssistant) return;

    _lastAssistant = last.content;

    await _repo.saveMessage(content: last.content, role: MessageRole.assistant);

    _scrollBottom();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is ChatSuccess) {
          _handleAssistant(state);
        }

        if (state is ChatError) {
          _scrollBottom();
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: StreamBuilder<List<ChatMessage>>(
                stream: _repo.getMessages(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final messages = snapshot.data!;

                  /// Scroll when messages update
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scrollBottom();
                  });

                  return ChatMessagesList(
                    messages: messages,
                    controller: _scrollController,
                  );
                },
              ),
            ),

            if (state is ChatError)
              ChatErrorBanner(message: state.errorMessage),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ChatInputField(
                controller: _controller,
                isLoading: state is ChatLoading,
                onSend: () => _send(state),
              ),
            ),
            SizedBox(height: 50),
          ],
        );
      },
    );
  }
}
