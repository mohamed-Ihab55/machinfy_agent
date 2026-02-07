import 'package:flutter/material.dart';

class ResetPasswordViewModel extends ChangeNotifier {
  final emailController = TextEditingController();

  bool isLoading = false;
  String? emailError;

  bool validate() {
    emailError = null;
    final email = emailController.text.trim();

    if (email.isEmpty || !email.contains('@')) {
      emailError = 'Please enter a valid email';
    }

    notifyListeners();
    return emailError == null;
  }

  Future<void> sendResetLink() async {
    if (!validate()) return;

    isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 2));
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
