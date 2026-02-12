import 'package:flutter/material.dart';
import 'package:machinfy_agent/core/theme/theme_provider.dart';
import 'package:machinfy_agent/features/setting/presentation/widgets/about_screen.dart';
import 'package:machinfy_agent/features/setting/presentation/widgets/section_title.dart';
import 'package:machinfy_agent/features/setting/presentation/widgets/setting_tile.dart';
import 'package:machinfy_agent/features/setting/presentation/widgets/storage_screen.dart';
import 'package:machinfy_agent/features/setting/presentation/widgets/switch_setting_tile.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

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
            value: themeProvider.isDarkMode,
            onChanged: (value) => context.read<ThemeProvider>().setDarkMode(value),
          ),
          SettingTile(
            icon: Icons.language_outlined,
            title: 'Language',
            subtitle: 'English',
            onTap: () {},
          ),

          const SizedBox(height: 30),
          const SectionTitle(title: 'Other'),
          SettingTile(
            icon: Icons.storage_outlined,
            title: 'Storage',
            subtitle: 'Manage app storage',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return StorageScreen();
                  },
                ),
              );
            },
          ),
          SettingTile(
            icon: Icons.info_outline,
            title: 'About',
            subtitle: 'App version 1.0.0',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AboutScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
