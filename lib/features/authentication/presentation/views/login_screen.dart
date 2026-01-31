import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machinfy_agent/core/config.dart';
import 'package:machinfy_agent/core/utils/primary_button.dart';
import 'package:machinfy_agent/core/utils/text_button_icon.dart';
import 'package:machinfy_agent/features/authentication/presentation/views/creat_account.dart';
import 'package:machinfy_agent/features/authentication/presentation/views/reset_password.dart';
import 'package:machinfy_agent/features/authentication/presentation/widgets/auth_text_field.dart';
import 'package:machinfy_agent/features/authentication/models/login_view_model.dart';
import 'package:machinfy_agent/features/chat_agent/cubit/chat_cubit.dart';
import 'package:machinfy_agent/features/chat_agent/presentation/view/chat_bot_screen.dart';
import 'package:machinfy_agent/features/chat_agent/services/openai_service.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: const _LoginBody(),
    );
  }
}

class _LoginBody extends StatelessWidget {
  const _LoginBody();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LoginViewModel>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Top back
                Align(alignment: Alignment.centerLeft, child: TextButtonIcon()),
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
                  controller: vm.emailController,
                  prefixIcon: Icons.mail_outline,
                  keyboardType: TextInputType.emailAddress,
                  errorText: vm.emailError,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: AuthTextField(
                        label: 'Password',
                        hint: 'Enter your password',
                        controller: vm.passwordController,
                        prefixIcon: Icons.lock_outline,
                        obscureText: vm.isPasswordHidden,
                        suffixIcon: vm.isPasswordHidden
                            ? Icons.remove_red_eye_outlined
                            : Icons.visibility_off_outlined,
                        onSuffixTap: vm.togglePasswordVisibility,
                        errorText: vm.passwordError,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                Row(
                  children: [
                    Checkbox(
                      value: vm.rememberMe,
                      onChanged: vm.toggleRememberMe,
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
                    Spacer(),
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

                  onTap: () {
                    vm.signIn();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ChatBotScreen()),
                    );
                  },
                  isLoading: vm.isLoading,
                ),
                SizedBox(height: 30),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
