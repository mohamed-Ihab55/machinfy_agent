import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier {
  final nameController = TextEditingController(text: 'Ahmed Hassan');
  final emailController = TextEditingController(text: 'ahmed.hassan@email.com');
  final phoneController = TextEditingController(text: '+20 123 456 7890');
  final bioController = TextEditingController();

  bool isLoading = false;

  String initials() {
    final name = nameController.text.trim();
    if (name.isEmpty) return 'U';
    final parts = name
        .split(RegExp(r'\s+'))
        .where((e) => e.isNotEmpty)
        .toList();
    final first = parts.isNotEmpty ? parts[0][0] : 'U';
    final second = parts.length > 1 ? parts[1][0] : '';
    return (first + second).toUpperCase();
  }

  Future<void> saveChanges() async {
    isLoading = true;
    notifyListeners();

    try {
      // TODO: API/Firebase update profile
      await Future.delayed(const Duration(seconds: 2));
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void changePhoto() {
    // TODO: image picker
    // بعد اختيار صورة: notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    bioController.dispose();
    super.dispose();
  }
}
