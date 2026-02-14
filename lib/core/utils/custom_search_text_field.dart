import 'package:flutter/material.dart';

class CustomSearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isDark;
  final ValueChanged<String> onChanged;
  final InputDecoration decoration;
  const CustomSearchTextField({
    super.key,
    required this.controller,
    this.isDark = false,
    required this.onChanged,
    required this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: decoration,
    );
  }
}
