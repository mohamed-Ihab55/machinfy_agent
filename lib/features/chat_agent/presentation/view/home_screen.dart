import 'package:flutter/material.dart';
import 'package:machinfy_agent/features/chat_agent/presentation/widget/custom_app_bar.dart';
import 'package:machinfy_agent/features/chat_agent/presentation/widget/home_screen_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: const HomeScreenBody(),
    );
  }
}

