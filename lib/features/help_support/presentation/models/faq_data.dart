import 'package:machinfy_agent/features/help_support/presentation/models/faq_item_model.dart';

class FAQData {
  static const List<String> categories = [
    'All',
    'Getting Started',
    'Account',
    'Courses',
    'Payments',
  ];

  static final List<FAQItem> faqs = [
    FAQItem(
      category: 'Getting Started',
      question: 'How do I get started?',
      answer:
          'Download the app, create your account, and start chatting with our AI advisor. It\'s that simple!',
    ),
    FAQItem(
      category: 'Getting Started',
      question: 'What is Machinfy Agent?',
      answer:
          'An AI-powered course advisor that helps you find the best courses in Data Science and AI.',
    ),
    FAQItem(
      category: 'Getting Started',
      question: 'Is the app free?',
      answer:
          'Yes! The app is completely free to use. Some courses may require payment.',
    ),

    // Account
    FAQItem(
      category: 'Account',
      question: 'How do I create an account?',
      answer:
          'Tap "Sign Up", enter your email and password, verify your email, and you\'re ready to go!',
    ),
    FAQItem(
      category: 'Account',
      question: 'Forgot my password?',
      answer:
          'Tap "Forgot Password" on the login screen, enter your email, and check your inbox for a reset link.',
    ),
    FAQItem(
      category: 'Account',
      question: 'Can I change my email?',
      answer:
          'Yes! Go to Profile → Settings → Email. You\'ll need to verify your new email address.',
    ),

    // Courses
    FAQItem(
      category: 'Courses',
      question: 'What courses are available?',
      answer:
          'We offer courses in Data Science, AI, Machine Learning, Python, Data Analysis, and more.',
    ),
    FAQItem(
      category: 'Courses',
      question: 'How do I enroll?',
      answer:
          'Browse courses, select one you like, tap "Enroll Now", and complete the payment if required.',
    ),
    FAQItem(
      category: 'Courses',
      question: 'Do I get a certificate?',
      answer:
          'Yes! You\'ll receive an official certificate upon completing any course.',
    ),
    FAQItem(
      category: 'Courses',
      question: 'Online or offline classes?',
      answer:
          'Both! Choose from online live sessions, in-person classes, or hybrid options.',
    ),

    // Payments
    FAQItem(
      category: 'Payments',
      question: 'What payment methods do you accept?',
      answer:
          'We accept cards (Visa, Mastercard), mobile wallets (Vodafone Cash, Orange Money), and PayPal.',
    ),
    FAQItem(
      category: 'Payments',
      question: 'Can I get a refund?',
      answer:
          'Yes, within 7 days if you haven\'t accessed the course content. Contact support for details.',
    ),
  ];
}
