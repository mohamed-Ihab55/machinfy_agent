import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:machinfy_agent/core/typography.dart';
import 'package:machinfy_agent/core/constants.dart';
import 'package:machinfy_agent/core/utils/primary_button.dart';

import 'package:machinfy_agent/features/profile/cubit/profile/profile_cubit.dart';
import 'package:machinfy_agent/features/profile/cubit/profile/profile_state.dart';
import 'package:machinfy_agent/features/authentication/presentation/widgets/auth_text_field.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => ProfileBodyState();
}

class ProfileBodyState extends State<ProfileBody> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;

  bool _seeded = false; // علشان نعبي الكنترولرز مرة واحدة من Firebase

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listenWhen: (p, c) =>
          p.message != c.message ||
          p.status != c.status ||
          p.name != c.name ||
          p.email != c.email,
      listener: (context, state) {
        if (!_seeded && (state.name.isNotEmpty || state.email.isNotEmpty)) {
          _seeded = true;
          _nameController.text = state.name;
          _emailController.text = state.email;
        }

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
                        Text(
                          'Change Photo',
                          style: Style.link.copyWith(
                            color: Style.link.color?.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 22),

                  AuthTextField(
                    label: 'Full Name',
                    hint: state.name.isEmpty ? 'No Name' : state.name,
                    controller: _nameController,
                    prefixIcon: Icons.person_outline,
                    onChanged: cubit.nameChanged,
                  ),
                  const SizedBox(height: 14),

                  // الأفضل الإيميل يبقى Read-only
                  // لأنه تغييره في FirebaseAuth غالبًا يحتاج re-auth / verify
                  AuthTextField(
                    label: 'Email Address',
                    hint: state.email.isEmpty ? 'No Email' : state.email,
                    controller: _emailController,
                    prefixIcon: Icons.mail_outline,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (_) {}, // متمنعش لو Widget مفيهوش enabled
                    // لو AuthTextField بيدعم readOnly/ enabled استخدمه:
                    // enabled: false,
                    // readOnly: true,
                  ),
                  const SizedBox(height: 18),

                  PrimaryButton(
                    text: 'Save Changes',
                    isLoading: state.isLoading,
                    onTap: cubit.saveChanges,
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
