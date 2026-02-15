import 'package:flutter/material.dart';
import 'package:machinfy_agent/features/help_support/presentation/models/faq_item_model.dart';

class FAQList extends StatelessWidget {
  final List<FAQItem> faqs;

  const FAQList({super.key, required this.faqs});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: faqs.length,
      itemBuilder: (_, index) {
        final faq = faqs[index];
        return ExpansionTile(
          title: Text(faq.question),
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(faq.answer),
            ),
          ],
        );
      },
    );
  }
}
