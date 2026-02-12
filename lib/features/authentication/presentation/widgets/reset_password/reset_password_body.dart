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

    if (state.status == ResetPasswordStatus.success ||
        state.status == ResetPasswordStatus.failure) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
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
