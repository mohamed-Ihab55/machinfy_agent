import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:machinfy_agent/core/typography.dart';
import 'package:machinfy_agent/core/constants.dart';

import 'package:machinfy_agent/core/utils/primary_button.dart';
import 'package:machinfy_agent/features/authentication/cubit/profile/profile_cubit.dart';
import 'package:machinfy_agent/features/authentication/cubit/profile/profile_state.dart';
import 'package:machinfy_agent/features/authentication/presentation/widgets/auth_text_field.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => ProfileBodyState();
}

class ProfileBodyState extends State<ProfileBody> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    final state = context.read<ProfileCubit>().state;

    _nameController = TextEditingController(text: state.name);
    _emailController = TextEditingController(text: state.email);
    _phoneController = TextEditingController(text: state.phone);
    _bioController = TextEditingController(text: state.bio);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listenWhen: (p, c) => p.message != c.message || p.status != c.status,
      listener: (context, state) {
        final msg = state.message;
        if (msg == null) return;

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(msg)));
      },
      builder: (context, state) {
        final cubit = context.read<ProfileCubit>();

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back, size: 22),
                      ),
                      const SizedBox(width: 4),
                      Text('Profile', style: Style.appBarTitle),
                    ],
                  ),
                  const Divider(
                    height: 18,
                    thickness: 1,
                    color: Color(0xFFE5E7EB),
                  ),
                  const SizedBox(height: 16),

                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 86,
                          height: 86,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: kPrimaryColor,
                              width: 2.5,
                            ),
                          ),
                          child: Text(
                            cubit.initials(),
                            style: Style.bodyLarge.copyWith(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: cubit.changePhoto,
                          child: Text('Change Photo', style: Style.link),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 22),

                  AuthTextField(
                    label: 'Full Name',
                    hint: 'Ahmed Hassan',
                    controller: _nameController,
                    prefixIcon: Icons.person_outline,
                    onChanged: cubit.nameChanged,
                  ),
                  const SizedBox(height: 14),

                  AuthTextField(
                    label: 'Email Address',
                    hint: 'name@company.com',
                    controller: _emailController,
                    prefixIcon: Icons.mail_outline,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: cubit.emailChanged,
                  ),
                  const SizedBox(height: 14),

                  AuthTextField(
                    label: 'Phone Number',
                    hint: '+20 123 456 7890',
                    controller: _phoneController,
                    prefixIcon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    onChanged: cubit.phoneChanged,
                  ),
                  const SizedBox(height: 14),

                  Text('Bio', style: Style.fieldLabel),
                  const SizedBox(height: 8),

                  TextFormField(
                    controller: _bioController,
                    maxLines: 5,
                    onChanged: cubit.bioChanged,
                    style: Style.fieldText,
                    decoration: InputDecoration(
                      hintText: 'Tell us about yourself...',
                      hintStyle: Style.fieldHint,
                      filled: true,
                      fillColor: Colors.transparent,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 14,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: kPrimaryColor,
                          width: 1.2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  PrimaryButton(
                    text: 'Save Changes',
                    isLoading: state.isLoading,
                    onTap: () => cubit.saveChanges(),
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
