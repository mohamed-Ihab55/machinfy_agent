import 'package:flutter/material.dart';
import 'package:machinfy_agent/core/constants.dart';
import 'package:machinfy_agent/core/typography.dart';

class MenuItemTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const MenuItemTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Row(
          children: [
            Icon(icon, color: kLabelText, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: Style.bodyLarge.copyWith(
                  color: kTextColor.withValues(alpha: 0.7),
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: kLabelText, size: 24),
          ],
        ),
      ),
    );
  }
}
