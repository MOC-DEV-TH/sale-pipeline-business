import 'package:flutter/material.dart';

IconData getRandomIcon(String? name) {
  final icons = [
    Icons.menu_book,
    Icons.calculate,
    Icons.science,
    Icons.public,
    Icons.biotech,
    Icons.language,
    Icons.history_edu,
    Icons.psychology,
  ];

  if (name == null) return icons[0];

  return icons[name.hashCode.abs() % icons.length];
}

Color getRandomColor(String? name) {
  final colors = [
    const Color(0xFFEAF2FF),
    const Color(0xFFFFECEC),
    const Color(0xFFE8F6F3),
    const Color(0xFFFFF4E5),
    const Color(0xFFEDE7F6),
  ];

  if (name == null) return colors[0];

  return colors[name.hashCode.abs() % colors.length];
}

Color getRandomIconColor(String? name) {
  final colors = [
    const Color(0xFF3B82F6),
    const Color(0xFFE53935),
    const Color(0xFF1E88E5),
    const Color(0xFF43A047),
    const Color(0xFFFB8C00),
  ];

  if (name == null) return colors[0];

  return colors[name.hashCode.abs() % colors.length];
}