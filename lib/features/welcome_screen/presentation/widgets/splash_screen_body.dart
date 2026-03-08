import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:local_auth/local_auth.dart';

import 'package:machinfy_agent/core/utils/primary_button.dart';
import 'package:machinfy_agent/core/utils/secondary_button.dart';
import 'package:machinfy_agent/features/authentication/models/login_view_model.dart';
import 'package:machinfy_agent/features/authentication/presentation/views/login_screen.dart';
import 'package:machinfy_agent/features/authentication/presentation/views/register_screen.dart';
import 'package:machinfy_agent/features/chat_agent/presentation/view/chat_bot_screen.dart';

import 'package:provider/provider.dart';

class SplashScreenBody extends StatefulWidget {
  const SplashScreenBody({super.key});

  @override
  State<SplashScreenBody> createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody> {
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      bool authenticated = await authenticateUser();

      if (!mounted) return;

      if (authenticated) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ChatBotScreen()),
        );
      }
    }
  }

  Future<bool> authenticateUser() async {
    try {
      bool canCheck = await auth.canCheckBiometrics;
      bool supported = await auth.isDeviceSupported();

      if (!canCheck || !supported) {
        return true; // skip biometric if not supported
      }

      bool authenticated = await auth.authenticate(
        localizedReason: 'Authenticate to open the app',
        biometricOnly: true,
      );

      return authenticated;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LoginViewModel>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              Image.asset(
                'assets/images/logo.png',
                width: 70,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 20),

              const Text(
                'Machinfy Academy',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 6),

              const Text(
                'Master AI & Data Science',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6B7280),
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 10),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Join thousands of professionals advancing their careers with industry-leading courses',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF9CA3AF),
                    height: 1.4,
                  ),
                ),
              ),

              const Spacer(flex: 3),

              PrimaryButton(
                text: 'Sign In',
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
                isLoading: vm.isLoading,
              ),

              const SizedBox(height: 12),

              SecondaryButton(
                text: 'Create Account',
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                  );
                },
              ),

              const Spacer(flex: 1),

              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text(
                  'By continuing you agree to our Terms & Privacy Policy',
                  style: TextStyle(fontSize: 11.5, color: Color(0xFF9CA3AF)),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
