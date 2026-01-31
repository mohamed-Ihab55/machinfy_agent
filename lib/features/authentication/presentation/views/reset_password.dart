import 'package:flutter/material.dart';
import 'package:machinfy_agent/features/authentication/models/reset_password.dart';
import 'package:provider/provider.dart';

import 'package:machinfy_agent/core/utils/primary_button.dart';
import 'package:machinfy_agent/core/utils/text_button_icon.dart';
import 'package:machinfy_agent/features/authentication/presentation/widgets/auth_text_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ResetPasswordViewModel(),
      child: const _ResetPasswordBody(),
    );
  }
}

class _ResetPasswordBody extends StatelessWidget {
  const _ResetPasswordBody();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ResetPasswordViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              // Back
              Align(alignment: Alignment.centerLeft, child: TextButtonIcon()),

              const SizedBox(height: 90),

              const Text(
                'Reset Password',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF111827),
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 6),

              const Text(
                'Enter your email to receive a password reset link',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF6B7280),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 28),

              AuthTextField(
                label: 'Email Address',
                hint: 'name@company.com',
                controller: vm.emailController,
                prefixIcon: Icons.mail_outline,
                keyboardType: TextInputType.emailAddress,
                errorText: vm.emailError,
              ),

              const SizedBox(height: 18),

              PrimaryButton(
                text: 'Send Reset Link',
                isLoading: vm.isLoading,
                onTap: vm.sendResetLink,
              ),

              const SizedBox(height: 18),

              InkWell(
                onTap: () => Navigator.pop(context),
                child: const Text(
                  'Back to Sign In',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2563EB),
                    decoration: TextDecoration.underline,
                    decorationThickness: 1.2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
