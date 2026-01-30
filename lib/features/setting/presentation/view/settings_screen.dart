import 'package:flutter/material.dart';
import 'package:machinfy_agent/features/setting/presentation/widgets/section_title.dart';
import 'package:machinfy_agent/features/setting/presentation/widgets/setting_tile.dart';
import 'package:machinfy_agent/features/setting/presentation/widgets/switch_setting_tile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}
class _SettingsScreenState extends State<SettingsScreen> {
  bool darkMode = false;
  bool notifications = true;
  bool emailNotifications = true;
  bool soundEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SectionTitle(title: 'Appearance'),
          SwitchSettingTile(
            icon: Icons.dark_mode_outlined,
            title: 'Dark Mode',
            subtitle: 'Enable dark theme',
            value: darkMode,
            onChanged: (value) => setState(() => darkMode = value),
          ),
          SettingTile(
            icon: Icons.language_outlined,
            title: 'Language',
            subtitle: 'English',
            onTap: () {},
          ),

          const SizedBox(height: 30),
          const SectionTitle(title: 'Notifications'),
          SwitchSettingTile(
            icon: Icons.notifications_outlined,
            title: 'Push Notifications',
            subtitle: 'Receive push notifications',
            value: notifications,
            onChanged: (value) => setState(() => notifications = value),
          ),
          SwitchSettingTile(
            icon: Icons.email_outlined,
            title: 'Email Notifications',
            subtitle: 'Receive email updates',
            value: emailNotifications,
            onChanged: (value) => setState(() => emailNotifications = value),
          ),
          SwitchSettingTile(
            icon: Icons.volume_up_outlined,
            title: 'Sound',
            subtitle: 'Enable notification sounds',
            value: soundEnabled,
            onChanged: (value) => setState(() => soundEnabled = value),
          ),

          const SizedBox(height: 30),
          const SectionTitle(title: 'Account'),
          SettingTile(
            icon: Icons.lock_outline,
            title: 'Change Password',
            subtitle: 'Update your password',
            onTap: () {},
          ),
          SettingTile(
            icon: Icons.devices_outlined,
            title: 'Connected Devices',
            subtitle: 'Manage your devices',
            onTap: () {},
          ),

          const SizedBox(height: 30),
          const SectionTitle(title: 'Other'),
          SettingTile(
            icon: Icons.storage_outlined,
            title: 'Storage',
            subtitle: 'Manage app storage',
            onTap: () {},
          ),
          SettingTile(
            icon: Icons.info_outline,
            title: 'About',
            subtitle: 'App version 1.0.0',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
