import 'package:flutter/material.dart';
import 'package:machinfy_agent/features/help_support/presentation/widget/documentation_screen_details.dart';

class DocItemTile extends StatelessWidget {
  final String title;
  final Color color;

  const DocItemTile({
    super.key,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DocDetailScreen(
              title: title,
              color: color,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: isDark ? Colors.white38 : Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
