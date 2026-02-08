import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machinfy_agent/core/utils/primary_button.dart';
import 'package:machinfy_agent/core/utils/text_button_icon.dart';
import 'package:machinfy_agent/features/authentication/cubit/reset_password/reset_password_cubit.dart';
import 'package:machinfy_agent/features/authentication/cubit/reset_password/reset_password_state.dart';
import 'package:machinfy_agent/features/authentication/presentation/widgets/auth_text_field.dart';

class ResetPasswordBody extends StatefulWidget {
  const ResetPasswordBody();

  @override
  State<ResetPasswordBody> createState() => _ResetPasswordBodyState();
}

class _ResetPasswordBodyState extends State<ResetPasswordBody> {
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listenWhen: (p, c) => p.message != c.message || p.status != c.status,
      listener: (context, state) {
        // success/failure messages
        if (state.message != null &&
            (state.status == ResetPasswordStatus.success ||
                state.status == ResetPasswordStatus.failure)) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message!)));
        }
      },
      builder: (context, state) {
        final cubit = context.read<ResetPasswordCubit>();

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButtonIcon(),
                  ),

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
                    controller: _emailController,
                    prefixIcon: Icons.mail_outline,
                    keyboardType: TextInputType.emailAddress,
                    errorText: state.emailError,
                    onChanged: cubit.emailChanged,
                  ),

                  const SizedBox(height: 18),

                  PrimaryButton(
                    text: 'Send Reset Link',
                    isLoading: state.isLoading,
                    onTap: () => cubit.sendResetLink(),
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
      },
    );
  }
}
