import 'package:flutter/material.dart';
import 'package:machinfy_agent/core/typography.dart';

class BackToSignInLink extends StatelessWidget {
  const BackToSignInLink({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Text('Back to Sign In', style: Style.linkUnderline),
    );
  }
}
