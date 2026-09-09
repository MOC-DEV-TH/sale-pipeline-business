import 'package:flutter/material.dart';

class ApiReadyPlaceholder extends StatelessWidget {
  const ApiReadyPlaceholder({super.key,
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: const Color(0xFF0B341F),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFF397457)),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF00C65A), size: 36),

          const SizedBox(height: 12),

          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            message,
            style: const TextStyle(color: Colors.white60, fontSize: 12),
          ),
        ],
      ),
    );
  }
}