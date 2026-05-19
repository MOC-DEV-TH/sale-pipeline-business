import 'package:flutter/material.dart';
import 'package:sale_pipeline_business/utils/app_colors.dart';

import 'new_lead_step_page.dart';

///step indicator
class StepIndicator extends StatelessWidget {
  final int total;
  final int current;

  const StepIndicator({required this.total, required this.current});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 26,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(total, (index) {
          final isCompleted = index < current;
          final isCurrent = index == current;
          final isActive = isCompleted || isCurrent;

          return Row(
            children: [
              Container(
                width: 23,
                height: 23,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted
                      ? const Color(0xFF00C853)
                      : Colors.transparent,
                  border: Border.all(
                    color: const Color(0xFF00C853),
                    width: 1.5,
                  ),
                ),
                child: isCompleted
                    ? const Icon(
                        Icons.check,
                        size: 15,
                        color: Color(0xFF063817),
                      )
                    : null,
              ),

              if (index != total - 1)
                Container(
                  width: 12,
                  height: 1.5,
                  color: isActive
                      ? kPrimaryColor
                      : kSecondaryColor,
                ),
            ],
          );
        }),
      ),
    );
  }
}

///selection step
class SelectionStep extends StatelessWidget {
  final List<String> options;
  final String? selectedValue;
  final ValueChanged<String> onSelected;

  const SelectionStep({
    required this.options,
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: options.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, index) {
        final item = options[index];
        final selected = item == selectedValue;

        return GestureDetector(
          onTap: () => onSelected(item),
          child: Container(
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selected
                  ? kPrimaryColor
                  : kSecondaryColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFF16894D)),
            ),
            child: Text(
              item,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ),
        );
      },
    );
  }
}

///form step
class FormStep extends StatelessWidget {
  final List<FormFieldConfig> fields;
  final Map<String, dynamic> answers;
  final void Function(String key, dynamic value) onChanged;

  const FormStep({
    super.key,
    required this.fields,
    required this.answers,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: fields.length,
      separatorBuilder: (_, __) => const SizedBox(height: 18),
      itemBuilder: (_, index) {
        final field = fields[index];

        if (field.type == FieldType.checkbox) {
          return DynamicCheckbox(
            value: answers[field.key] == true,
            label: field.label,
            onChanged: (value) => onChanged(field.key, value),
          );
        }

        return Row(
          children: [
            SizedBox(
              width: 110,
              child: Text.rich(
                TextSpan(
                  text: field.label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                  children: [
                    if (field.required)
                      const TextSpan(
                        text: ' *',
                        style: TextStyle(color: Colors.red),
                      ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: _buildField(context, field),
            ),
          ],
        );
      },
    );
  }

  Widget _buildField(
      BuildContext context,
      FormFieldConfig field,
      ) {
    switch (field.type) {
      case FieldType.text:
        return DynamicTextField(
          hint: 'Text',
          value: answers[field.key]?.toString(),
          onChanged: (value) => onChanged(field.key, value),
        );

      case FieldType.textarea:
        return DynamicTextArea(
          hint: 'Type here...',
          value: answers[field.key]?.toString(),
          onChanged: (value) => onChanged(field.key, value),
        );

      case FieldType.dropdown:
        return DynamicDropdown(
          value: answers[field.key]?.toString(),
          items: field.options,
          onChanged: (value) => onChanged(field.key, value),
        );

      case FieldType.date:
        return DateField(
          value: answers[field.key]?.toString(),
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              firstDate: DateTime(2020),
              lastDate: DateTime(2035),
              initialDate: DateTime.now(),
            );

            if (picked != null) {
              onChanged(field.key, picked.toIso8601String());
            }
          },
        );

      case FieldType.checkbox:
        return const SizedBox();
    }
  }
}

///dynamic text field
class DynamicTextField extends StatelessWidget {
  final String hint;
  final String? value;
  final ValueChanged<String> onChanged;

  const DynamicTextField({
    required this.hint,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      onChanged: onChanged,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white38, fontSize: 12),
        filled: true,
        fillColor: const Color(0xFF0B3A22),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF16894D)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF00C853)),
        ),
      ),
    );
  }
}

///dynamic dropdown
class DynamicDropdown extends StatelessWidget {
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const DynamicDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final selectedValue = items.contains(value)
        ? value
        : (items.isNotEmpty ? items.first : null);

    return DropdownButtonFormField<String>(
      value: selectedValue,
      dropdownColor: const Color(0xFF0B3A22),
      iconEnabledColor: Colors.white,
      style: const TextStyle(color: Colors.white, fontSize: 12),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF0B3A22),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF16894D)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF00C853)),
        ),
      ),
      items: items
          .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
          .toList(),
      onChanged: onChanged,
    );
  }
}

///step button
class StepButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onTap;
  final double height;
  final double textSize;

  const StepButton({
    required this.text,
    required this.color,
    required this.onTap,
    this.height = 42,
    this.textSize = 13
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: textSize,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

///dynamic text area
class DynamicTextArea extends StatelessWidget {
  final String hint;
  final String? value;
  final ValueChanged<String> onChanged;

  const DynamicTextArea({
    required this.hint,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      maxLines: 5,
      onChanged: onChanged,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white38, fontSize: 12),
        filled: true,
        fillColor: const Color(0xFF0B3A22),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF16894D)),
        ),
      ),
    );
  }
}

///date field
class DateField extends StatelessWidget {
  final String? value;
  final VoidCallback onTap;

  const DateField({
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF0B3A22),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFF16894D)),
        ),
        child: Text(
          value == null ? '......Select Date......' : value!,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

///dynamic checkbox
class DynamicCheckbox extends StatelessWidget {
  final bool value;
  final String label;
  final ValueChanged<bool> onChanged;

  const DynamicCheckbox({
    required this.value,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          side: const BorderSide(color: Colors.white),
          checkColor: Colors.white,
          activeColor: const Color(0xFF00C853),
          onChanged: (v) => onChanged(v ?? false),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}