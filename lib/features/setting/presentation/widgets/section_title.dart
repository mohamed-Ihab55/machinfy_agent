import 'package:flutter/material.dart';
import 'package:machinfy_agent/core/typography.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(title, style: Style.headingMedium),
    );
  }
}
