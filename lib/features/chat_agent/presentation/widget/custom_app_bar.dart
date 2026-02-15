import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:machinfy_agent/core/assets.dart';
import 'package:machinfy_agent/core/typography.dart';
import 'package:machinfy_agent/features/profile/cubit/profile/profile_cubit.dart';
import 'package:machinfy_agent/features/profile/cubit/profile/profile_state.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (p, c) => p.name != c.name || p.email != c.email,
      builder: (context, state) {
        final user = FirebaseAuth.instance.currentUser;

        final fallbackName = (user?.displayName?.trim().isNotEmpty ?? false)
            ? user!.displayName!.trim()
            : (user?.email?.split('@').first ?? 'User');

        final name = state.name.trim().isNotEmpty
            ? state.name.trim()
            : (state.email.trim().isNotEmpty
                  ? state.email.split('@').first
                  : fallbackName);

        return AppBar(
          title: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Image.asset(AssetsData.logo, height: 20, width: 20),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Course Advisor', style: Style.bodyLarge),
                  Text('Welcome, $name', style: Style.bodysmall),
                ],
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, size: 35),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
