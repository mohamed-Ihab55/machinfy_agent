import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:machinfy_agent/core/constants.dart';
import 'package:machinfy_agent/features/profile/presentation/view/edit_screen.dart';
import 'package:machinfy_agent/features/profile/presentation/widgets/profile_info_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ProfileInfoTile(
                    icon: Icons.person_outline,
                    label: 'Full Name',
                    value: user?.displayName ?? 'No Name',
                    onTap: () {},
                  ),
                  ProfileInfoTile(
                    icon: Icons.email_outlined,
                    label: 'Email',
                    value: user?.email ?? 'No Email',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Edit Profile Button
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfileScreen(),
                    ),
                  );

                  if (result == true) {
                    setState(() {}); // إعادة بناء الشاشة وتحديث البيانات
                  }
                },
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
