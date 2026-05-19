import 'package:flutter/material.dart';

class LeadTableCell extends StatelessWidget {
  final String text;
  final bool isHeader;
  final bool isLast;
  final int flex;

  const LeadTableCell({
    required this.text,
    this.isHeader = false,
    this.isLast = false,
    this.flex = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 2,
        ),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(
            right: BorderSide(
              color: Colors.white.withOpacity(0.16),
              width: 1,
            ),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            height: 1.2,
            fontSize: isHeader ? 13 : 12,
            fontWeight:
            isHeader ? FontWeight.w800 : FontWeight.w700,
          ),
        ),
      ),
    );
  }
}