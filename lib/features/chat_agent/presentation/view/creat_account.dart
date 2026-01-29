import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machinfy_agent/features/chat_agent/presentation/widget/auth_text_field.dart';
import 'package:machinfy_agent/features/chat_agent/presentation/widget/primary_button.dart';
import 'package:machinfy_agent/features/chat_agent/presentation/widget/text_button_icon.dart';
import 'package:machinfy_agent/model/viewModel/register_view_model';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterViewModel(),
      child: const _RegisterBody(),
    );
  }
}

class _RegisterBody extends StatelessWidget {
  const _RegisterBody();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<RegisterViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Align(alignment: Alignment.centerLeft, child: TextButtonIcon()),
              const SizedBox(height: 20),

              const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Start your AI learning journey today',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF6B7280),
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 28),

              AuthTextField(
                label: 'Full Name',
                hint: 'John Doe',
                controller: vm.nameController,
                prefixIcon: Icons.person_outline,
                errorText: vm.nameError,
              ),

              const SizedBox(height: 16),

              AuthTextField(
                label: 'Email Address',
                hint: 'name@company.com',
                controller: vm.emailController,
                prefixIcon: Icons.mail_outline,
                keyboardType: TextInputType.emailAddress,
                errorText: vm.emailError,
              ),

              const SizedBox(height: 16),

              AuthTextField(
                label: 'Password',
                hint: 'Minimum 8 characters',
                controller: vm.passwordController,
                prefixIcon: Icons.lock_outline,
                obscureText: vm.isPasswordHidden,
                suffixIcon: vm.isPasswordHidden
                    ? Icons.remove_red_eye_outlined
                    : Icons.visibility_off_outlined,
                onSuffixTap: vm.togglePassword,
                errorText: vm.passwordError,
              ),

              const SizedBox(height: 16),

              AuthTextField(
                label: 'Confirm Password',
                hint: 'Re-enter your password',
                controller: vm.confirmPasswordController,
                prefixIcon: Icons.lock_outline,
                obscureText: vm.isConfirmHidden,
                suffixIcon: vm.isConfirmHidden
                    ? Icons.remove_red_eye_outlined
                    : Icons.visibility_off_outlined,
                onSuffixTap: vm.toggleConfirmPassword,
                errorText: vm.confirmError,
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Checkbox(
                    value: vm.acceptTerms,
                    onChanged: vm.toggleTerms,
                    activeColor: const Color(0xFF0066CC),
                  ),
                  Expanded(
                    child: Text(
                      'I agree to the Terms of Service and Privacy Policy',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Colors.black.withOpacity(.6),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              PrimaryButton(
                text: 'Create Account',
                isLoading: vm.isLoading,
                onTap: () {
                  vm.createAccount;
                },
              ),

              const SizedBox(height: 18),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account? ',
                    style: TextStyle(fontSize: 12.5, color: Color(0xFF6B7280)),
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0066CC),
                        decoration: TextDecoration.underline,
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
    );
  }
}
