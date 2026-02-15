import 'package:flutter/material.dart';
import 'package:machinfy_agent/features/help_support/presentation/models/documentation_data.dart';
import 'package:machinfy_agent/features/help_support/presentation/widget/custom_appbar.dart';
import 'package:machinfy_agent/features/help_support/presentation/widget/documentation_Sec_card.dart';

class DocumentationScreen extends StatelessWidget {
  const DocumentationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Documentation'),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: DocumentationData.sections.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          return DocSectionCard(
            section: DocumentationData.sections[index],
          );
        },
      ),
    );
  }
}
