import 'package:flutter/material.dart';
import 'package:machinfy_agent/features/help_support/presentation/models/faq_data.dart';
import 'package:machinfy_agent/features/help_support/presentation/models/faq_item_model.dart';
import 'package:machinfy_agent/features/help_support/presentation/widget/custom_appbar.dart';
import 'package:machinfy_agent/features/help_support/presentation/widget/faq_empty_state.dart';
import 'package:machinfy_agent/features/help_support/presentation/widget/faq_list.dart';
import 'package:machinfy_agent/features/help_support/presentation/widget/faq_search_section.dart';
import 'package:machinfy_agent/features/help_support/presentation/widget/faqs_category_section.dart';

class FAQsBodyScreen extends StatefulWidget {
  const FAQsBodyScreen({super.key});

  @override
  State<FAQsBodyScreen> createState() => _FAQsBodyScreenState();
}

class _FAQsBodyScreenState extends State<FAQsBodyScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';
  String _selectedCategory = 'All';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<FAQItem> get filteredFAQs {
    final query = _searchQuery.trim().toLowerCase();
    final selected = _selectedCategory.trim().toLowerCase();

    return FAQData.faqs.where((faq) {
      final category = faq.category.trim().toLowerCase();
      final question = faq.question.toLowerCase();
      final answer = faq.answer.toLowerCase();

      final matchesCategory = selected == 'all' || category == selected;

      final matchesSearch =
          query.isEmpty || question.contains(query) || answer.contains(query);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    // final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'FAQs'),
      body: Column(
        children: [
          SearchSection(
            controller: _searchController,
            onChanged: (value) => setState(() => _searchQuery = value),
            onClear: () {
              _searchController.clear();
              setState(() => _searchQuery = '');
            },
          ),

          CategorySection(
            selectedCategory: _selectedCategory,
            onCategorySelected: (category) =>
                setState(() => _selectedCategory = category),
          ),

          const Divider(height: 1),

          Expanded(
            child: filteredFAQs.isEmpty
                ? const FAQsEmptyState()
                : FAQList(faqs: filteredFAQs),
          ),
        ],
      ),
    );
  }
}
