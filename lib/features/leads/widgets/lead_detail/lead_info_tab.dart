import 'package:flutter/material.dart';

import '../../model/lead_detail_response.dart';
import 'lead_detail_row.dart';
import 'lead_empty_state.dart';
import 'lead_status_badge.dart';

class LeadInfoTab extends StatelessWidget {
  const LeadInfoTab({super.key, required this.lead});

  final LeadDetailData lead;

  @override
  Widget build(BuildContext context) {
    final fields = lead.labeledFields ?? [];

    if (fields.isEmpty) {
      return const EmptyState(message: 'No lead information available');
    }

    /// Long text fields look better
    /// at the bottom as note sections.
    final normalFields = fields.where((field) {
      return field.type != 'long_text';
    }).toList();

    final longTextFields = fields.where((field) {
      return field.type == 'long_text';
    }).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'GENERAL INFORMATION',
            style: TextStyle(color: Colors.white, fontSize: 11),
          ),

          const SizedBox(height: 24),

          ...normalFields.map((field) {
            return _DynamicLeadField(field: field);
          }),

          if (longTextFields.isNotEmpty) ...[
            const SizedBox(height: 10),

            ...longTextFields.map((field) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 28),
                child: _LeadLongTextField(field: field),
              );
            }),
          ],
        ],
      ),
    );
  }
}

class _DynamicLeadField extends StatelessWidget {
  const _DynamicLeadField({required this.field});

  final LabeledField field;

  @override
  Widget build(BuildContext context) {
    final label = _display(field.label);

    final value = _formatValue(field);

    /// Status badge
    if (field.key == 'status' || field.label == 'Status') {
      return DetailRow(
        label: '$label:',
        child: StatusBadge(text: value),
      );
    }

    /// Revenue green
    if (field.key == 'package_total' || field.label == 'Estimated Revenue') {
      return _DetailTextRow(
        label: '$label:',
        value: value,
        valueColor: const Color(0xFF00C754),
        valueSize: 16,
      );
    }

    return _DetailTextRow(label: '$label:', value: value);
  }

  String _formatValue(LabeledField field) {
    final value = field.value;

    if (value == null || value.trim().isEmpty) {
      return '-';
    }

    /// Date
    if (field.type == 'date') {
      return _dateValue(value);
    }

    /// Money / number
    if (field.key == 'package_total') {
      final amount = double.tryParse(value.replaceAll(',', ''));

      if (amount == null) {
        return value;
      }

      final formatted = _formatMoney(amount);

      return formatted;
    }

    return value;
  }

  String _dateValue(String value) {
    final parsed = DateTime.tryParse(value);

    if (parsed == null) {
      return value;
    }

    final month = parsed.month.toString().padLeft(2, '0');

    final day = parsed.day.toString().padLeft(2, '0');

    return '${parsed.year}-$month-$day';
  }

  String _formatMoney(double amount) {
    final string = amount.toStringAsFixed(amount % 1 == 0 ? 0 : 2);

    final parts = string.split('.');

    final digits = parts[0];

    final buffer = StringBuffer();

    for (int i = 0; i < digits.length; i++) {
      buffer.write(digits[i]);

      final remaining = digits.length - i - 1;

      if (remaining > 0 && remaining % 3 == 0) {
        buffer.write(',');
      }
    }

    if (parts.length > 1) {
      buffer.write('.${parts[1]}');
    }

    return buffer.toString();
  }

  String _display(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '-';
    }

    return value;
  }
}

class _LeadLongTextField extends StatelessWidget {
  const _LeadLongTextField({required this.field});

  final LabeledField field;

  @override
  Widget build(BuildContext context) {
    final label = field.label ?? '-';

    final value = field.value == null || field.value!.trim().isEmpty
        ? '-'
        : field.value!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(color: Colors.white, fontSize: 11),
        ),

        const SizedBox(height: 12),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(9, 4, 8, 15),
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(color: Color(0xFF34A262), width: 2),
              bottom: BorderSide(color: Color(0xFF116436)),
            ),
          ),
          child: Text(
            value,
            style: const TextStyle(
              color: Color(0xFFD8E0DB),
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

/// ===========================================================
/// DETAIL TEXT ROW
/// ===========================================================
class _DetailTextRow extends StatelessWidget {
  const _DetailTextRow({
    required this.label,
    required this.value,
    this.valueColor = const Color(0xFFD8E0DB),
    this.valueSize = 13,
  });

  final String label;
  final String value;
  final Color valueColor;
  final double valueSize;

  @override
  Widget build(BuildContext context) {
    return DetailRow(
      label: label,
      child: Text(
        value,
        textAlign: TextAlign.right,
        style: TextStyle(
          color: valueColor,
          fontSize: valueSize,
          fontWeight: FontWeight.w500,
          height: 1.4,
        ),
      ),
    );
  }
}
