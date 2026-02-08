import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machinfy_agent/core/utils/primary_button.dart';
import 'package:machinfy_agent/core/utils/text_button_icon.dart';
import 'package:machinfy_agent/features/authentication/cubit/register/register_cubit.dart';
import 'package:machinfy_agent/features/authentication/cubit/register/register_state.dart';
import 'package:machinfy_agent/features/authentication/presentation/widgets/auth_text_field.dart';
import 'package:machinfy_agent/features/profile/presentation/view/profile_screen.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody();

  @override
  State<RegisterBody> createState() => RegisterBodyState();
}

class RegisterBodyState extends State<RegisterBody> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listenWhen: (p, c) => p.status != c.status,
      listener: (context, state) {
        if (state.status == RegisterStatus.success) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const ProfileScreen()),
          );
        } else if (state.status == RegisterStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message ?? 'Registration failed')),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<RegisterCubit>();

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: TextButtonIcon(),
                  ),
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
                    controller: _nameController,
                    prefixIcon: Icons.person_outline,
                    errorText: state.nameError,
                    onChanged: cubit.nameChanged,
                  ),

                  const SizedBox(height: 16),

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
                    hint: 'Minimum 8 characters',
                    controller: _passwordController,
                    prefixIcon: Icons.lock_outline,
                    obscureText: state.isPasswordHidden,
                    suffixIcon: state.isPasswordHidden
                        ? Icons.remove_red_eye_outlined
                        : Icons.visibility_off_outlined,
                    onSuffixTap: cubit.togglePassword,
                    errorText: state.passwordError,
                    onChanged: cubit.passwordChanged,
                  ),

                  const SizedBox(height: 16),

                  AuthTextField(
                    label: 'Confirm Password',
                    hint: 'Re-enter your password',
                    controller: _confirmController,
                    prefixIcon: Icons.lock_outline,
                    obscureText: state.isConfirmHidden,
                    suffixIcon: state.isConfirmHidden
                        ? Icons.remove_red_eye_outlined
                        : Icons.visibility_off_outlined,
                    onSuffixTap: cubit.toggleConfirmPassword,
                    errorText: state.confirmError,
                    onChanged: cubit.confirmPasswordChanged,
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Checkbox(
                        value: state.acceptTerms,
                        onChanged: cubit.toggleTerms,
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

                  if (state.termsError != null) ...[
                    const SizedBox(height: 6),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        state.termsError!,
                        style: const TextStyle(
                          fontSize: 11.5,
                          height: 1.1,
                          color: Color(0xFFEF4444),
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 40),

                  PrimaryButton(
                    text: 'Create Account',
                    isLoading: state.isLoading,
                    onTap: () => cubit.createAccount(),
                  ),

                  const SizedBox(height: 18),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account? ',
                        style: TextStyle(
                          fontSize: 12.5,
                          color: Color(0xFF6B7280),
                        ),
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
      },
    );
  }
}
