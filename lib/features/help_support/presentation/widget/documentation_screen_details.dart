import 'package:flutter/material.dart';
import 'package:machinfy_agent/core/constants.dart';

class DocDetailScreen extends StatelessWidget {
  final String title;
  final Color color;

  const DocDetailScreen({
    super.key,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Content Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
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
                  // Icon
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getIconForTitle(title),
                      color: color,
                      size: 32,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Title
                  Text(
                    title,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Content
                  Text(
                    _getContentForTitle(title),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      height: 1.8,
                      color: isDark ? Colors.white70 : Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Steps (if applicable)
            if (_hasSteps(title)) ...[
              Text(
                'Steps',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ..._getStepsForTitle(title).asMap().entries.map((entry) {
                return _buildStep(
                  context,
                  theme: theme,
                  isDark: isDark,
                  number: entry.key + 1,
                  text: entry.value,
                  color: color,
                );
              }),
            ],

            const SizedBox(height: 24),

            // Help Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: color.withValues(alpha: isDark ? 0.15 : 0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: color.withValues(alpha: isDark ? 0.3 : 0.2),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.lightbulb_outline, color: color, size: 24),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Need more help? Contact our support team anytime.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isDark ? Colors.white70 : Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(
    BuildContext context, {
    required ThemeData theme,
    required bool isDark,
    required int number,
    required String text,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? kDarkSurfaceColor : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark 
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.grey[200]!,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$number',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                text,
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForTitle(String title) {
    final iconMap = {
      'Introduction': Icons.info_outline,
      'Create Account': Icons.person_add_outlined,
      'First Steps': Icons.directions_walk,
      'How to Chat': Icons.chat_bubble_outline,
      'Get Recommendations': Icons.recommend_outlined,
      'Advanced Tips': Icons.tips_and_updates_outlined,
      'Browse Courses': Icons.search,
      'Enroll in Course': Icons.school_outlined,
      'Track Progress': Icons.trending_up,
      'Manage Profile': Icons.person_outline,
      'Settings': Icons.settings_outlined,
      'Security': Icons.lock_outline,
      'Common Issues': Icons.error_outline,
      'Contact Support': Icons.support_agent,
    };
    return iconMap[title] ?? Icons.article_outlined;
  }

  String _getContentForTitle(String title) {
    final contentMap = {
      'Introduction':
          'Welcome to Machinfy Agent! Our AI-powered course advisor helps you discover the perfect courses in Data Science and AI. Get personalized recommendations, explore our catalog, and start your learning journey today.',
      'Create Account':
          'Creating your account is quick and easy. You\'ll need a valid email address and a password. Once you verify your email, you can complete your profile and start exploring courses.',
      'First Steps':
          'After creating your account, take a moment to explore the app. Chat with our AI advisor, browse courses, and customize your settings. The more we know about your goals, the better we can help you.',
      'How to Chat':
          'Chatting with our AI advisor is simple. Just type your question and get instant answers. Ask about courses, prerequisites, schedules, or anything else you want to know.',
      'Get Recommendations':
          'Our AI learns from your interests and goals to provide personalized course recommendations. The more you interact, the better the suggestions become.',
      'Advanced Tips':
          'Get the most out of the AI advisor by being specific about your goals, mentioning your skill level, and asking follow-up questions for clarity.',
      'Browse Courses':
          'Explore our comprehensive course catalog. Filter by category, skill level, or format. Read descriptions, check reviews, and preview the curriculum before enrolling.',
      'Enroll in Course':
          'Found a course you like? Simply tap "Enroll Now", choose your preferred format (online/offline), and complete the payment process to get started.',
      'Track Progress':
          'Monitor your learning journey through your dashboard. See completed modules, upcoming sessions, and your overall progress across all enrolled courses.',
      'Manage Profile':
          'Keep your profile up to date with your current skills, interests, and learning goals. This helps us provide better course recommendations.',
      'Settings':
          'Customize your experience with notification preferences, language settings, and display options. Make the app work the way you want.',
      'Security':
          'Your account security is important. Use a strong password, enable two-factor authentication, and review your security settings regularly.',
      'Common Issues':
          'Having trouble? Most issues can be resolved by updating the app, checking your internet connection, or clearing the cache.',
      'Contact Support':
          'Our support team is here to help 24/7. Reach us via email, phone, or live chat directly in the app.',
    };
    return contentMap[title] ??
        'Learn more about $title and how to make the most of this feature.';
  }

  bool _hasSteps(String title) {
    return ['Create Account', 'Enroll in Course', 'Browse Courses']
        .contains(title);
  }

  List<String> _getStepsForTitle(String title) {
    final stepsMap = {
      'Create Account': [
        'Download the Machinfy Agent app from App Store or Google Play',
        'Tap "Sign Up" and enter your email and password',
        'Check your email and click the verification link',
        'Complete your profile with your interests and goals',
        'Start exploring courses and chatting with the AI advisor',
      ],
      'Enroll in Course': [
        'Browse courses or ask the AI advisor for recommendations',
        'Select a course and review all the details',
        'Choose your preferred format (online, offline, or hybrid)',
        'Tap "Enroll Now" and complete the payment',
        'Access your course materials and start learning',
      ],
      'Browse Courses': [
        'Open the courses section from the main menu',
        'Use filters to narrow down by category or level',
        'Read course descriptions and check reviews',
        'Preview the curriculum and instructor profile',
        'Save favorites or enroll in courses you like',
      ],
    };
    return stepsMap[title] ?? [];
  }
}