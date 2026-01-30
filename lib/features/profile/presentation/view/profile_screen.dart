import 'package:flutter/material.dart';
import 'package:machinfy_agent/core/constants.dart';
import 'package:machinfy_agent/core/typography.dart';
import 'package:machinfy_agent/features/profile/presentation/widgets/profile_info_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            // Profile Picture
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: kSecondaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: kSendAndCircularIndicator,
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: kTextColor.withValues(alpha: 0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'ME',
                        style: Style.headingLarge.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: kPrimaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: kSendAndCircularIndicator,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('Mohamed Ehab', style: Style.bodyLarge),
            const SizedBox(height: 8),
            const Text('mehab1638@gmail.com', style: Style.bodysmall),
            const SizedBox(height: 30),

            // Profile Information
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ProfileInfoTile(
                    icon: Icons.person_outline,
                    label: 'Full Name',
                    value: 'Mohamed Ehab',
                    onTap: () {},
                  ),
                  ProfileInfoTile(
                    icon: Icons.email_outlined,
                    label: 'Email',
                    value: 'mehab1638@gmail.com',
                    onTap: () {},
                  ),
                  ProfileInfoTile(
                    icon: Icons.phone_outlined,
                    label: 'Phone',
                    value: '+20 123 456 7890',
                    onTap: () {},
                  ),
                  ProfileInfoTile(
                    icon: Icons.location_on_outlined,
                    label: 'Location',
                    value: 'Cairo, Egypt',
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Edit Profile Button
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: kSendAndCircularIndicator,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
