import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:machinfy_agent/core/typography.dart';
import 'package:machinfy_agent/core/constants.dart';

import 'package:machinfy_agent/core/utils/primary_button.dart';
import 'package:machinfy_agent/core/utils/text_button_icon.dart';
import 'package:machinfy_agent/features/authentication/cubit/login/login_cubit.dart';
import 'package:machinfy_agent/features/authentication/cubit/login/login_state.dart';
import 'package:machinfy_agent/features/authentication/presentation/views/register_screen.dart';
import 'package:machinfy_agent/features/authentication/presentation/views/reset_password.dart';
import 'package:machinfy_agent/features/authentication/presentation/widgets/auth_text_field.dart';
import 'package:machinfy_agent/features/chat_agent/presentation/view/chat_bot_screen.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => LoginBodyState();
}

class LoginBodyState extends State<LoginBody> {
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        if (state.status == LoginStatus.success) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const ChatBotScreen()),
          );
        } else if (state.status == LoginStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message ?? 'Login failed')),
          );
        }
      },
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

                    Text('Welcome Back', style: Style.headingMedium),
                    const SizedBox(height: 6),
                    Text(
                      'Sign in to continue your learning journey',
                      style: Style.subTitle,
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

                    const SizedBox(height: 16),

                    AuthTextField(
                      label: 'Password',
                      hint: 'Enter your password',
                      controller: _passwordController,
                      prefixIcon: Icons.lock_outline,
                      obscureText: state.isPasswordHidden,
                      suffixIcon: state.isPasswordHidden
                          ? Icons.remove_red_eye_outlined
                          : Icons.visibility_off_outlined,
                      onSuffixTap: cubit.togglePasswordVisibility,
                      errorText: state.passwordError,
                      onChanged: cubit.passwordChanged,
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Checkbox(
                          value: state.rememberMe,
                          onChanged: cubit.toggleRememberMe,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          activeColor: kPrimaryColor,
                        ),
                        Text('Remember me', style: Style.smallGrey),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ResetPasswordScreen(),
                              ),
                            );
                          },
                          child: Text('Forgot Password?', style: Style.link),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    PrimaryButton(
                      text: 'Sign In',
                      isLoading: state.isLoading,
                      onTap: () => cubit.signIn(),
                    ),

                    const SizedBox(height: 30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account? ", style: Style.smallGrey),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const RegisterScreen(),
                              ),
                            );
                          },
                          child: Text('Sign Up', style: Style.linkUnderline),
                        ),
                      ],
                    ),

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
