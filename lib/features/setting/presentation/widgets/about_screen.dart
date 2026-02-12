import 'package:flutter/material.dart';
import 'package:machinfy_agent/core/assets.dart';
import 'package:machinfy_agent/core/constants.dart';
import 'package:machinfy_agent/core/typography.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About'), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // App Logo Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),

              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Image.asset(AssetsData.logo),
                  ),
                ],
              ),
            ),

            // App Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Machinfy Agent',
                    style: Style.bodyLarge.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Machinfy Agent is your intelligent course advisor powered by advanced AI technology. We help you explore AI and Data Science programs, get personalized recommendations, and guide you through your learning journey.',
                    style: Style.bodysmall.copyWith(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Features Section
                  Text(
                    'Key Features',
                    style: Style.bodyLarge.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildFeatureItem(
                    icon: Icons.smart_toy_outlined,
                    title: 'AI-Powered Assistant',
                    description: 'Get intelligent course recommendations',
                    context: context,
                  ),
                  _buildFeatureItem(
                    icon: Icons.school_outlined,
                    title: 'Course Explorer',
                    description: 'Browse comprehensive course catalog',
                    context: context,
                  ),
                  _buildFeatureItem(
                    icon: Icons.person_outline,
                    title: 'Personalized Learning',
                    description: 'Tailored learning paths just for you',
                    context: context,
                  ),
                  _buildFeatureItem(
                    icon: Icons.support_agent_outlined,
                    title: '24/7 Support',
                    description: 'Always here to help you succeed',
                    context: context,
                  ),

                  const SizedBox(height: 30),

                  // App Information Cards
                  _buildInfoCard(
                    icon: Icons.info_outline,
                    title: 'Version Information',
                    children: [
                      _buildInfoRow('Version', '1.0.0', context),
                      _buildInfoRow('Build Number', '100', context),
                      _buildInfoRow('Release Date', 'January 2026', context),
                      _buildInfoRow('Platform', 'Android & iOS', context),
                    ],
                    context: context,
                  ),

                  const SizedBox(height: 16),

                  _buildInfoCard(
                    icon: Icons.business_outlined,
                    title: 'Company Information',
                    children: [
                      _buildInfoRow('Company', 'Machinfy Academy', context),
                      _buildInfoRow('Website', 'www.machinfy.com', context),
                      _buildInfoRow('Email', 'support@machinfy.com', context),
                      _buildInfoRow('Phone', '+20 123 456 7890', context),
                    ],
                    context: context,
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: kPrimaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: kPrimaryColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required List<Widget> children,
    required BuildContext context,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: kPrimaryColor, size: 24),
              const SizedBox(width: 12),
              Text(title, style: Style.bodysmall.copyWith(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}
