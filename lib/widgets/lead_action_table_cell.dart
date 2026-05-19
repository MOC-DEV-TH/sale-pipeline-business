import 'package:flutter/material.dart';

class LeadActionTableCell extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final int flex;

  const LeadActionTableCell({
    super.key,
    required this.text,
    required this.onTap,
    this.flex = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 2,
          ),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                color: Colors.white.withOpacity(0.16),
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    height: 1.2,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              const SizedBox(width: 6),

              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 12,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}