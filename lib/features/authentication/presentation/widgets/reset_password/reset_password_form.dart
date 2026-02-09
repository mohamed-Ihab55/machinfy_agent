import 'package:flutter/material.dart';
import 'package:machinfy_agent/features/authentication/presentation/widgets/auth_text_field.dart';

class ResetPasswordForm extends StatelessWidget {
  const ResetPasswordForm({
    super.key,
    required this.emailController,
    required this.emailError,
    required this.onEmailChanged,
  });

  final TextEditingController emailController;
  final String? emailError;
  final ValueChanged<String> onEmailChanged;

  @override
  Widget build(BuildContext context) {
    return AuthTextField(
      label: 'Email Address',
      hint: 'name@company.com',
      controller: emailController,
      prefixIcon: Icons.mail_outline,
      keyboardType: TextInputType.emailAddress,
      errorText: emailError,
      onChanged: onEmailChanged,
    );
  }
}
