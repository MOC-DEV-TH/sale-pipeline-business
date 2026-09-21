import 'package:flutter/material.dart';

import '../../model/lead_detail_response.dart';
import 'lead_detail_row.dart';
import 'lead_empty_state.dart';
import 'lead_status_badge.dart';

class LeadInfoTab extends StatelessWidget {
  const LeadInfoTab({
    super.key,
    required this.lead,
  });

  final LeadDetailData lead;

  @override
  Widget build(BuildContext context) {
    final sections = lead.sections ?? [];

    if (sections.isEmpty) {
      return const EmptyState(
        message: 'No lead information available',
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < sections.length; i++) ...[
            _LeadSection(section: sections[i]),

            /// Divider between sections only
            if (i != sections.length - 1) ...[
              const SizedBox(height: 6),
              const Divider(
                color: Color(0xFFD8E0DB),
                thickness: 1,
                height: 1,
              ),
              const SizedBox(height: 24),
            ],
          ],
        ],
      ),
    );
  }
}

/// ===========================================================
/// SECTION
/// ===========================================================

class _LeadSection extends StatelessWidget {
  const _LeadSection({
    required this.section,
  });

  final Section section;

  @override
  Widget build(BuildContext context) {
    final fields = section.fields ?? [];

    if (fields.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _sectionTitle(section.title),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w400,
          ),
        ),

        const SizedBox(height: 24),

        ...fields.map(
              (field) => _DynamicSectionField(field: field),
        ),

        const SizedBox(height: 20),
      ],
    );
  }

  String _sectionTitle(String? title) {
    if (title == null || title.trim().isEmpty) {
      return 'GENERAL INFORMATION';
    }

    return title.trim().toUpperCase();
  }
}

/// ===========================================================
/// DYNAMIC FIELD
/// ===========================================================

class _DynamicSectionField extends StatelessWidget {
  const _DynamicSectionField({
    required this.field,
  });

  final Field field;

  @override
  Widget build(BuildContext context) {
    final label = _displayLabel(field.label);
    final value = _formatValue(field);

    /// STATUS
    if (_isStatusField(field)) {
      return DetailRow(
        label: '$label:',
        child: StatusBadge(text: value),
      );
    }

    /// ESTIMATED REVENUE
    if (_isRevenueField(field)) {
      return _DetailTextRow(
        label: '$label:',
        value: value,
        valueColor: const Color(0xFF00C754),
        valueSize: 16,
        valueFontWeight: FontWeight.w600,
      );
    }

    /// LONG TEXT
    if (_isLongTextField(field)) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: _LeadLongTextField(
          label: label,
          value: value,
        ),
      );
    }

    return _DetailTextRow(
      label: '$label:',
      value: value,
    );
  }

  bool _isStatusField(Field field) {
    final key = field.key?.toLowerCase().trim();
    final label = field.label?.toLowerCase().trim();

    return key == 'status' || label == 'status';
  }

  bool _isRevenueField(Field field) {
    final key = field.key?.toLowerCase().trim();
    final label = field.label?.toLowerCase().trim();

    return key == 'package_total' ||
        key == 'estimated_revenue' ||
        label == 'estimated revenue';
  }

  bool _isLongTextField(Field field) {
    final type = field.type?.toLowerCase().trim();

    return type == 'long_text' ||
        type == 'textarea' ||
        type == 'text_area';
  }

  String _formatValue(Field field) {
    /// Prefer backend display value when available.
    final display = field.display?.trim();

    if (display != null && display.isNotEmpty) {
      return display;
    }

    final rawValue = field.value?.trim();

    if (rawValue == null || rawValue.isEmpty) {
      return '-';
    }

    final type = field.type?.toLowerCase().trim();

    /// DATE ONLY
    if (type == 'date') {
      return _formatDate(rawValue);
    }

    /// DATE + TIME
    if (type == 'datetime' ||
        type == 'date_time' ||
        type == 'timestamp') {
      return _formatDateTime(rawValue);
    }

    /// MONEY
    if (_isRevenueField(field)) {
      return _formatMoneyValue(rawValue);
    }

    return rawValue;
  }

  String _formatDate(String value) {
    final parsed = DateTime.tryParse(value);

    if (parsed == null) {
      return value;
    }

    final month = parsed.month.toString().padLeft(2, '0');
    final day = parsed.day.toString().padLeft(2, '0');

    return '${parsed.year}-$month-$day';
  }

  String _formatDateTime(String value) {
    final parsed = DateTime.tryParse(value);

    if (parsed == null) {
      return value;
    }

    final month = parsed.month.toString().padLeft(2, '0');
    final day = parsed.day.toString().padLeft(2, '0');
    final hour = parsed.hour.toString().padLeft(2, '0');
    final minute = parsed.minute.toString().padLeft(2, '0');
    final second = parsed.second.toString().padLeft(2, '0');

    return '${parsed.year}-$month-$day $hour:$minute:$second';
  }

  String _formatMoneyValue(String value) {
    /// Already formatted by backend.
    if (value.contains(',')) {
      return value;
    }

    final match = RegExp(r'^(-?[\d.]+)(.*)$').firstMatch(value);

    if (match == null) {
      return value;
    }

    final numberString = match.group(1);
    final suffix = match.group(2)?.trim() ?? '';

    final amount = double.tryParse(numberString ?? '');

    if (amount == null) {
      return value;
    }

    final formatted = _formatMoney(amount);

    if (suffix.isEmpty) {
      return formatted;
    }

    return '$formatted $suffix';
  }

  String _formatMoney(double amount) {
    final string = amount.toStringAsFixed(
      amount % 1 == 0 ? 0 : 2,
    );

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

  String _displayLabel(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '-';
    }

    return value.trim();
  }
}

/// ===========================================================
/// LONG TEXT FIELD
/// ===========================================================

class _LeadLongTextField extends StatelessWidget {
  const _LeadLongTextField({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
          ),
        ),

        const SizedBox(height: 12),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(
            9,
            4,
            8,
            15,
          ),
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Color(0xFF34A262),
                width: 2,
              ),
              bottom: BorderSide(
                color: Color(0xFF116436),
              ),
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
    this.valueFontWeight = FontWeight.w500,
  });

  final String label;
  final String value;
  final Color valueColor;
  final double valueSize;
  final FontWeight valueFontWeight;

  @override
  Widget build(BuildContext context) {
    return DetailRow(
      label: label,
      child: Text(
        value,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: valueColor,
          fontSize: valueSize,
          fontWeight: valueFontWeight,
          height: 1.4,
        ),
      ),
    );
  }
}