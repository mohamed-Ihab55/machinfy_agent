import 'package:flutter/material.dart';
import 'package:machinfy_agent/features/chat_agent/models/chat_message.dart';
import 'package:machinfy_agent/features/chat_agent/presentation/widget/message_bubble.dart';

class ChatMessagesList extends StatelessWidget {
  final List<ChatMessage> messages;
  final ScrollController controller;

  const ChatMessagesList({
    super.key,
    required this.messages,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // reverse: true,
      controller: controller,
      padding: const EdgeInsets.all(16),
      itemCount: messages.length,
      itemBuilder: (_, index) {
        return MessageBubble(message: messages[index]);
      },
    );
  }
}
