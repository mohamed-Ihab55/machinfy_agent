import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:machinfy_agent/core/utils/primary_button.dart';

import 'package:machinfy_agent/features/authentication/cubit/reset_password/reset_password_cubit.dart';
import 'package:machinfy_agent/features/authentication/cubit/reset_password/reset_password_state.dart';

import 'reset_password_header.dart';
import 'reset_password_form.dart';
import 'back_to_signin_link.dart';

class ResetPasswordBody extends StatefulWidget {
  const ResetPasswordBody({super.key});

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

  void _handleState(BuildContext context, ResetPasswordState state) {
    final msg = state.message;
    if (msg == null) return;

    if (state.status == ResetPasswordStatus.success) {
      _showResultDialog(
        context,
        title: "Success",
        message: msg,
        isSuccess: true,
      );
    }

    if (state.status == ResetPasswordStatus.failure) {
      _showResultDialog(
        context,
        title: "Error",
        message: msg,
        isSuccess: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listenWhen: (p, c) => p.message != c.message || p.status != c.status,
      listener: _handleState,
      builder: (context, state) {
        final cubit = context.read<ResetPasswordCubit>();

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 90),

                  const ResetPasswordHeader(),

                  const SizedBox(height: 28),

                  ResetPasswordForm(
                    emailController: _emailController,
                    emailError: state.emailError,
                    onEmailChanged: cubit.emailChanged,
                  ),

                  const SizedBox(height: 18),

                  PrimaryButton(
                    text: 'Send Reset Link',
                    isLoading: state.isLoading,
                    onTap: cubit.sendResetLink,
                  ),

                  const SizedBox(height: 18),

                  const BackToSignInLink(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

void _showResultDialog(
  BuildContext context, {
  required String title,
  required String message,
  required bool isSuccess,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(
              isSuccess ? Icons.check_circle : Icons.error,
              color: isSuccess ? Colors.green : Colors.red,
            ),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);

              // لو نجح نرجع لصفحة تسجيل الدخول
              if (isSuccess) {
                Navigator.pop(context);
              }
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}
