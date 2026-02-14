import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machinfy_agent/core/constants.dart';
import 'package:machinfy_agent/core/typography.dart';
import 'package:machinfy_agent/core/utils/primary_button.dart';

import 'package:machinfy_agent/features/authentication/cubit/register/register_cubit.dart';
import 'package:machinfy_agent/features/authentication/cubit/register/register_state.dart';
import 'package:machinfy_agent/features/authentication/presentation/widgets/auth_text_field.dart';
import 'package:machinfy_agent/features/chat_agent/presentation/view/chat_bot_screen.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key});

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<RegisterCubit>().reset();
    });

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
            MaterialPageRoute(builder: (_) => const ChatBotScreen()),
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
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 100),

                  Text('Create Account', style: Style.headingMedium),
                  const SizedBox(height: 6),
                  Text(
                    'Start your AI learning journey today',
                    style: Style.subTitle,
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
                        activeColor: kPrimaryColor,
                      ),
                      Expanded(
                        child: Text(
                          'I agree to the Terms of Service and Privacy Policy',
                          style: Style.smallGrey.copyWith(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ],
                  ),

                  if (state.termsError != null) ...[
                    const SizedBox(height: 6),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(state.termsError!, style: Style.errorSmall),
                    ),
                  ],

                  const SizedBox(height: 40),

                  PrimaryButton(
                    text: 'Create Account',
                    isLoading: state.isLoading,
                    onTap: () {
                      if (state.isLoading) return;
                      cubit.createAccount();
                    },
                  ),

                  const SizedBox(height: 18),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account? ', style: Style.smallGrey),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Text('Sign In', style: Style.linkUnderline),
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
