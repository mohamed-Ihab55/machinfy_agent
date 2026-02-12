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
      // Deep navy background for a professional dark look
      scaffoldBackgroundColor: kDarkBackgroundColor,
      primaryColor: kPrimaryColor,
      colorScheme: base.colorScheme.copyWith(
        primary: kPrimaryColor,
        secondary: kSecondaryColor,
        brightness: Brightness.dark,
        surface: kDarkSurfaceColor,
        onSurface: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: kDarkBackgroundColor,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      cardColor: kDarkSurfaceColor,
      canvasColor: kDarkBackgroundColor,
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: kDarkBackgroundColor,
      ),
      iconTheme: base.iconTheme.copyWith(color: Colors.white),
      listTileTheme: base.listTileTheme.copyWith(
        iconColor: Colors.white70,
        textColor: Colors.white,
      ),
      textTheme: base.textTheme.apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      inputDecorationTheme: base.inputDecorationTheme.copyWith(
        filled: true,
        fillColor: kDarkSurfaceColor,
        hintStyle: base.textTheme.bodyMedium?.copyWith(
          color: Colors.white70,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: kPrimaryColor, width: 1.4),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: kDarkDialogColor,
      ),
    );
  }
}

