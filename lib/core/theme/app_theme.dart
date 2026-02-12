import 'package:flutter/material.dart';
import 'package:machinfy_agent/core/constants.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final base = ThemeData.light();
    return base.copyWith(
      scaffoldBackgroundColor: kBackgroundColor,
      primaryColor: kPrimaryColor,
      colorScheme: base.colorScheme.copyWith(
        primary: kPrimaryColor,
        secondary: kSecondaryColor,
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        foregroundColor: kTextColor,
      ),
    );
  }

  static ThemeData get darkTheme {
    final base = ThemeData.dark();
    return base.copyWith(
      scaffoldBackgroundColor: const Color(0xFF020617),
      primaryColor: kPrimaryColor,
      colorScheme: base.colorScheme.copyWith(
        primary: kPrimaryColor,
        secondary: kSecondaryColor,
        brightness: Brightness.dark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF020617),
        elevation: 0,
      ),
    );
  }
}

