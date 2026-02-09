import 'package:flutter/material.dart';
import 'package:machinfy_agent/core/typography.dart';

class ResetPasswordHeader extends StatelessWidget {
  const ResetPasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Reset Password',
          style: Style.headingMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Text(
          'Enter your email to receive a password reset link',
          style: Style.subTitle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
