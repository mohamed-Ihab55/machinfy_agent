import 'package:flutter/material.dart';
import 'package:machinfy_agent/core/constants.dart';
import 'package:machinfy_agent/features/help_support/presentation/models/faq_data.dart';

class CategorySection extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const CategorySection({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: FAQData.categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, index) {
          final category = FAQData.categories[index];
          final isSelected = category == selectedCategory;

          return FilterChip(
            label: Text(
              category,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isSelected ? Colors.white : null,
              ),
            ),
            selected: isSelected,
            onSelected: (_) => onCategorySelected(category),
            selectedColor: kPrimaryColor,
            checkmarkColor: Colors.white,
          );
        },
      ),
    );
  }
}
