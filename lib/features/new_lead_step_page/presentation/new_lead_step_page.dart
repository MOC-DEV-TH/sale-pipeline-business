import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sale_pipeline_business/utils/app_colors.dart';

import '../../../routing/go_router/go_router_delegate.dart';

import '../../choose_task_page/provider/selected_organization_provider.dart';

import '../data/new_lead_repository.dart';
import '../model/lead_form_config_response.dart';
import 'base_widgets.dart';
import 'success_step_page.dart';

enum StepType { selection, form, success }

enum FieldType { text, number, dropdown, textarea, date, checkbox }

class FormOptionConfig {
  final dynamic value;
  final String label;

  const FormOptionConfig({required this.value, required this.label});
}

class StepConfig {
  final String key;
  final String title;
  final StepType type;
  final List<FormOptionConfig> options;
  final List<FormFieldConfig> fields;
  final bool showSkip;

  const StepConfig({
    required this.key,
    required this.title,
    required this.type,
    this.options = const [],
    this.fields = const [],
    this.showSkip = false,
  });
}

class FormFieldConfig {
  final String key;
  final String label;
  final FieldType type;
  final bool required;
  final bool multiple;
  final List<FormOptionConfig> options;

  const FormFieldConfig({
    required this.key,
    required this.label,
    required this.type,
    this.required = false,
    this.multiple = false,
    this.options = const [],
  });
}

class NewLeadStepPage extends ConsumerStatefulWidget {
  const NewLeadStepPage({super.key});

  @override
  ConsumerState<NewLeadStepPage> createState() => _NewLeadStepPageState();
}

class _NewLeadStepPageState extends ConsumerState<NewLeadStepPage> {
  int currentStep = 0;

  final Map<String, dynamic> answers = {};

  /// =========================================================
  /// API STEP MAPPER
  /// =========================================================

  List<StepConfig> _mapApiSteps(List<LeadFormStepVO> apiSteps) {
    return apiSteps.map((apiStep) {
      return StepConfig(
        key: apiStep.key ?? '',
        title: apiStep.title ?? '',
        type: _mapStepType(apiStep.type),
        showSkip: apiStep.showSkip ?? false,
        options: _mapOptions(apiStep.options),
        fields: (apiStep.fields ?? []).map(_mapApiField).toList(),
      );
    }).toList();
  }

  StepType _mapStepType(String? type) {
    switch (type?.toLowerCase()) {
      case 'selection':
        return StepType.selection;

      case 'success':
        return StepType.success;

      case 'form':
      default:
        return StepType.form;
    }
  }

  FormFieldConfig _mapApiField(LeadFormFieldVO field) {
    return FormFieldConfig(
      key: field.key ?? '',
      label: field.label ?? '',
      type: _mapFieldType(field.type),
      required: field.required ?? false,
      multiple: field.multiple ?? false,
      options: _mapOptions(field.options),
    );
  }

  FieldType _mapFieldType(String? type) {
    switch (type?.toLowerCase()) {
      case 'number':
        return FieldType.number;

      case 'dropdown':
        return FieldType.dropdown;

      case 'textarea':
        return FieldType.textarea;

      case 'date':
        return FieldType.date;

      case 'checkbox':
        return FieldType.checkbox;

      case 'text':
      default:
        return FieldType.text;
    }
  }

  List<FormOptionConfig> _mapOptions(List<dynamic>? options) {
    if (options == null) {
      return [];
    }

    final result = <FormOptionConfig>[];

    for (final option in options) {
      /// String option
      if (option is String) {
        result.add(FormOptionConfig(value: option, label: option));

        continue;
      }

      /// Object option
      if (option is Map) {
        final value = option['id'] ?? option['value'] ?? option['label'];

        final label =
            option['label']?.toString() ??
            option['name']?.toString() ??
            value?.toString() ??
            '';

        if (label.isNotEmpty) {
          result.add(FormOptionConfig(value: value, label: label));
        }

        continue;
      }

      /// Other value
      if (option != null) {
        result.add(FormOptionConfig(value: option, label: option.toString()));
      }
    }

    return result;
  }

  /// =========================================================
  /// NEXT
  /// =========================================================

  void _next(List<StepConfig> steps) {
    if (steps.isEmpty) {
      return;
    }

    if (currentStep >= steps.length) {
      return;
    }

    final step = steps[currentStep];

    /// =====================================================
    /// Selection validation
    /// =====================================================

    if (step.type == StepType.selection) {
      final value = answers[step.key];

      if (_isEmptyValue(value)) {
        _showError('Please select one option');

        return;
      }
    }

    /// =====================================================
    /// Form validation
    /// =====================================================

    if (step.type == StepType.form) {
      for (final field in step.fields) {
        if (!field.required) {
          continue;
        }

        final value = answers[field.key];

        if (field.type == FieldType.checkbox) {
          if (value != true) {
            _showError('${field.label} is required');

            return;
          }

          continue;
        }

        if (_isEmptyValue(value)) {
          _showError('${field.label} is required');

          return;
        }
      }
    }

    /// =====================================================
    /// Check if next step is success
    /// =====================================================

    final nextIndex = currentStep + 1;

    final isBeforeSuccess =
        nextIndex < steps.length && steps[nextIndex].type == StepType.success;

    if (isBeforeSuccess) {
      _preparePayload();
    }

    /// =====================================================
    /// Next
    /// =====================================================

    if (currentStep < steps.length - 1) {
      setState(() {
        currentStep++;
      });
    }
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

  /// =========================================================
  /// PAYLOAD
  /// =========================================================

  Future<void> _preparePayload() async {
    final organizationId = ref.watch(
      selectedOrganizationProvider.select((organization) => organization?.id),
    );

    final payload = Map<String, dynamic>.from(answers);

    payload.removeWhere((key, value) {
      return _isEmptyValue(value);
    });

    /// Add selected organization
    payload['organization_id'] = organizationId;

    debugPrint('================ LEAD PAYLOAD ================');

    debugPrint(payload.toString());

    debugPrint('==============================================');

    try {
      final response = await ref
          .read(newLeadRepositoryProvider)
          .submitLead(payload: payload);

      debugPrint('Submit Lead Response >>> ${response.status}');

      if (!mounted) {
        return;
      }

      /// move to success step after submit success
    } catch (e) {
      debugPrint('Submit Lead Error >>> $e');

      if (!mounted) {
        return;
      }

      _showError(e.toString());

      rethrow;
    }
  }

  /// =========================================================
  /// BACK
  /// =========================================================

  void _back() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });

      return;
    }

    context.go(RoutePath.chooseTask.path);
  }

  /// =========================================================
  /// SKIP
  /// =========================================================

  void _skipStep(List<StepConfig> steps) {
    if (currentStep < steps.length - 1) {
      setState(() {
        currentStep++;
      });
    }
  }

  /// =========================================================
  /// ERROR
  /// =========================================================

  void _showError(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
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

  /// =========================================================
  /// BUILD
  /// =========================================================

  @override
  Widget build(BuildContext context) {
    final organizationId = ref.watch(
      selectedOrganizationProvider.select((organization) => organization?.id),
    );

    /// Organization is required
    if (organizationId == null) {
      return Scaffold(
        backgroundColor: const Color(0xFF061B10),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Please select an organization.',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),

                const SizedBox(height: 20),

                StepButton(
                  text: 'Back',
                  color: kSecondaryColor,
                  onTap: () {
                    context.go(RoutePath.chooseTask.path);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }

    /// =====================================================
    /// Lead form config API
    /// =====================================================

    final leadFormConfigState = ref.watch(
      fetchLeadFormConfigProvider(organizationID: organizationId),
    );

    return Scaffold(
      backgroundColor: const Color(0xFF061B10),
      body: SafeArea(
        child: leadFormConfigState.when(
          loading: () {
            return const Center(
              child: CircularProgressIndicator(color: kPrimaryColor),
            );
          },

          error: (error, stackTrace) {
            return _buildErrorView(error, organizationId);
          },

          data: (response) {
            final apiSteps = response.data?.steps ?? [];

            final steps = _mapApiSteps(apiSteps);

            if (steps.isEmpty) {
              return _buildEmptyView(organizationId);
            }

            return _buildStepContent(steps);
          },
        ),
      ),
    );
  }

  /// =========================================================
  /// STEP CONTENT
  /// =========================================================

  Widget _buildStepContent(List<StepConfig> steps) {
    /// Protect against API config changing
    final safeCurrentStep = currentStep >= steps.length ? 0 : currentStep;

    final step = steps[safeCurrentStep];

    final visibleSteps = steps
        .where((item) => item.type != StepType.success)
        .toList();

    final showIndicator = visibleSteps.length > 1;

    /// Indicator index should not count
    /// success step.
    final indicatorCurrent = safeCurrentStep.clamp(0, visibleSteps.length - 1);

    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 28, 22, 22),
      child: Column(
        children: [
          /// =================================================
          /// Step indicator
          /// =================================================
          if (step.type != StepType.success && showIndicator) ...[
            StepIndicator(
              total: visibleSteps.length,
              current: indicatorCurrent,
            ),
          ],

          const SizedBox(height: 10),

          /// =================================================
          /// Title
          /// =================================================
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

          /// =================================================
          /// Body
          /// =================================================
          Expanded(child: _buildStepBody(step)),

          const SizedBox(height: 30),

          /// =================================================
          /// Buttons
          /// =================================================
          if (step.type != StepType.success) ...[
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
                    text: 'Continue',
                    color: kPrimaryColor,
                    onTap: () {
                      _next(steps);
                    },
                  ),
                ),
              ],
            ),
          ],

          /// =================================================
          /// Skip
          /// =================================================
          if (step.showSkip && step.type != StepType.success) ...[
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

  /// =========================================================
  /// STEP BODY
  /// =========================================================

  Widget _buildStepBody(StepConfig step) {
    switch (step.type) {
      case StepType.selection:
        return SelectionStep(
          options: step.options,
          selectedValue: answers[step.key],
          onSelected: (value) {
            setState(() {
              answers[step.key] = value;
            });
          },
        );

      case StepType.form:
        return FormStep(
          fields: step.fields,
          answers: answers,
          onChanged: (key, value) {
            setState(() {
              answers[key] = value;
            });
          },
        );

      case StepType.success:
        return SuccessStepPage(
          onAddNewLead: () {
            setState(() {
              currentStep = 0;
              answers.clear();
            });
          },
          onGoDashboard: () {
            context.go('/');
          },
        );
    }
  }

  /// =========================================================
  /// ERROR
  /// =========================================================

  Widget _buildErrorView(Object error, int organizationId) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 45),

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
                  fetchLeadFormConfigProvider(organizationID: organizationId),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// =========================================================
  /// EMPTY
  /// =========================================================

  Widget _buildEmptyView(int organizationId) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'No lead form configuration available.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),

            const SizedBox(height: 24),

            StepButton(
              text: 'Refresh',
              color: kPrimaryColor,
              onTap: () {
                ref.invalidate(
                  fetchLeadFormConfigProvider(organizationID: organizationId),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
