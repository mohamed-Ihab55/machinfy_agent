import 'package:flutter/material.dart';
import 'package:machinfy_agent/core/typography.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Style.bodyLarge.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }
}
