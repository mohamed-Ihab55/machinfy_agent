import 'package:flutter/material.dart';
import 'package:machinfy_agent/features/side_menu/presentation/widgets/menu_header.dart';
import 'package:machinfy_agent/features/side_menu/presentation/widgets/menue_item_list.dart';
import 'package:machinfy_agent/features/side_menu/presentation/widgets/menue_logout.dart';
import 'package:machinfy_agent/features/side_menu/presentation/widgets/menue_user_profile.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            const MenuHeader(),
            const UserProfile(),
            const SizedBox(height: 10),
            const Expanded(child: MenuItemsList()),
            const LogoutButton(),
          ],
        ),
      ),
    );
  }
}
