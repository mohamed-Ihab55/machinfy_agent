import 'package:flutter/material.dart';

class FAQsEmptyState extends StatelessWidget {
  const FAQsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No results found'),
    );
  }
}
