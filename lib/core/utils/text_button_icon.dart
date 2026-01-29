import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextButtonIcon extends StatelessWidget {
  const TextButtonIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(Icons.arrow_back, size: 18, color: Color(0xFF111827)),
      label: const Text(
        'Back',
        style: TextStyle(color: Color(0xFF111827), fontWeight: FontWeight.w600),
      ),
    );
  }
}
