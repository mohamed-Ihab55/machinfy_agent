import 'package:flutter/material.dart';
import 'package:machinfy_agent/core/constants.dart';
import 'package:machinfy_agent/core/typography.dart';
import 'package:machinfy_agent/features/help_support/presentation/widget/documentation_screen.dart';
import 'package:machinfy_agent/features/help_support/presentation/widget/faqs_screen.dart';
import 'package:machinfy_agent/features/help_support/presentation/widget/help_tile.dart';
import 'package:machinfy_agent/features/setting/presentation/widgets/section_title.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help & Support'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Contact Support
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [kPrimaryColor, kSecondaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Need Help?',
                  style: Style.headingMedium.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  'Our support team is here to help you 24/7',
                  style: Style.bodysmall.copyWith(color: Colors.white70),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kBackgroundColor,
                    foregroundColor: kPrimaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Contact Support',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),
          const SectionTitle(title: 'Resources'),

          HelpTile(
            icon: Icons.question_answer_outlined,
            title: 'FAQs',
            subtitle: 'Find answers to common questions',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FAQsScreen()),
              );
            },
          ),
          HelpTile(
            icon: Icons.book_outlined,
            title: 'Documentation',
            subtitle: 'Read our detailed guides',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DocumentationScreen(),
                ),
              );
            },
          ),

          const SizedBox(height: 30),
          const SectionTitle(title: 'Contact'),

          HelpTile(
            icon: Icons.email_outlined,
            title: 'Email Support',
            subtitle: 'support@machinfy.com',
            onTap: () {},
          ),
          HelpTile(
            icon: Icons.phone_outlined,
            title: 'Phone Support',
            subtitle: '+20 123 456 7890',
            onTap: () {},
          ),
          const SizedBox(height: 30),
          const SectionTitle(title: 'Feedback'),

          HelpTile(
            icon: Icons.star_outline,
            title: 'Rate the App',
            subtitle: 'Share your experience',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
