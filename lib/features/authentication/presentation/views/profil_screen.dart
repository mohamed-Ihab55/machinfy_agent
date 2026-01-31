import 'package:flutter/material.dart';
import 'package:machinfy_agent/core/utils/primary_button.dart';
import 'package:machinfy_agent/features/authentication/models/profile_view_model.dart';
import 'package:machinfy_agent/features/authentication/presentation/widgets/auth_text_field.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileViewModel(),
      child: const _ProfileBody(),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  const _ProfileBody();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProfileViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AppBar بسيط زي الصورة
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, size: 22),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF111827),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Avatar + Change Photo
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
                          color: const Color(0xFF2563EB),
                          width: 2.5,
                        ),
                      ),
                      child: Text(
                        vm.initials(),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF2563EB),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: vm.changePhoto,
                      child: const Text(
                        'Change Photo',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2563EB),
                          decoration: TextDecoration.underline,
                          decorationThickness: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              AuthTextField(
                label: 'Full Name',
                hint: 'Your name',
                controller: vm.nameController,
                prefixIcon: Icons.person_outline,
              ),
              const SizedBox(height: 14),

              AuthTextField(
                label: 'Email Address',
                hint: 'name@company.com',
                controller: vm.emailController,
                prefixIcon: Icons.mail_outline,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 14),

              AuthTextField(
                label: 'Phone Number',
                hint: '+20 123 456 7890',
                controller: vm.phoneController,
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 14),

              // Bio (Multi-line)
              const Text(
                'Bio',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: vm.bioController,
                maxLines: 5,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF111827),
                ),
                decoration: InputDecoration(
                  hintText: 'Tell us about yourself...',
                  hintStyle: const TextStyle(
                    fontSize: 13.5,
                    color: Color(0xFF9CA3AF),
                    fontWeight: FontWeight.w500,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF9FAFB),
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
                      color: Color(0xFF2563EB),
                      width: 1.2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              PrimaryButton(
                text: 'Save Changes',
                isLoading: vm.isLoading,
                onTap: vm.saveChanges,
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
