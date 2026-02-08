import 'package:flutter/material.dart';
import 'package:machinfy_agent/core/typography.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Welcome Back', style: Style.headingMedium),
        const SizedBox(height: 6),
        Text(
          'Sign in to continue your learning journey',
          style: Style.subTitle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
