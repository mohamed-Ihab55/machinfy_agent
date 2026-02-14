import 'package:flutter/material.dart';
import 'package:machinfy_agent/core/constants.dart';
import 'package:machinfy_agent/features/help_support/presentation/widget/documentation_screen_details.dart';

class DocumentationScreen extends StatelessWidget {
  const DocumentationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Documentation'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Getting Started
          _buildSection(
            context,
            theme: theme,
            isDark: isDark,
            title: 'Getting Started',
            icon: Icons.rocket_launch_outlined,
            color: const Color(0xFF2196F3),
            items: ['Introduction', 'Create Account', 'First Steps'],
          ),

          const SizedBox(height: 16),

          // Using AI Advisor
          _buildSection(
            context,
            theme: theme,
            isDark: isDark,
            title: 'Using AI Advisor',
            icon: Icons.chat_outlined,
            color: const Color(0xFF9C27B0),
            items: ['How to Chat', 'Get Recommendations', 'Advanced Tips'],
          ),

          const SizedBox(height: 16),

          // Courses
          _buildSection(
            context,
            theme: theme,
            isDark: isDark,
            title: 'Courses',
            icon: Icons.school_outlined,
            color: const Color(0xFF4CAF50),
            items: ['Browse Courses', 'Enroll in Course', 'Track Progress'],
          ),

          const SizedBox(height: 16),

          // Account
          _buildSection(
            context,
            theme: theme,
            isDark: isDark,
            title: 'Your Account',
            icon: Icons.person_outline,
            color: const Color(0xFFFF9800),
            items: ['Manage Profile', 'Settings', 'Security'],
          ),

          const SizedBox(height: 16),

          // Help
          _buildSection(
            context,
            theme: theme,
            isDark: isDark,
            title: 'Need Help?',
            icon: Icons.help_outline,
            color: const Color(0xFFF44336),
            items: ['Common Issues', 'Contact Support'],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required ThemeData theme,
    required bool isDark,
    required String title,
    required IconData icon,
    required Color color,
    required List<String> items,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? kDarkSurfaceColor : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.grey[200]!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Divider(
            height: 1,
            indent: 20,
            endIndent: 20,
            color: isDark
                ? Colors.white.withValues(alpha: 0.1)
                : Colors.grey[200],
          ),

          // Items
          ...items.map(
            (item) => _buildDocItem(
              context,
              theme: theme,
              isDark: isDark,
              title: item,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocItem(
    BuildContext context, {
    required ThemeData theme,
    required bool isDark,
    required String title,
    required Color color,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DocDetailScreen(title: title, color: color),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: isDark ? Colors.white38 : Colors.grey[400],
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
