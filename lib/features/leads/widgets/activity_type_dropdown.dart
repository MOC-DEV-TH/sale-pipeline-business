import 'package:flutter/material.dart';

const List<String> kActivityTypes = [
  'Call',
  'Meeting',
  'Email',
  'Note',
  'Task',
];

class ActivityTypeDropdown extends StatelessWidget {
  const ActivityTypeDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final String? value;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      dropdownColor: const Color(0xFF0B341F),
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: Color(0xFF9CC9A9),
        size: 30,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF0B341F),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 20,
        ),
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
      hint: const Text(
        'Choose One',
        style: TextStyle(
          color: Colors.white54,
          fontSize: 15,
        ),
      ),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
      items: kActivityTypes.map((type) {
        return DropdownMenuItem<String>(
          value: type,
          child: Text(type),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}