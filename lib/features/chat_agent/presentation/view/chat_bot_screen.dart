import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machinfy_agent/core/config.dart';
import 'package:machinfy_agent/features/chat_agent/cubit/chat_cubit.dart';
import 'package:machinfy_agent/features/chat_agent/presentation/widget/custom_app_bar.dart';
import 'package:machinfy_agent/features/chat_agent/presentation/widget/chat_bot_screen_body.dart.dart';
import 'package:machinfy_agent/features/chat_agent/services/openai_service.dart';
import 'package:machinfy_agent/features/side_menu/presentation/view/menu_drawer.dart';

class ChatBotScreen extends StatelessWidget {
  const ChatBotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      endDrawer: const MenuDrawer(),
      body: BlocProvider(
        create: (context) => ChatCubit(openAIService: OpenAIService(
                          apiKey: AppConfig.openAIApiKey,
                        ),),
        child: ChatBotScreenBody(),
      ),
    );
  }
}
