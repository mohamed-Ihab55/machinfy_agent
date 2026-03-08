import 'package:flutter/material.dart';
import 'package:machinfy_agent/features/help_support/presentation/view/help_support_screen.dart';
import 'package:machinfy_agent/features/privacy_security/presentation/view/privacy_security_screen.dart';
import 'package:machinfy_agent/features/profile/presentation/view/profile_screen.dart';
import 'package:machinfy_agent/features/setting/presentation/view/settings_screen.dart';
import 'menu_item_tile.dart';

class MenuItemsList extends StatelessWidget {
  const MenuItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        MenuItemTile(
          icon: Icons.person_outline,
          title: 'Profile',
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
          },
        ),
        MenuItemTile(
          icon: Icons.settings_outlined,
          title: 'Settings',
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
          },
        ),
        MenuItemTile(
          icon: Icons.shield_outlined,
          title: 'Privacy & Security',
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const PrivacySecurityScreen()));
          },
        ),
        MenuItemTile(
          icon: Icons.help_outline,
          title: 'Help & Support',
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const HelpSupportScreen()));
          },
        ),
      ],
    );
  }
}