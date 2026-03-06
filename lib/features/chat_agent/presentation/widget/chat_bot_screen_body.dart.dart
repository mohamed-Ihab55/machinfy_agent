import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machinfy_agent/core/assets.dart';
import 'package:machinfy_agent/features/chat_agent/cubit/chat_cubit.dart';
import 'package:machinfy_agent/features/chat_agent/presentation/widget/chat_error_banner.dart';
import 'package:machinfy_agent/features/chat_agent/presentation/widget/chat_input_field.dart';
import 'package:machinfy_agent/features/chat_agent/presentation/widget/chat_messages_list.dart';

class ChatBotScreenBody extends StatefulWidget {
  final String userId;

  const ChatBotScreenBody({super.key, required this.userId});

  @override
  State<ChatBotScreenBody> createState() => _ChatBotScreenBodyState();
}

class _ChatBotScreenBodyState extends State<ChatBotScreenBody> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

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

  void _send(ChatState state) {
    final text = _controller.text.trim();
    if (text.isEmpty || state is ChatLoading) return;

    context.read<ChatCubit>().sendMessage(text);
    _controller.clear();
    _scrollBottom();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is ChatError) _scrollBottom();
      },
      builder: (context, state) {
        final messages = state.messages;

        return Column(
          children: [
            Expanded(
              child: messages.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AssetsData.logo, height: 150),
                          const SizedBox(height: 16),
                          const Text(
                            "Start a conversation with the AI",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  : ChatMessagesList(
                      messages: messages,
                      controller: _scrollController,
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

            const SizedBox(height: 50),
          ],
        );
      },
    );
  }
}
