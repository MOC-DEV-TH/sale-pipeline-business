import 'package:flutter/material.dart';
import 'package:sale_pipeline_business/utils/app_colors.dart';

import 'new_lead_step_page.dart';

/// ===========================================================
/// STEP INDICATOR
/// ===========================================================

class StepIndicator extends StatelessWidget {
  final int total;
  final int current;

  const StepIndicator({
    super.key,
    required this.total,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 26,
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.center,
        children:
        List.generate(
          total,
              (index) {
            final isCompleted =
                index < current;

            final isCurrent =
                index == current;

            final isActive =
                isCompleted ||
                    isCurrent;

            return Row(
              children: [
                Container(
                  width: 23,
                  height: 23,
                  decoration:
                  BoxDecoration(
                    shape:
                    BoxShape.circle,
                    color:
                    isCompleted
                        ? kPrimaryColor
                        : Colors
                        .transparent,
                    border:
                    Border.all(
                      color:
                      kPrimaryColor,
                      width: 1.5,
                    ),
                  ),
                  child:
                  isCompleted
                      ? const Icon(
                    Icons
                        .check,
                    size:
                    15,
                    color:
                    Color(
                      0xFF063817,
                    ),
                  )
                      : null,
                ),

                if (index !=
                    total - 1)
                  Container(
                    width: 12,
                    height: 1.5,
                    color: isActive
                        ? kPrimaryColor
                        : kSecondaryColor,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// ===========================================================
/// SELECTION STEP
/// ===========================================================

class SelectionStep extends StatelessWidget {
  final List<FormOptionConfig> options;
  final dynamic selectedValue;
  final ValueChanged<dynamic> onSelected;

  const SelectionStep({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (options.isEmpty) {
      return const Center(
        child: Text(
          'No options available.',
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
      );
    }

    return ListView.separated(
      itemCount: options.length,
      separatorBuilder:
          (_, __) =>
      const SizedBox(
        height: 12,
      ),
      itemBuilder: (
          context,
          index,
          ) {
        final item =
        options[index];

        final selected =
            item.value ==
                selectedValue;

        return GestureDetector(
          onTap: () {
            onSelected(
              item.value,
            );
          },
          child:
          AnimatedContainer(
            duration:
            const Duration(
              milliseconds: 200,
            ),
            height: 52,
            alignment:
            Alignment.center,
            decoration:
            BoxDecoration(
              color: selected
                  ? kPrimaryColor
                  : kCardColor,
              borderRadius:
              BorderRadius
                  .circular(
                14,
              ),
              border:
              Border.all(
                color:
                selected
                    ? kPrimaryColor
                    : kSecondaryColor,
              ),
            ),
            child: Text(
              item.label,
              textAlign:
              TextAlign.center,
              style:
              const TextStyle(
                color:
                Colors.white,
                fontWeight:
                FontWeight.w800,
                fontSize: 16,
              ),
            ),
          ),
        );
      },
    );
  }
}

/// ===========================================================
/// FORM STEP
/// ===========================================================

class FormStep extends StatelessWidget {
  final List<FormFieldConfig> fields;

  final Map<String, dynamic>
  answers;

  final void Function(
      String key,
      dynamic value,
      ) onChanged;

  const FormStep({
    super.key,
    required this.fields,
    required this.answers,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (fields.isEmpty) {
      return const Center(
        child: Text(
          'No fields available.',
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
      );
    }

    return ListView.separated(
      keyboardDismissBehavior:
      ScrollViewKeyboardDismissBehavior
          .onDrag,
      itemCount:
      fields.length,
      separatorBuilder:
          (_, __) =>
      const SizedBox(
        height: 18,
      ),
      itemBuilder: (
          context,
          index,
          ) {
        final field =
        fields[index];

        /// Checkbox
        if (field.type ==
            FieldType.checkbox) {
          return DynamicCheckbox(
            value:
            answers[field.key] ==
                true,
            label:
            field.label,
            required:
            field.required,
            onChanged:
                (value) {
              onChanged(
                field.key,
                value,
              );
            },
          );
        }

        /// Textarea
        if (field.type ==
            FieldType.textarea) {
          return Column(
            crossAxisAlignment:
            CrossAxisAlignment
                .start,
            children: [
              _FieldLabel(
                label:
                field.label,
                required:
                field.required,
              ),

              const SizedBox(
                height: 8,
              ),

              _buildField(
                context,
                field,
              ),
            ],
          );
        }

        /// Standard field
        return Row(
          crossAxisAlignment:
          CrossAxisAlignment
              .center,
          children: [
            SizedBox(
              width: 110,
              child:
              _FieldLabel(
                label:
                field.label,
                required:
                field.required,
              ),
            ),

            const SizedBox(
              width: 8,
            ),

            Expanded(
              child:
              _buildField(
                context,
                field,
              ),
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
    /// =====================================================
    /// Text
    /// =====================================================

      case FieldType.text:
        return DynamicTextField(
          hint:
          'Enter ${field.label}',
          value:
          answers[field.key]
              ?.toString(),
          keyboardType:
          TextInputType.text,
          onChanged:
              (value) {
            onChanged(
              field.key,
              value,
            );
          },
        );

    /// =====================================================
    /// Number
    /// =====================================================

      case FieldType.number:
        return DynamicTextField(
          hint:
          'Enter ${field.label}',
          value:
          answers[field.key]
              ?.toString(),
          keyboardType:
          const TextInputType
              .numberWithOptions(
            decimal: true,
          ),
          onChanged:
              (value) {
            onChanged(
              field.key,
              value,
            );
          },
        );

    /// =====================================================
    /// Textarea
    /// =====================================================

      case FieldType.textarea:
        return DynamicTextArea(
          hint:
          'Enter ${field.label}',
          value:
          answers[field.key]
              ?.toString(),
          onChanged:
              (value) {
            onChanged(
              field.key,
              value,
            );
          },
        );

    /// =====================================================
    /// Dropdown
    /// =====================================================

      case FieldType.dropdown:
        return DynamicDropdown(
          value:
          answers[field.key],
          items:
          field.options,
          hint:
          'Select ${field.label}',
          onChanged:
              (value) {
            onChanged(
              field.key,
              value,
            );
          },
        );

    /// =====================================================
    /// Date
    /// =====================================================

      case FieldType.date:
        return DateField(
          value:
          answers[field.key]
              ?.toString(),
          onTap:
              () async {
            final picked =
            await showDatePicker(
              context:
              context,
              firstDate:
              DateTime(
                2000,
              ),
              lastDate:
              DateTime(
                2100,
              ),
              initialDate:
              _parseDate(
                answers[
                field.key],
              ) ??
                  DateTime
                      .now(),
            );

            if (picked !=
                null) {
              final formatted =
              _formatDate(
                picked,
              );

              onChanged(
                field.key,
                formatted,
              );
            }
          },
        );

    /// =====================================================
    /// Checkbox
    /// =====================================================

      case FieldType.checkbox:
        return const SizedBox();
    }
  }

  DateTime? _parseDate(
      dynamic value,
      ) {
    if (value == null) {
      return null;
    }

    return DateTime.tryParse(
      value.toString(),
    );
  }

  String _formatDate(
      DateTime date,
      ) {
    final month =
    date.month
        .toString()
        .padLeft(
      2,
      '0',
    );

    final day =
    date.day
        .toString()
        .padLeft(
      2,
      '0',
    );

    return '${date.year}-$month-$day';
  }
}

/// ===========================================================
/// FIELD LABEL
/// ===========================================================

class _FieldLabel extends StatelessWidget {
  final String label;
  final bool required;

  const _FieldLabel({
    required this.label,
    required this.required,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: label,
        style:
        const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight:
          FontWeight.w700,
        ),
        children: [
          if (required)
            const TextSpan(
              text: ' *',
              style:
              TextStyle(
                color:
                Colors.red,
              ),
            ),
        ],
      ),
    );
  }
}

/// ===========================================================
/// DYNAMIC TEXT FIELD
/// ===========================================================

class DynamicTextField
    extends StatelessWidget {
  final String hint;
  final String? value;

  final TextInputType
  keyboardType;

  final ValueChanged<String>
  onChanged;

  const DynamicTextField({
    super.key,
    required this.hint,
    required this.value,
    required this.onChanged,
    this.keyboardType =
        TextInputType.text,
  });

  @override
  Widget build(
      BuildContext context,
      ) {
    return TextFormField(
      initialValue: value,
      keyboardType:
      keyboardType,
      onChanged:
      onChanged,
      style:
      const TextStyle(
        color: Colors.white,
      ),
      decoration:
      InputDecoration(
        hintText: hint,
        hintStyle:
        const TextStyle(
          color:
          Colors.white38,
          fontSize: 12,
        ),
        filled: true,
        fillColor:
        kCardColor,
        contentPadding:
        const EdgeInsets
            .symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        border:
        OutlineInputBorder(
          borderRadius:
          BorderRadius
              .circular(
            14,
          ),
        ),
        enabledBorder:
        OutlineInputBorder(
          borderRadius:
          BorderRadius
              .circular(
            14,
          ),
          borderSide:
          const BorderSide(
            color:
            kSecondaryColor,
          ),
        ),
        focusedBorder:
        OutlineInputBorder(
          borderRadius:
          BorderRadius
              .circular(
            14,
          ),
          borderSide:
          const BorderSide(
            color:
            kPrimaryColor,
          ),
        ),
      ),
    );
  }
}

/// ===========================================================
/// DYNAMIC DROPDOWN
/// ===========================================================

class DynamicDropdown
    extends StatelessWidget {
  final dynamic value;

  final List<FormOptionConfig>
  items;

  final String hint;

  final ValueChanged<dynamic>
  onChanged;

  const DynamicDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hint =
    'Select option',
  });

  @override
  Widget build(
      BuildContext context,
      ) {
    /// Only use current value
    /// if API options actually contain it.
    dynamic selectedValue;

    for (final item in items) {
      if (item.value ==
          value) {
        selectedValue =
            item.value;

        break;
      }
    }

    return DropdownButtonFormField<
        dynamic>(
      value:
      selectedValue,
      isExpanded: true,
      dropdownColor:
      kCardColor,
      iconEnabledColor:
      Colors.white,
      style:
      const TextStyle(
        color: Colors.white,
        fontSize: 12,
      ),
      hint: Text(
        hint,
        maxLines: 1,
        overflow:
        TextOverflow.ellipsis,
        style:
        const TextStyle(
          color:
          Colors.white38,
          fontSize: 12,
        ),
      ),
      decoration:
      InputDecoration(
        filled: true,
        fillColor:
        kCardColor,
        contentPadding:
        const EdgeInsets
            .symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        border:
        OutlineInputBorder(
          borderRadius:
          BorderRadius
              .circular(
            14,
          ),
        ),
        enabledBorder:
        OutlineInputBorder(
          borderRadius:
          BorderRadius
              .circular(
            14,
          ),
          borderSide:
          const BorderSide(
            color:
            kSecondaryColor,
          ),
        ),
        focusedBorder:
        OutlineInputBorder(
          borderRadius:
          BorderRadius
              .circular(
            14,
          ),
          borderSide:
          const BorderSide(
            color:
            kPrimaryColor,
          ),
        ),
      ),
      items: items.map(
            (option) {
          return DropdownMenuItem<
              dynamic>(
            value:
            option.value,
            child: Text(
              option.label,
              maxLines: 1,
              overflow:
              TextOverflow
                  .ellipsis,
            ),
          );
        },
      ).toList(),
      onChanged:
      onChanged,
    );
  }
}

/// ===========================================================
/// STEP BUTTON
/// ===========================================================

class StepButton
    extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onTap;
  final double height;
  final double textSize;

  const StepButton({
    super.key,
    required this.text,
    required this.color,
    required this.onTap,
    this.height = 42,
    this.textSize = 13,
  });

  @override
  Widget build(
      BuildContext context,
      ) {
    return SizedBox(
      width:
      double.infinity,
      height: height,
      child:
      ElevatedButton(
        style:
        ElevatedButton
            .styleFrom(
          backgroundColor:
          color,
          elevation: 0,
          shape:
          RoundedRectangleBorder(
            borderRadius:
            BorderRadius
                .circular(
              999,
            ),
          ),
        ),
        onPressed:
        onTap,
        child: Text(
          text,
          style:
          TextStyle(
            color:
            Colors.white,
            fontSize:
            textSize,
            fontWeight:
            FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

/// ===========================================================
/// DYNAMIC TEXT AREA
/// ===========================================================

class DynamicTextArea
    extends StatelessWidget {
  final String hint;
  final String? value;

  final ValueChanged<String>
  onChanged;

  const DynamicTextArea({
    super.key,
    required this.hint,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(
      BuildContext context,
      ) {
    return TextFormField(
      initialValue:
      value,
      maxLines: 5,
      minLines: 4,
      onChanged:
      onChanged,
      style:
      const TextStyle(
        color: Colors.white,
      ),
      decoration:
      InputDecoration(
        hintText: hint,
        hintStyle:
        const TextStyle(
          color:
          Colors.white38,
          fontSize: 12,
        ),
        filled: true,
        fillColor:
        kCardColor,
        contentPadding:
        const EdgeInsets
            .all(
          16,
        ),
        border:
        OutlineInputBorder(
          borderRadius:
          BorderRadius
              .circular(
            14,
          ),
        ),
        enabledBorder:
        OutlineInputBorder(
          borderRadius:
          BorderRadius
              .circular(
            14,
          ),
          borderSide:
          const BorderSide(
            color:
            kSecondaryColor,
          ),
        ),
        focusedBorder:
        OutlineInputBorder(
          borderRadius:
          BorderRadius
              .circular(
            14,
          ),
          borderSide:
          const BorderSide(
            color:
            kPrimaryColor,
          ),
        ),
      ),
    );
  }
}

/// ===========================================================
/// DATE FIELD
/// ===========================================================

class DateField
    extends StatelessWidget {
  final String? value;
  final VoidCallback onTap;

  const DateField({
    super.key,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(
      BuildContext context,
      ) {
    final hasValue =
        value != null &&
            value!.trim().isNotEmpty;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        alignment:
        Alignment.centerLeft,
        padding:
        const EdgeInsets
            .symmetric(
          horizontal: 14,
        ),
        decoration:
        BoxDecoration(
          color:
          kCardColor,
          borderRadius:
          BorderRadius
              .circular(
            14,
          ),
          border:
          Border.all(
            color:
            kSecondaryColor,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                hasValue
                    ? value!
                    : 'Select Date',
                maxLines: 1,
                overflow:
                TextOverflow
                    .ellipsis,
                style:
                TextStyle(
                  color: hasValue
                      ? Colors.white
                      : Colors
                      .white38,
                  fontSize: 12,
                ),
              ),
            ),

            const SizedBox(
              width: 8,
            ),

            const Icon(
              Icons
                  .calendar_month_outlined,
              color:
              Colors.white70,
              size: 19,
            ),
          ],
        ),
      ),
    );
  }
}

/// ===========================================================
/// CHECKBOX
/// ===========================================================

class DynamicCheckbox
    extends StatelessWidget {
  final bool value;
  final String label;
  final bool required;

  final ValueChanged<bool>
  onChanged;

  const DynamicCheckbox({
    super.key,
    required this.value,
    required this.label,
    required this.onChanged,
    this.required = false,
  });

  @override
  Widget build(
      BuildContext context,
      ) {
    return Row(
      children: [
        Checkbox(
          value: value,
          side:
          const BorderSide(
            color: Colors.white,
          ),
          checkColor:
          Colors.white,
          activeColor:
          const Color(
            0xFF00C853,
          ),
          onChanged:
              (value) {
            onChanged(
              value ?? false,
            );
          },
        ),

        Expanded(
          child: Text.rich(
            TextSpan(
              text: label,
              style:
              const TextStyle(
                color:
                Colors.white,
                fontSize: 12,
              ),
              children: [
                if (required)
                  const TextSpan(
                    text: ' *',
                    style:
                    TextStyle(
                      color:
                      Colors.red,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}