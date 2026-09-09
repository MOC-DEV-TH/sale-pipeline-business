import 'package:flutter/material.dart';

class ActivityFormField extends StatelessWidget {
  const ActivityFormField({
    super.key,
    required this.label,
    required this.controller,
    this.hint,
    this.required = false,
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
  });

  final String label;
  final TextEditingController controller;
  final String? hint;
  final bool required;
  final int maxLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
            children: [
              TextSpan(text: label),
              if (required)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        TextFormField(
          controller: controller,
          readOnly: readOnly,
          maxLines: maxLines,
          onTap: onTap,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Colors.white38,
            ),
            filled: true,
            fillColor: const Color(0xFF0B341F),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 22,
              vertical: maxLines > 1 ? 20 : 18,
            ),
            suffixIcon: suffixIcon,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: const BorderSide(
                color: Color(0xFF56846A),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: const BorderSide(
                color: Color(0xFF00C65A),
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}