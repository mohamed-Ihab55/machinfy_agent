import 'package:flutter/material.dart';

class DocSection {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> items;

  const DocSection({
    required this.title,
    required this.icon,
    required this.color,
    required this.items,
  });
}
