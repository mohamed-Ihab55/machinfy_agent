import 'package:flutter/material.dart';
import 'package:machinfy_agent/features/chat_agent/presentation/widget/custom_app_bar.dart';
import 'package:machinfy_agent/features/chat_agent/presentation/widget/chat_bot_screen_body.dart.dart';

class ChatBotScreen extends StatelessWidget {
  const ChatBotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(), body: ChatBotScreenBody());
  }
}
