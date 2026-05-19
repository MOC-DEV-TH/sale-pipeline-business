import 'dart:async';

import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  final String hint;
  final Function(String value)? onSearch;

  /// for date picker / custom tap
  final bool readOnly;
  final bool isDatePicker;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const SearchBox({
    super.key,
    required this.hint,
    this.onSearch,
    this.readOnly = false,
    this.isDatePicker = false,
    this.firstDate,
    this.lastDate,
  });

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final controller = TextEditingController();

  Timer? _debounce;

  @override
  void dispose() {
    controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onChanged(String value) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    _debounce = Timer(
      const Duration(milliseconds: 500),
          () {
        widget.onSearch?.call(value);
      },
    );
  }

  Future<void> _openDatePicker() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: widget.firstDate ?? DateTime(2020),
      lastDate: widget.lastDate ?? DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(),
          child: child!,
        );
      },
    );

    if (picked == null) return;

    final formatted =
        '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';

    controller.text = formatted;

    widget.onSearch?.call(formatted);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 168,
      height: 48,
      child: TextField(
        controller: controller,
        readOnly: widget.readOnly || widget.isDatePicker,
        onTap: widget.isDatePicker ? _openDatePicker : null,
        onChanged: widget.isDatePicker ? null : _onChanged,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: const TextStyle(
            color: Colors.white54,
            fontSize: 13,
          ),
          suffixIcon: Icon(
            widget.isDatePicker ? Icons.calendar_month_rounded : Icons.search,
            color: Colors.white,
            size: 26,
          ),
          filled: true,
          fillColor: const Color(0xFF0B3A22),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFF16894D),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFF00C853),
            ),
          ),
        ),
      ),
    );
  }
}