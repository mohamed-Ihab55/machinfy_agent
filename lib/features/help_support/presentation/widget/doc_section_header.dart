import 'package:flutter/material.dart';
import 'package:machinfy_agent/features/help_support/presentation/models/documentation_section_model.dart';

class SectionHeader extends StatelessWidget {
  final DocSection section;

  const SectionHeader({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: section.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(section.icon, color: section.color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              section.title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
