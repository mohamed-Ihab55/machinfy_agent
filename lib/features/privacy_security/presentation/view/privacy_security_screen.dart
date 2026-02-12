import 'package:flutter/material.dart';
import 'package:machinfy_agent/features/authentication/presentation/views/reset_password.dart';
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
              );
            },
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
