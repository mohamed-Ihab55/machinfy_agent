import 'package:flutter/material.dart';
import 'package:machinfy_agent/features/help_support/presentation/models/documentation_section_model.dart';

class DocumentationData {
  static const sections = [
    DocSection(
      title: 'Getting Started',
      icon: Icons.rocket_launch_outlined,
      color: Color(0xFF2196F3),
      items: ['Introduction', 'Create Account', 'First Steps'],
    ),
    DocSection(
      title: 'Using AI Advisor',
      icon: Icons.chat_outlined,
      color: Color(0xFF9C27B0),
      items: ['How to Chat', 'Get Recommendations', 'Advanced Tips'],
    ),
    DocSection(
      title: 'Courses',
      icon: Icons.school_outlined,
      color: Color(0xFF4CAF50),
      items: ['Browse Courses', 'Enroll in Course', 'Track Progress'],
    ),
    DocSection(
      title: 'Your Account',
      icon: Icons.person_outline,
      color: Color(0xFFFF9800),
      items: ['Manage Profile', 'Settings', 'Security'],
    ),
    DocSection(
      title: 'Need Help?',
      icon: Icons.help_outline,
      color: Color(0xFFF44336),
      items: ['Common Issues', 'Contact Support'],
    ),
  ];
}
