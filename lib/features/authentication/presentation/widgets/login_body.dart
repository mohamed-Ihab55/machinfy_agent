import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machinfy_agent/core/utils/primary_button.dart';
import 'package:machinfy_agent/core/utils/text_button_icon.dart';
import 'package:machinfy_agent/features/authentication/cubit/login/login_cubit.dart';
import 'package:machinfy_agent/features/authentication/cubit/login/login_state.dart';
import 'package:machinfy_agent/features/authentication/presentation/views/register_screen.dart';
import 'package:machinfy_agent/features/authentication/presentation/views/reset_password.dart';
import 'package:machinfy_agent/features/authentication/presentation/widgets/auth_text_field.dart';
import 'package:machinfy_agent/features/chat_agent/presentation/view/chat_bot_screen.dart';

class LoginBody extends StatefulWidget {
  const LoginBody();

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

                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Sign in to continue your learning journey',
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
                        ),
                        const Text(
                          'Remember me',
                          style: TextStyle(
                            fontSize: 12.5,
                            color: Color(0xFF6B7280),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2563EB),
                            ),
                          ),
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
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            fontSize: 12.5,
                            color: Color(0xFF6B7280),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const RegisterScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 12.5,
                              color: Color(0xFF2563EB),
                              fontWeight: FontWeight.w800,
                              decoration: TextDecoration.underline,
                              decorationThickness: 1.2,
                            ),
                          ),
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
