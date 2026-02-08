import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:machinfy_agent/core/utils/primary_button.dart';
import 'package:machinfy_agent/core/utils/text_button_icon.dart';

import 'package:machinfy_agent/features/authentication/cubit/login/login_cubit.dart';
import 'package:machinfy_agent/features/authentication/cubit/login/login_state.dart';
import 'package:machinfy_agent/features/chat_agent/presentation/view/chat_bot_screen.dart';

import 'login_header.dart';
import 'login_form.dart';
import 'remember_forgot_row.dart';
import 'signup_row.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleState(BuildContext context, LoginState state) {
    if (state.status == LoginStatus.success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ChatBotScreen()),
      );
    } else if (state.status == LoginStatus.failure) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(state.message ?? 'Login failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listenWhen: (p, c) => p.status != c.status,
      listener: _handleState,
      builder: (context, state) {
        final cubit = context.read<LoginCubit>();

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: TextButtonIcon(),
                    ),
                    const SizedBox(height: 70),

                    const LoginHeader(),
                    const SizedBox(height: 28),

                    LoginForm(
                      emailController: _emailController,
                      passwordController: _passwordController,
                      state: state,
                      onEmailChanged: cubit.emailChanged,
                      onPasswordChanged: cubit.passwordChanged,
                      onTogglePassword: cubit.togglePasswordVisibility,
                    ),

                    const SizedBox(height: 10),

                    RememberForgotRow(
                      rememberMe: state.rememberMe,
                      onRememberChanged: cubit.toggleRememberMe,
                    ),

                    const SizedBox(height: 40),

                    PrimaryButton(
                      text: 'Sign In',
                      isLoading: state.isLoading,
                      onTap: cubit.signIn,
                    ),

                    const SizedBox(height: 30),

                    const SignupRow(),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
