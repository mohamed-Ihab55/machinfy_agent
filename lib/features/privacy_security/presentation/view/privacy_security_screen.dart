import 'package:flutter/material.dart';
import 'package:machinfy_agent/features/setting/presentation/widgets/section_title.dart';
import 'package:machinfy_agent/features/setting/presentation/widgets/setting_tile.dart';
import 'package:machinfy_agent/features/setting/presentation/widgets/switch_setting_tile.dart';

class PrivacySecurityScreen extends StatefulWidget {
  const PrivacySecurityScreen({super.key});

  @override
  State<PrivacySecurityScreen> createState() => _PrivacySecurityScreenState();
}
class _PrivacySecurityScreenState extends State<PrivacySecurityScreen> {
  bool twoFactorAuth = false;
  bool biometricLogin = true;
  bool activityStatus = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Privacy & Security'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SectionTitle(title: 'Security'),
          SwitchSettingTile(
            icon: Icons.security_outlined,
            title: 'Two-Factor Authentication',
            subtitle: 'Add extra security to your account',
            value: twoFactorAuth,
            onChanged: (value) => setState(() => twoFactorAuth = value),
          ),
          SwitchSettingTile(
            icon: Icons.fingerprint_outlined,
            title: 'Biometric Login',
            subtitle: 'Use fingerprint or face ID',
            value: biometricLogin,
            onChanged: (value) => setState(() => biometricLogin = value),
          ),
          SettingTile(
            icon: Icons.vpn_key_outlined,
            title: 'Change Password',
            subtitle: 'Update your password',
            onTap: () {},
          ),

          const SizedBox(height: 30),
          const SectionTitle(title: 'Privacy'),
          SwitchSettingTile(
            icon: Icons.visibility_outlined,
            title: 'Activity Status',
            subtitle: 'Show when you\'re active',
            value: activityStatus,
            onChanged: (value) => setState(() => activityStatus = value),
          ),
          SettingTile(
            icon: Icons.block_outlined,
            title: 'Blocked Users',
            subtitle: 'Manage blocked users',
            onTap: () {},
          ),
          SettingTile(
            icon: Icons.history_outlined,
            title: 'Login History',
            subtitle: 'View recent login activity',
            onTap: () {},
          ),

          const SizedBox(height: 30),
          const SectionTitle(title: 'Data'),
          SettingTile(
            icon: Icons.download_outlined,
            title: 'Download Your Data',
            subtitle: 'Get a copy of your data',
            onTap: () {},
          ),
          SettingTile(
            icon: Icons.delete_outline,
            title: 'Delete Account',
            subtitle: 'Permanently delete your account',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
