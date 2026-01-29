import 'package:flutter/material.dart';
import 'package:machinfy_agent/features/chat_agent/presentation/widget/primary_button.dart';
import 'package:machinfy_agent/features/chat_agent/presentation/widget/secondary_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 2), // 👈 مسافة فوق
              // 🔹 اللوجو
              Image.asset(
                'assets/images/logo.png',
                width: 70,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 20),

              const Text(
                'Machinfy Academy',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
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

              const Spacer(flex: 3), // 👈 يزق الأزرار لتحت
              // 🔹 الأزرار (نفس مكان الصورة)
              PrimaryButton(text: 'Sign In', onTap: () {}),
              const SizedBox(height: 12),
              SecondaryButton(text: 'Create Account', onTap: () {}),

              const Spacer(flex: 1),

              // 🔹 النص الأخير
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
