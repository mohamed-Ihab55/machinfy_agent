import 'package:flutter/material.dart';
import 'package:machinfy_agent/features/authentication/presentation/views/login_screen.dart';
import 'package:machinfy_agent/features/authentication/models/login_view_model.dart';
import 'package:machinfy_agent/features/welcome_screen/presentation/widgets/splash_screen_body.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkFirstRun();
  }

  Future<void> checkFirstRun() async {
    final prefs = await SharedPreferences.getInstance();

    bool isFirstRun = prefs.getBool('firstRun') ?? true;

    if (!isFirstRun) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } else {
      await prefs.setBool('firstRun', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: const SplashScreenBody(),
    );
  }
}
