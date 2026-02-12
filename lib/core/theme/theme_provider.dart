import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  // Start the app in dark mode by default
  bool _isDarkMode = true;

  bool get isDarkMode => _isDarkMode;

  void setDarkMode(bool value) {
    if (_isDarkMode == value) return;
    _isDarkMode = value;
    notifyListeners();
  }

  void toggleTheme() {
    setDarkMode(!_isDarkMode);
  }
}

