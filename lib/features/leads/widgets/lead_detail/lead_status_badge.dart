import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF116436),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFF1C8A4D)),
      ),
      child: Text(
        text,
        textAlign: TextAlign.right,
        style: const TextStyle(
          color: Color(0xFF7BE5A4),
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}