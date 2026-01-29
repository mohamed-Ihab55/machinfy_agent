import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isPasswordHidden = true;
  bool isConfirmHidden = true;
  bool acceptTerms = false;
  bool isLoading = false;

  String? nameError;
  String? emailError;
  String? passwordError;
  String? confirmError;

  void togglePassword() {
    isPasswordHidden = !isPasswordHidden;
    notifyListeners();
  }

  void toggleConfirmPassword() {
    isConfirmHidden = !isConfirmHidden;
    notifyListeners();
  }

  void toggleTerms(bool? value) {
    acceptTerms = value ?? false;
    notifyListeners();
  }

  bool validate() {
    nameError = null;
    emailError = null;
    passwordError = null;
    confirmError = null;

    if (nameController.text.trim().isEmpty) {
      nameError = 'Full name is required';
    }

    if (!emailController.text.contains('@')) {
      emailError = 'Enter a valid email';
    }

    if (passwordController.text.length < 8) {
      passwordError = 'Must be at least 8 characters';
    }

    if (confirmPasswordController.text != passwordController.text) {
      confirmError = 'Passwords do not match';
    }

    if (!acceptTerms) {
      confirmError = 'You must accept the terms';
    }

    notifyListeners();
    return nameError == null &&
        emailError == null &&
        passwordError == null &&
        confirmError == null;
  }

  Future<void> createAccount() async {
    if (!validate()) return;

    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2)); // API call

    isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
