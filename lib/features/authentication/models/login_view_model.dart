import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool rememberMe = false;
  bool isPasswordHidden = true;
  bool isLoading = false;

  String? emailError;
  String? passwordError;

  void toggleRememberMe(bool? value) {
    rememberMe = value ?? false;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    isPasswordHidden = !isPasswordHidden;
    notifyListeners();
  }

  bool validate() {
    emailError = null;
    passwordError = null;

    final email = emailController.text.trim();
    final pass = passwordController.text;

    // validation بسيطة وواقعية
    if (email.isEmpty || !email.contains('@')) {
      emailError = 'Please enter a valid email';
    }
    if (pass.isEmpty || pass.length < 6) {
      passwordError = 'Password must be at least 6 characters';
    }

    notifyListeners();
    return emailError == null && passwordError == null;
  }

  Future<void> signIn() async {
    if (!validate()) return;

    isLoading = true;
    notifyListeners();

    try {
      // TODO: call API / Firebase
      await Future.delayed(const Duration(seconds: 2));
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
