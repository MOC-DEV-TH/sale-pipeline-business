import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sale_pipeline_business/utils/app_colors.dart';

import '../../../routing/go_router/go_router_delegate.dart';
import 'base_widgets.dart';
import 'success_step_page.dart' show SuccessStepPage;

enum StepType { selection, form, success }

enum FieldType { text, dropdown, textarea, date, checkbox }

class StepConfig {
  final String key;
  final String title;
  final StepType type;
  final List<String> options;
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
  final List<String> options;

  const FormFieldConfig({
    required this.key,
    required this.label,
    required this.type,
    this.required = false,
    this.options = const [],
  });
}

class NewLeadStepPage extends StatefulWidget {
  const NewLeadStepPage({super.key});

  @override
  State<NewLeadStepPage> createState() => _NewLeadStepPageState();
}

class _NewLeadStepPageState extends State<NewLeadStepPage> {
  int currentStep = 0;

  final Map<String, dynamic> answers = {};

  ///dummy data for steps data
  final steps = const [
    StepConfig(
      key: 'lead_source',
      title: 'Choose the leads source.',
      type: StepType.selection,
      options: [
        'Door to Door',
        'Cold Call',
        'Own Lead',
        'Partner Agent',
        'Consumer',
      ],
    ),
    StepConfig(
      key: 'business_type',
      title: 'Choose the type of business.',
      type: StepType.selection,
      options: [
        'Condo',
        'Hotel',
        'Bar / Restaurant / KTV',
        'Home',
        'Agriculture',
        'Bank & Financial Services',
        'Conglomerate',
        'Construction & Engineering',
        'Distribution',
        'Education',
      ],
    ),
    StepConfig(
      key: '',
      title: 'Enter the business information.',
      type: StepType.form,
      fields: [
        FormFieldConfig(
          key: 'business_name',
          label: 'Business Name',
          type: FieldType.text,
        ),
        FormFieldConfig(
          key: 'address',
          label: 'Address',
          type: FieldType.text,
          required: true,
        ),
        FormFieldConfig(
          key: 'division',
          label: 'Division',
          type: FieldType.dropdown,
          required: true,
          options: ['Yangon (Default)', 'Mandalay', 'Naypyidaw'],
        ),
        FormFieldConfig(
          key: 'township',
          label: 'Township',
          type: FieldType.dropdown,
          required: true,
          options: ['Select Township', 'Hlaing', 'Kamayut', 'Tamwe'],
        ),
      ],
    ),
    StepConfig(
      key: 'meeting_person',
      title: 'Who did you meet with?',
      type: StepType.selection,
      showSkip: true,
      options: [
        'CEO',
        'CTO',
        'IT Team',
        'Manager',
        'Receptionist',
        'Staff',
        'Home Owner',
      ],
    ),
    StepConfig(
      key: '',
      title: 'Enter the contact information.',
      type: StepType.form,
      showSkip: true,
      fields: [
        FormFieldConfig(
          key: 'name',
          label: 'Name',
          type: FieldType.text,
        ),

        FormFieldConfig(
          key: 'primary_contact',
          label: 'Primary Contact No.',
          type: FieldType.text,
        ),

        FormFieldConfig(
          key: 'secondary_contact',
          label: 'Secondary Contact No.',
          type: FieldType.text,
        ),
        FormFieldConfig(key: 'email', label: 'Email', type: FieldType.text),
      ],
    ),
    StepConfig(
      key: '',
      title: 'Select Potential %.',
      type: StepType.form,
      showSkip: true,
      fields: [
        FormFieldConfig(
          key: 'potential',
          label: 'Potential',
          type: FieldType.dropdown,
          options: ['Yes (Default)', 'No'],
        ),
        FormFieldConfig(
          key: 'customer_type',
          label: 'Customer Type',
          type: FieldType.dropdown,
          required: true,
          options: [
            'Select Customer Type',
            'New Customer',
            'Existing Customer',
          ],
        ),
        FormFieldConfig(
          key: 'status',
          label: 'Status',
          type: FieldType.dropdown,
          options: ['Select Status', 'Hot', 'Warm', 'Cold'],
        ),
        FormFieldConfig(
          key: 'plan',
          label: 'Plan',
          type: FieldType.dropdown,
          required: true,
          options: ['Select Plan', 'Basic', 'Standard', 'Premium'],
        ),
        FormFieldConfig(
          key: 'package',
          label: 'Package',
          type: FieldType.dropdown,
          required: true,
          options: ['Select Package', 'Monthly', 'Yearly'],
        ),
        FormFieldConfig(
          key: 'amount',
          label: 'Amount',
          type: FieldType.text,
          required: true,
        ),
        FormFieldConfig(
          key: 'discount',
          label: 'Discount',
          type: FieldType.dropdown,
          required: true,
          options: ['0%', '5%', '10%', '15%'],
        ),
        FormFieldConfig(
          key: 'contract_date',
          label: 'Est. Contract Date',
          type: FieldType.date,
          required: true,
        ),
        FormFieldConfig(
          key: 'start_date',
          label: 'Est. Start Date',
          type: FieldType.date,
          required: true,
        ),
        FormFieldConfig(
          key: 'follow_up_date',
          label: 'Est. Follow Up Date',
          type: FieldType.date,
        ),
        FormFieldConfig(
          key: 'is_referral',
          label: 'Is Referral',
          type: FieldType.checkbox,
        ),
      ],
    ),
    StepConfig(
      key: '',
      title: '',
      type: StepType.form,
      fields: [
        FormFieldConfig(
          key: 'meeting_notes',
          label: 'Meeting Notes',
          type: FieldType.textarea,
        ),
        FormFieldConfig(
          key: 'next_step',
          label: 'Next Step',
          type: FieldType.textarea,
        ),
      ],
    ),
    StepConfig(
      key: 'success',
      title: '',
      type: StepType.success,
    ),
  ];

  ///next step
  void _next() {
    final step = steps[currentStep];

    /// selection validation
    if (step.type == StepType.selection) {
      final value = answers[step.key];

      if (value == null || value.toString().trim().isEmpty) {
        _showError('Please select one option');
        return;
      }
    }

    /// form validation
    if (step.type == StepType.form) {
      for (final field in step.fields) {
        if (!field.required) continue;

        final value = answers[field.key];

        /// checkbox
        if (field.type == FieldType.checkbox) {
          if (value != true) {
            _showError('${field.label} is required');
            return;
          }
          continue;
        }

        /// text / dropdown / date / textarea
        if (value == null || value.toString().trim().isEmpty) {
          _showError('${field.label} is required');
          return;
        }
      }
    }

    /// payload
    final isLastFormStep =
        steps.length >= 2 &&
            currentStep == steps.length - 2;

    if (isLastFormStep) {
      final payload = Map<String, dynamic>.from(answers)
        ..removeWhere(
              (key, value) =>
          value == null ||
              value.toString().trim().isEmpty,
        );

      debugPrint('Payload => $payload');
    }

    /// next step
    if (currentStep < steps.length - 1) {
      setState(() => currentStep++);
    }
  }

  ///back step
  void _back() {
    if (currentStep > 0) {
      setState(() => currentStep--);
    } else {
      context.go(RoutePath.chooseTask.path);
    }
  }

  ///skip step
  void _skipStep() {
    if (currentStep < steps.length - 1) {
      setState(() => currentStep++);
    }
  }

  ///error validation for continue button
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

  ///content
  @override
  Widget build(BuildContext context) {
    final step = steps[currentStep];
    final showIndicator =
        steps.where((e) => e.type != StepType.success).length > 1;

    return Scaffold(
      backgroundColor: const Color(0xFF061B10),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 28, 22, 22),
          child: Column(
            children: [
              if (step.type != StepType.success && showIndicator) ...[
                StepIndicator(
                  total: steps.length - 2,
                  current: currentStep,
                ),
              ],

              const SizedBox(height: 10),

              Text(
                step.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: kPrimaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),

              const SizedBox(height: 30),

              ///body view
              Expanded(
                child: step.type == StepType.selection
                    ? SelectionStep(
                        options: step.options,
                        selectedValue: answers[step.key],
                        onSelected: (value) {
                          setState(() {
                            answers[step.key] = value;
                          });
                        },
                      )
                    : step.type == StepType.success
                    ? SuccessStepPage(
                        onAddNewLead: () {
                          setState(() {
                            currentStep = 0;
                            answers.clear();
                          });
                        },
                        onGoDashboard: () {
                          context.go('/');
                        },
                      )
                    : FormStep(
                        fields: step.fields,
                        answers: answers,
                        onChanged: (key, value) {
                          setState(() {
                            answers[key] = value;
                          });
                        },
                      ),
              ),

              ///back and continue button
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
                        onTap: _next,
                      ),
                    ),
                  ],
                ),
              ],

              if (step.showSkip) ...[
                const SizedBox(height: 18),
                GestureDetector(
                  onTap: _skipStep,
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
        ),
      ),
    );
  }
}
