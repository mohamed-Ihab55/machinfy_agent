import 'package:flutter/material.dart';

import 'package:machinfy_agent/features/authentication/cubit/login/login_state.dart';
import 'package:machinfy_agent/features/authentication/presentation/widgets/auth_text_field.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.state,
    required this.onEmailChanged,
    required this.onPasswordChanged,
    required this.onTogglePassword,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final LoginState state;

  final ValueChanged<String> onEmailChanged;
  final ValueChanged<String> onPasswordChanged;
  final VoidCallback onTogglePassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AuthTextField(
          label: 'Email Address',
          hint: 'name@company.com',
          controller: emailController,
          prefixIcon: Icons.mail_outline,
          keyboardType: TextInputType.emailAddress,
          errorText: state.emailError,
          onChanged: onEmailChanged,
        ),
        const SizedBox(height: 16),
        AuthTextField(
          label: 'Password',
          hint: 'Enter your password',
          controller: passwordController,
          prefixIcon: Icons.lock_outline,
          obscureText: state.isPasswordHidden,
          suffixIcon: state.isPasswordHidden
              ? Icons.remove_red_eye_outlined
              : Icons.visibility_off_outlined,
          onSuffixTap: onTogglePassword,
          errorText: state.passwordError,
          onChanged: onPasswordChanged,
        ),
      ],
    );
  }
}
