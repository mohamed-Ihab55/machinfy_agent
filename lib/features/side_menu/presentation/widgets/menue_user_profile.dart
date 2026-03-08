import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:machinfy_agent/core/constants.dart';
import 'package:machinfy_agent/core/typography.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              shape: BoxShape.circle,
              border: Border.all(color: kBorderTextField!, width: 2),
            ),
            child: Center(
              child: Text('ME', style: Style.bodysmall.copyWith(color: Colors.white)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                final user = snapshot.data;
                final name = (user?.displayName?.trim().isNotEmpty ?? false)
                    ? user!.displayName!.trim()
                    : user?.email?.split('@').first ?? 'User';
                final email = user?.email ?? '';
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: Style.bodysmall.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      style: Style.bodysmall.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}