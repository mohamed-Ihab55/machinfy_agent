import 'package:flutter/material.dart';
import 'package:machinfy_agent/core/constants.dart';
import 'package:machinfy_agent/features/help_support/presentation/models/faq_item_model.dart';

class CleanFAQCard extends StatefulWidget {
  final FAQItem faq;
  final bool isDark;

  const CleanFAQCard({super.key, required this.faq, required this.isDark});

  @override
  State<CleanFAQCard> createState() => _CleanFAQCardState();
}

class _CleanFAQCardState extends State<CleanFAQCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: widget.isDark ? kDarkSurfaceColor : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isExpanded
                ? kPrimaryColor
                : widget.isDark
                ? Colors.white.withValues(alpha: 0.1)
                : Colors.grey[200]!,
            width: _isExpanded ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    widget.faq.question,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Icon(
                  _isExpanded ? Icons.remove : Icons.add,
                  color: kPrimaryColor,
                  size: 24,
                ),
              ],
            ),
            if (_isExpanded) ...[
              const SizedBox(height: 16),
              Text(
                widget.faq.answer,
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.6,
                  color: widget.isDark ? Colors.white70 : Colors.grey[700],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
