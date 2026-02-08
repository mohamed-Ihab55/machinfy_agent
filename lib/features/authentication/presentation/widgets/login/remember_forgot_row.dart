import 'package:flutter/material.dart';

import 'package:machinfy_agent/core/constants.dart';
import 'package:machinfy_agent/core/typography.dart';
import 'package:machinfy_agent/features/authentication/presentation/views/reset_password.dart';

class RememberForgotRow extends StatelessWidget {
  const RememberForgotRow({
    super.key,
    required this.rememberMe,
    required this.onRememberChanged,
  });

  final bool rememberMe;
  final ValueChanged<bool?> onRememberChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: rememberMe,
          onChanged: onRememberChanged,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          activeColor: kPrimaryColor,
        ),
        Text('Remember me', style: Style.smallGrey),
        const Spacer(),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ResetPasswordScreen()),
            );
          },
          child: Text('Forgot Password?', style: Style.link),
        ),
      ],
    );
  }
}
