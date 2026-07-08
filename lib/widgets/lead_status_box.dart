import 'package:flutter/material.dart';

class StatusBox extends StatefulWidget {
  final String hint;
  final List<String> items;
  final ValueChanged<String?>? onChanged;

  const StatusBox({
    super.key,
    required this.hint,
    required this.items,
    this.onChanged,
  });

  @override
  State<StatusBox> createState() => _StatusBoxState();
}

class _StatusBoxState extends State<StatusBox> {
  String? selectedValue;

  void _clear() {
    setState(() {
      selectedValue = null;
    });

    widget.onChanged?.call(null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 168,
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF0F5C35),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFF16894D),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          isExpanded: true,
          dropdownColor: const Color(0xFF0B3A22),

          icon: selectedValue == null
              ? const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white,
            size: 28,
          )
              : GestureDetector(
            onTap: _clear,
            child: const Icon(
              Icons.close_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),

          hint: Text(
            widget.hint,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),

          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),

          items: widget.items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),

          onChanged: (value) {
            setState(() {
              selectedValue = value;
            });

            widget.onChanged?.call(value);
          },
        ),
      ),
    );
  }
}