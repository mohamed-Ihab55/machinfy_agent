import 'package:flutter/material.dart';
import 'package:machinfy_agent/core/typography.dart';
import 'package:machinfy_agent/features/authentication/presentation/views/register_screen.dart';

class SignupRow extends StatelessWidget {
  const SignupRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have an account? ", style: Style.smallGrey),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RegisterScreen()),
            );
          },
          child: Text('Sign Up', style: Style.linkUnderline),
        ),
      ],
    );
  }
}
