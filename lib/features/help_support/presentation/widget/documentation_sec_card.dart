import 'package:flutter/material.dart';
import 'package:machinfy_agent/core/constants.dart';
import 'package:machinfy_agent/features/help_support/presentation/models/documentation_section_model.dart';
import 'package:machinfy_agent/features/help_support/presentation/widget/doc_item_tile.dart';
import 'package:machinfy_agent/features/help_support/presentation/widget/doc_section_header.dart';

class DocSectionCard extends StatelessWidget {
  final DocSection section;

  const DocSectionCard({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? kDarkSurfaceColor : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          SectionHeader(section: section),
          Divider(
            height: 1,
            indent: 20,
            endIndent: 20,
            color: isDark
                ? Colors.white.withValues(alpha: 0.1)
                : Colors.grey.shade200,
          ),
          ...section.items.map(
            (item) => DocItemTile(title: item, color: section.color),
          ),
        ],
      ),
    );
  }
}
