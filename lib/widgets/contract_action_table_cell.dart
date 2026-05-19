import 'package:flutter/material.dart';
import 'package:sale_pipeline_business/utils/gap.dart';

class ContractActionTableCell extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onSigned;
  final int flex;
  final bool isLast;

  const ContractActionTableCell({
    super.key,
    required this.onEdit,
    required this.onSigned,
    this.flex = 2,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onEdit,
              child: const Text(
                'Edit',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            4.hGap,

            const Text('||',style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),),

            4.hGap,
            GestureDetector(
              onTap: onSigned,
              child: const Text(
                'Signed',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}