import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machinfy_agent/core/config.dart';
import 'package:machinfy_agent/core/constants.dart';
import 'package:machinfy_agent/features/chat_agent/cubit/chat_cubit.dart';
import 'package:machinfy_agent/features/chat_agent/presentation/view/chat_bot_screen.dart';
import 'package:machinfy_agent/features/chat_agent/services/openai_service.dart';
import 'package:machinfy_agent/features/welcome_screen/presentation/view/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: kBackgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: kBackgroundColor,
          elevation: 0,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => ChatCubit(
          openAIService: OpenAIService(apiKey: AppConfig.openAIApiKey),
        ),
        child: const SplashScreen(),
      ),
    );
  }
}
