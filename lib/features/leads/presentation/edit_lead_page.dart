import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sale_pipeline_business/utils/app_colors.dart';
import '../../new_lead_step_page/model/lead_form_config_response.dart';
import '../../new_lead_step_page/presentation/base_widgets.dart';
import '../../new_lead_step_page/presentation/new_lead_step_page.dart';
import '../controller/leads_controller.dart';
import '../data/leads_repository.dart';

enum EditStepType { selection, form }

enum EditFieldType { text, number, dropdown, textarea, date, checkbox }

class EditFormOptionConfig {
  final dynamic value;
  final String label;

  const EditFormOptionConfig({required this.value, required this.label});
}

class EditStepConfig {
  final String key;
  final String title;
  final EditStepType type;
  final List<EditFormOptionConfig> options;
  final List<EditFormFieldConfig> fields;
  final bool showSkip;
  final dynamic selectedValue;

  const EditStepConfig({
    required this.key,
    required this.title,
    required this.type,
    this.options = const [],
    this.fields = const [],
    this.showSkip = false,
    this.selectedValue,
  });
}

class EditFormFieldConfig {
  final String key;
  final String label;
  final EditFieldType type;
  final bool required;
  final bool multiple;
  final List<EditFormOptionConfig> options;

  final dynamic selectedValue;

  const EditFormFieldConfig({
    required this.key,
    required this.label,
    required this.type,
    this.required = false,
    this.multiple = false,
    this.options = const [],
    this.selectedValue,
  });
}

class EditLeadPage extends ConsumerStatefulWidget {
  const EditLeadPage({super.key, required this.leadId});

  final int leadId;

  @override
  ConsumerState<EditLeadPage> createState() => _EditLeadPageState();
}

class _EditLeadPageState extends ConsumerState<EditLeadPage> {
  int currentStep = 0;

  /// Current UI values.
  final Map<String, dynamic> answers = {};

  /// Original API values.
  ///
  /// Useful if later you want to send only changed fields.
  final Map<String, dynamic> originalAnswers = {};

  bool _initialValuesLoaded = false;

  /// ============================================================
  /// MAP API STEPS
  /// ============================================================

  List<EditStepConfig> _mapApiSteps(List<LeadFormStepVO> apiSteps) {
    return apiSteps.map((apiStep) {
      return EditStepConfig(
        key: apiStep.key ?? '',
        title: apiStep.title ?? '',
        type: _mapStepType(apiStep.type),
        showSkip: apiStep.showSkip ?? false,
        options: _mapOptions(apiStep.options),
        selectedValue: apiStep.selectedValue,
        fields: (apiStep.fields ?? []).map(_mapApiField).toList(),
      );
    }).toList();
  }

  EditStepType _mapStepType(String? type) {
    switch (type?.toLowerCase()) {
      case 'selection':
        return EditStepType.selection;

      case 'form':
      default:
        return EditStepType.form;
    }
  }

  EditFormFieldConfig _mapApiField(LeadFormFieldVO field) {
    return EditFormFieldConfig(
      key: field.key ?? '',
      label: field.label ?? '',
      type: _mapFieldType(field.type),
      required: field.required ?? false,
      multiple: field.multiple ?? false,
      options: _mapOptions(field.options),
      selectedValue: field.selectedValue,
    );
  }

  EditFieldType _mapFieldType(String? type) {
    switch (type?.toLowerCase()) {
      case 'number':
        return EditFieldType.number;

      case 'dropdown':
        return EditFieldType.dropdown;

      case 'textarea':
        return EditFieldType.textarea;

      case 'date':
        return EditFieldType.date;

      case 'checkbox':
        return EditFieldType.checkbox;

      case 'text':
      default:
        return EditFieldType.text;
    }
  }

  List<EditFormOptionConfig> _mapOptions(List<dynamic>? options) {
    if (options == null) {
      return [];
    }

    final result = <EditFormOptionConfig>[];

    for (final option in options) {
      /// String
      ///
      /// "Won"
      if (option is String) {
        result.add(EditFormOptionConfig(value: option, label: option));

        continue;
      }

      /// Object
      ///
      /// {
      ///   "id": 19,
      ///   "label": "Allison"
      /// }
      if (option is Map) {
        final value = option['id'] ?? option['value'] ?? option['label'];

        final label =
            option['label']?.toString() ??
            option['name']?.toString() ??
            value?.toString() ??
            '';

        if (label.isNotEmpty) {
          result.add(EditFormOptionConfig(value: value, label: label));
        }

        continue;
      }

      if (option != null) {
        result.add(
          EditFormOptionConfig(value: option, label: option.toString()),
        );
      }
    }

    return result;
  }

  /// ============================================================
  /// INITIAL VALUES
  /// ============================================================

  void _initializeSelectedValues(List<EditStepConfig> steps) {
    /// Important:
    /// Do not initialize again after user changes a field.
    if (_initialValuesLoaded) {
      return;
    }

    for (final step in steps) {
      /// Selection step
      if (step.type == EditStepType.selection &&
          !_isEmptyValue(step.selectedValue)) {
        final normalized = _normalizeSelectedValue(
          selectedValue: step.selectedValue,
          options: step.options,
          multiple: false,
        );

        answers[step.key] = normalized;

        originalAnswers[step.key] = normalized;
      }

      /// Form fields
      for (final field in step.fields) {
        if (_isEmptyValue(field.selectedValue)) {
          continue;
        }

        final normalized = _normalizeSelectedValue(
          selectedValue: field.selectedValue,
          options: field.options,
          multiple: field.multiple,
        );

        answers[field.key] = normalized;

        originalAnswers[field.key] = normalized;
      }
    }

    _initialValuesLoaded = true;

    debugPrint(
      'EDIT LEAD INITIAL VALUES >>> '
      '$answers',
    );
  }

  dynamic _normalizeSelectedValue({
    required dynamic selectedValue,
    required List<EditFormOptionConfig> options,
    required bool multiple,
  }) {
    if (selectedValue == null) {
      return null;
    }

    if (multiple) {
      final values = selectedValue is List ? selectedValue : [selectedValue];

      return values
          .map((value) => _findMatchingOptionValue(value, options))
          .where((value) => value != null)
          .toList();
    }

    return _findMatchingOptionValue(selectedValue, options);
  }

  dynamic _findMatchingOptionValue(
    dynamic selectedValue,
    List<EditFormOptionConfig> options,
  ) {
    if (options.isEmpty) {
      return selectedValue;
    }

    final selectedString = selectedValue.toString().trim();

    for (final option in options) {
      if (option.value.toString().trim() == selectedString) {
        return option.value;
      }
      if (option.label.trim() == selectedString) {
        return option.value;
      }
    }
    return selectedValue;
  }

  /// ============================================================
  /// VALIDATION
  /// ============================================================

  bool _validateStep(EditStepConfig step) {
    if (step.type == EditStepType.selection) {
      final value = answers[step.key];

      if (_isEmptyValue(value)) {
        _showError('Please select one option');

        return false;
      }

      return true;
    }

    for (final field in step.fields) {
      if (!field.required) {
        continue;
      }

      final value = answers[field.key];

      if (field.type == EditFieldType.checkbox) {
        if (value != true) {
          _showError('${field.label} is required');

          return false;
        }

        continue;
      }

      if (_isEmptyValue(value)) {
        _showError('${field.label} is required');

        return false;
      }
    }

    return true;
  }

  bool _isEmptyValue(dynamic value) {
    if (value == null) {
      return true;
    }

    if (value is String) {
      return value.trim().isEmpty;
    }

    if (value is List) {
      return value.isEmpty;
    }

    return false;
  }

  /// ============================================================
  /// NEXT
  /// ============================================================

  void _next(List<EditStepConfig> steps) {
    if (steps.isEmpty) {
      return;
    }

    if (currentStep >= steps.length) {
      return;
    }

    final step = steps[currentStep];

    if (!_validateStep(step)) {
      return;
    }

    if (currentStep < steps.length - 1) {
      setState(() {
        currentStep++;
      });

      return;
    }

    /// Last step
    _updateLead(steps);
  }

  /// ============================================================
  /// BACK
  /// ============================================================

  void _back() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });

      return;
    }

    Navigator.of(context).pop();
  }

  /// ============================================================
  /// SKIP
  /// ============================================================

  void _skipStep(List<EditStepConfig> steps) {
    if (currentStep < steps.length - 1) {
      setState(() {
        currentStep++;
      });

      return;
    }

    _updateLead(steps);
  }

  /// ============================================================
  /// UPDATE
  /// ============================================================

  Future<void> _updateLead(List<EditStepConfig> steps) async {
    final labeledFields = <Map<String, dynamic>>[];

    for (final step in steps) {
      /// Selection step
      if (step.type == EditStepType.selection) {
        final value = answers[step.key];

        if (!_isEmptyValue(value)) {
          labeledFields.add({'key': step.key, 'selected_value': value});
        }
      }

      /// Form step
      for (final field in step.fields) {
        final value = answers[field.key];

        if (_isEmptyValue(value)) {
          continue;
        }

        labeledFields.add({'key': field.key, 'selected_value': value});
      }
    }

    final payload = <String, dynamic>{'labeled_fields': labeledFields};

    debugPrint('================ UPDATE LEAD ================');

    debugPrint(payload.toString());

    debugPrint('=============================================');

    final success = await ref
        .read(leadsControllerProvider.notifier)
        .updateLead(leadId: widget.leadId, payload: payload);

    if (!mounted) {
      return;
    }

    if (!success) {
      final error = ref.read(leadsControllerProvider).error;

      _showError(error?.toString() ?? 'Failed to update lead');

      return;
    }

    Navigator.of(context).pop(true);
  }

  /// ============================================================
  /// BUILD
  /// ============================================================

  @override
  Widget build(BuildContext context) {
    final editConfigState = ref.watch(
      editLeadFormConfigProvider(leadId: widget.leadId),
    );

    final controllerState = ref.watch(leadsControllerProvider);

    return Stack(
      children: [
        Scaffold(
          backgroundColor: const Color(0xFF061B10),
          body: SafeArea(
            child: editConfigState.when(
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(color: kPrimaryColor),
                );
              },

              error: (error, stackTrace) {
                return _buildErrorView(error);
              },

              data: (response) {
                final apiSteps = response.data?.steps ?? [];

                final steps = _mapApiSteps(apiSteps);

                if (steps.isEmpty) {
                  return _buildEmptyView();
                }

                /// Load selected_value only once.
                _initializeSelectedValues(steps);

                return _buildStepContent(steps);
              },
            ),
          ),
        ),

        if (controllerState.isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(color: kPrimaryColor),
              ),
            ),
          ),
      ],
    );
  }

  /// ============================================================
  /// STEP CONTENT
  /// ============================================================

  Widget _buildStepContent(List<EditStepConfig> steps) {
    final safeCurrentStep = currentStep >= steps.length ? 0 : currentStep;

    final step = steps[safeCurrentStep];

    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 28, 22, 22),
      child: Column(
        children: [
          if (steps.length > 1)
            StepIndicator(total: steps.length, current: safeCurrentStep),

          const SizedBox(height: 10),

          if (step.title.isNotEmpty)
            Text(
              step.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: kPrimaryColor,
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),

          if (step.title.isNotEmpty) const SizedBox(height: 30),

          Expanded(child: _buildStepBody(step)),

          const SizedBox(height: 30),

          Row(
            children: [
              Expanded(
                child: StepButton(
                  text: 'Back',
                  color: kSecondaryColor,
                  onTap: _back,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: StepButton(
                  text: safeCurrentStep == steps.length - 1
                      ? 'Update'
                      : 'Continue',
                  color: kPrimaryColor,
                  onTap: () {
                    _next(steps);
                  },
                ),
              ),
            ],
          ),

          if (step.showSkip) ...[
            const SizedBox(height: 18),

            GestureDetector(
              onTap: () {
                _skipStep(steps);
              },
              child: const Text(
                'Skip For Now',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// ============================================================
  /// STEP BODY
  /// ============================================================

  Widget _buildStepBody(EditStepConfig step) {
    switch (step.type) {
      case EditStepType.selection:
        return SelectionStep(
          options: step.options
              .map(
                (option) =>
                    FormOptionConfig(value: option.value, label: option.label),
              )
              .toList(),

          /// Here previous selected_value
          /// is shown automatically.
          selectedValue: answers[step.key],

          onSelected: (value) {
            setState(() {
              answers[step.key] = value;
            });
          },
        );

      case EditStepType.form:
        return FormStep(
          fields: step.fields
              .map(
                (field) => FormFieldConfig(
                  key: field.key,
                  label: field.label,
                  type: _toCreateFieldType(field.type),
                  required: field.required,
                  multiple: field.multiple,
                  options: field.options
                      .map(
                        (option) => FormOptionConfig(
                          value: option.value,
                          label: option.label,
                        ),
                      )
                      .toList(),
                ),
              )
              .toList(),

          /// Existing values are already
          /// stored here from selected_value.
          answers: answers,

          onChanged: (key, value) {
            setState(() {
              answers[key] = value;
            });
          },
        );
    }
  }

  FieldType _toCreateFieldType(EditFieldType type) {
    switch (type) {
      case EditFieldType.number:
        return FieldType.number;

      case EditFieldType.dropdown:
        return FieldType.dropdown;

      case EditFieldType.textarea:
        return FieldType.textarea;

      case EditFieldType.date:
        return FieldType.date;

      case EditFieldType.checkbox:
        return FieldType.checkbox;

      case EditFieldType.text:
        return FieldType.text;
    }
  }

  /// ============================================================
  /// ERROR
  /// ============================================================

  Widget _buildErrorView(Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.redAccent, size: 45),

            const SizedBox(height: 16),

            Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),

            const SizedBox(height: 24),

            StepButton(
              text: 'Retry',
              color: kPrimaryColor,
              onTap: () {
                ref.invalidate(
                  editLeadFormConfigProvider(leadId: widget.leadId),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// ============================================================
  /// EMPTY
  /// ============================================================

  Widget _buildEmptyView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'No edit lead form configuration available.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),

            const SizedBox(height: 24),

            StepButton(
              text: 'Refresh',
              color: kPrimaryColor,
              onTap: () {
                ref.invalidate(
                  editLeadFormConfigProvider(leadId: widget.leadId),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
