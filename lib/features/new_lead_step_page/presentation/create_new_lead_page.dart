import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:sale_pipeline_business/features/new_lead_step_page/controller/new_lead_controller.dart';
import 'package:sale_pipeline_business/utils/async_value_ui.dart';

import '../../../common_widgets/loading_view.dart';
import '../../../utils/secure_storage.dart';
import '../data/new_lead_repository.dart';
import '../model/sale_dropdown_response.dart';

class CreateNewLeadPage extends ConsumerStatefulWidget {
  const CreateNewLeadPage({super.key});

  @override
  ConsumerState<CreateNewLeadPage> createState() => _NewLeadStepPageState();
}

class _NewLeadStepPageState extends ConsumerState<CreateNewLeadPage> {
  final _pageController = PageController();

  int _currentStep = 0;
  final steps = <Widget>[];
  final estContractDateCtrl = TextEditingController();
  final estStartDateCtrl = TextEditingController();
  final estFollowUpDateCtrl = TextEditingController();

  String selectedPotential = '1';

  final potentialList = const [
    PotentialItem(key: '1', value: 'Yes ( Default )'),
    PotentialItem(key: '0', value: 'No'),
  ];

  bool isReferral = false;

  final reasonCtrl = TextEditingController();
  final followUpDateCtrl = TextEditingController();
  final contractDateCtrl = TextEditingController();
  final appointmentDateCtrl = TextEditingController();
  final customerNoteCtrl = TextEditingController();

  bool isNotified = false;

  DdlItem? selectedSource;
  DdlItem? selectedBusinessType;
  DdlItem? selectedDesignation;
  DdlItem? selectedDivision;
  DdlItem? selectedTownship;
  DdlItem? selectedCustomerType;
  SaleStatus? selectedStatus;
  DdlItem? selectedPlan;
  PackageItem? selectedPackage;
  DdlItem? selectedDiscount;

  final businessNameCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final primaryPhoneCtrl = TextEditingController();
  final secondaryPhoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final amountCtrl = TextEditingController();
  final latCtrl = TextEditingController();
  final longCtrl = TextEditingController();
  final meetingNoteCtrl = TextEditingController();
  final nextStepCtrl = TextEditingController();

  @override
  void dispose() {
    _pageController.dispose();
    businessNameCtrl.dispose();
    addressCtrl.dispose();
    nameCtrl.dispose();
    primaryPhoneCtrl.dispose();
    secondaryPhoneCtrl.dispose();
    emailCtrl.dispose();
    amountCtrl.dispose();
    latCtrl.dispose();
    longCtrl.dispose();
    meetingNoteCtrl.dispose();
    nextStepCtrl.dispose();
    reasonCtrl.dispose();
    followUpDateCtrl.dispose();
    contractDateCtrl.dispose();
    appointmentDateCtrl.dispose();
    customerNoteCtrl.dispose();
    estContractDateCtrl.dispose();
    estStartDateCtrl.dispose();
    estFollowUpDateCtrl.dispose();
    super.dispose();
  }

  Map<String, dynamic> _buildPayload() {
    final map = <String, dynamic>{
      'uid': GetStorage().read(SecureDataList.uid.name),
      'app_version': '1.0',

      'source': selectedSource?.value,
      'business_type': selectedBusinessType?.value,
      'sme': null,
      'business_name': businessNameCtrl.text.trim(),
      'division': selectedDivision?.value,
      'township': selectedTownship?.value,
      'address': addressCtrl.text.trim(),

      'contact_number': primaryPhoneCtrl.text.trim(),
      'secondary_contact_number': secondaryPhoneCtrl.text.trim(),
      'contact_person': nameCtrl.text.trim(),
      'email': emailCtrl.text.trim(),

      'designation': selectedDesignation?.value,
      'designation_other': null,
      'business_type_other': null,

      'potential': selectedPotential,
      'status': selectedStatus?.key,

      'followup_date': followUpDateCtrl.text.trim(),
      'est_contract_date': estContractDateCtrl.text.trim(),
      'est_start_date': estStartDateCtrl.text.trim(),
      'follow_up_date': estFollowUpDateCtrl.text.trim(),

      'isNotified': isNotified ? '1' : '0',
      'isReferral': isReferral ? '1' : '0',
      'reason': reasonCtrl.text.trim(),

      'contracted_date':
      contractDateCtrl.text.trim().isEmpty ? null : contractDateCtrl.text.trim(),
      'installation_appointment_date':
      appointmentDateCtrl.text.trim().isEmpty ? null : appointmentDateCtrl.text.trim(),
      'customer_note': customerNoteCtrl.text.trim(),

      'lat': latCtrl.text.trim(),
      'long': longCtrl.text.trim(),

      'amount': selectedPotential == '0' ? '' : amountCtrl.text.trim(),
      'plan': selectedPotential == '0' ? '' : selectedPlan?.value,
      'package': selectedPotential == '0' ? '' : selectedPackage?.key,
      'discount': selectedPotential == '0' ? '' : selectedDiscount?.value,

      'customer_type': selectedCustomerType?.key,

      'meeting_notes': meetingNoteCtrl.text.trim(),
      'next_step': nextStepCtrl.text.trim(),
    };

    return removeEmptyOrNullFields(map);
  }

  Map<String, dynamic> removeEmptyOrNullFields(Map<String, dynamic> inputMap) {
    final result = <String, dynamic>{};

    inputMap.forEach((key, value) {
      if (value != null &&
          value != 'null' &&
          value.toString().trim().isNotEmpty) {
        result[key] = value;
      }
    });

    return result;
  }


  void _back() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.previousPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    }
  }

  bool _validateCurrentStep(List<LeadStep> steps) {
    final stepKey = steps[_currentStep].key;

    switch (stepKey) {
      case 'lead_source':
        return _requiredSelected(selectedSource, 'Please choose lead source');

      case 'business_type':
        return _requiredSelected(
          selectedBusinessType,
          'Please choose business type',
        );

      case 'business_info':
        if (addressCtrl.text.trim().isEmpty) {
          _showError('Please enter address');
          return false;
        }
        if (selectedDivision == null) {
          _showError('Please select division');
          return false;
        }
        if (selectedTownship == null) {
          _showError('Please select township');
          return false;
        }
        return true;

      case 'designation':
        return _requiredSelected(
          selectedDesignation,
          'Please choose designation',
        );

      // case 'contact_info':
      //   if (nameCtrl.text.trim().isEmpty) {
      //     _showError('Please enter name');
      //     return false;
      //   }
      //   if (primaryPhoneCtrl.text.trim().isEmpty) {
      //     _showError('Please enter contact number');
      //     return false;
      //   }
      //   return true;

      case 'potential':
        return _validatePotentialStep();

      case 'notes':
        if (meetingNoteCtrl.text.trim().isEmpty) {
          _showError('Please enter meeting notes');
          return false;
        }

        if (nextStepCtrl.text.trim().isEmpty) {
          _showError('Please enter next step');
          return false;
        }

        return true;

      default:
        return true;
    }
  }

  bool _validatePotentialStep() {
    final isPotential = selectedPotential == '1';

    if (selectedStatus == null) {
      _showError('Please select status');
      return false;
    }

    if (!isPotential) {
      return true;
    }

    if (selectedCustomerType == null) {
      _showError('Please select customer type');
      return false;
    }

    if (selectedPlan == null) {
      _showError('Please select plan');
      return false;
    }

    if (selectedPackage == null) {
      _showError('Please select package');
      return false;
    }

    if (amountCtrl.text.trim().isEmpty) {
      _showError('Please enter amount');
      return false;
    }

    if (estContractDateCtrl.text.trim().isEmpty) {
      _showError('Please select estimated contract date');
      return false;
    }

    if (estStartDateCtrl.text.trim().isEmpty) {
      _showError('Please select estimated start date');
      return false;
    }

    if (estFollowUpDateCtrl.text.trim().isEmpty) {
      _showError('Please select estimated follow up date');
      return false;
    }

    if (selectedStatus?.value == 'Contracted') {
      if (!checkLatLongLength(latCtrl.text.trim())) {
        _showError('Latitude field must be filled with format(00.000000)');
        return false;
      }

      if (!checkLatLongLength(longCtrl.text.trim())) {
        _showError('Longitude field must be filled with format(00.000000)');
        return false;
      }
    }

    return true;
  }

  bool checkLatLongLength(String str) {
    final lat = str.split('.');

    if (lat.length < 2) return false;
    if (lat[0].length != 2) return false;
    if (lat[1].length != 6) return false;

    return true;
  }

  bool _requiredSelected(dynamic value, String message) {
    if (value == null) {
      _showError(message);
      return false;
    }
    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message),backgroundColor: Colors.red,),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ddlState = ref.watch(fetchSaleDropdownDataProvider);
    final submitLeadController = ref.watch(newLeadControllerProvider);

    ref.listen<AsyncValue>(
      newLeadControllerProvider,
          (_, next) => next.showAlertDialogOnError(context),
    );

    return Scaffold(
      backgroundColor: const Color(0xFF061B10),
      body: ddlState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
          data: (ddl) {
            final steps = <LeadStep>[];

            if ((ddl.saleSource ?? []).isNotEmpty) {
              steps.add(LeadStep(
                key: 'lead_source',
                widget: _optionStep(
                  title: 'Choose the lead source.',
                  items: ddl.saleSource ?? [],
                  selected: selectedSource,
                  onSelected: (v) => setState(() => selectedSource = v),
                ),
              ));
            }

            if ((ddl.saleBusinessType ?? []).isNotEmpty) {
              steps.add(LeadStep(
                key: 'business_type',
                widget: _optionStep(
                  title: 'Choose the type of business.',
                  items: ddl.saleBusinessType ?? [],
                  selected: selectedBusinessType,
                  onSelected: (v) => setState(() => selectedBusinessType = v),
                ),
              ));
            }

            steps.add(LeadStep(
              key: 'business_info',
              widget: _businessInfoStep(ddl),
            ));

            if ((ddl.saleDesignation ?? []).isNotEmpty) {
              steps.add(LeadStep(
                key: 'designation',
                widget: _optionStep(
                  title: 'Who did you meet with?',
                  items: ddl.saleDesignation ?? [],
                  selected: selectedDesignation,
                  onSelected: (v) => setState(() => selectedDesignation = v),
                ),
              ));
            }

            steps.add(LeadStep(
              key: 'contact_info',
              widget: _contactInfoStep(),
            ));

            final hasPotentialData =
                (ddl.customerType ?? []).isNotEmpty ||
                    (ddl.saleStatus ?? []).isNotEmpty ||
                    (ddl.plan ?? []).isNotEmpty ||
                    (ddl.package ?? []).isNotEmpty ||
                    (ddl.discount ?? []).isNotEmpty;

            if (hasPotentialData) {
              steps.add(LeadStep(
                key: 'potential',
                widget: _potentialStep(ddl),
              ));
            }

            steps.add(LeadStep(
              key: 'notes',
              widget: _notesStep(),
            ));

            return SafeArea(
              child: Stack(
                children: [
                  ///content view
                  Column(
                    children: [
                      _StepIndicator(
                        currentStep: _currentStep,
                        totalSteps: steps.length,
                      ),
                      Expanded(
                        child: PageView(
                          controller: _pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: steps.map((e) => e.widget).toList(),
                        ),
                      ),
                      _BottomButtons(
                        showBack: _currentStep > 0,
                        onBack: _back,
                        onNext: () async {
                          if (!_validateCurrentStep(steps)) return;

                          if (_currentStep == steps.length - 1) {
                            final payload = _buildPayload();

                            if (ref.read(newLeadControllerProvider).isLoading) {
                              return;
                            }

                            final value = await ref
                                .read(newLeadControllerProvider.notifier)
                                .submitLead(payload: payload);

                            if (!context.mounted) return;

                            if (value?.status == 'Success') {
                              context.go('/');
                            } else {
                            }

                            return;
                          }

                          setState(() => _currentStep++);
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                          );
                        },
                        nextText: _currentStep == steps.length - 1 ? 'Done' : 'Continue',

                        showSkip: _currentStep > 2 &&
                            _currentStep < steps.length - 1,
                        onSkip: () {
                          setState(() => _currentStep++);
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ],
                  ),


                  ///loading view
                  if (submitLeadController.isLoading)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black38,
                        child: const Center(
                          child: LoadingView(
                            indicatorColor: Colors.white,
                            indicator: Indicator.ballRotate,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          }
      ),
    );
  }

  Widget _optionStep({
    required String title,
    required List<DdlItem> items,
    required DdlItem? selected,
    required ValueChanged<DdlItem> onSelected,
  }) {
    if (items.isEmpty) {
      return const Center(
        child: Text(
          'No data available',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _StepTitle(title),
        const SizedBox(height: 20),
        ...items.map(
              (item) => _OptionButton(
            text: item.value ?? '',
            selected: selected?.key == item.key,
            onTap: () => onSelected(item),
          ),
        ),
      ],
    );
  }

  Widget _businessInfoStep(SaleDropdownDataResponse ddl) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const _StepTitle('Enter the business information.'),
        const SizedBox(height: 20),
        _TextInput(label: 'Business Name', controller: businessNameCtrl),
        _TextInput(label: 'Address', controller: addressCtrl,requiredMark: true,),
        _DropdownInput(
          label: 'Division',
          value: selectedDivision,
          items: ddl.division ?? [],
          requiredMark: true,
          hint: 'Select division',
          onChanged: (v) => setState(() => selectedDivision = v),
        ),
        _DropdownInput(
          label: 'Township',
          value: selectedTownship,
          items: ddl.township ?? [],
          requiredMark: true,
          hint: 'Select township',
          onChanged: (v) => setState(() => selectedTownship = v),
        ),
      ],
    );
  }

  Widget _contactInfoStep() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const _StepTitle('Enter the contact information.'),
        const SizedBox(height: 20),
        _TextInput(label: 'Name', controller: nameCtrl),
        _TextInput(
          label: 'Contact No',
          controller: primaryPhoneCtrl,
          keyboardType: TextInputType.phone,
        ),
        _TextInput(
          label: 'Secondary',
          controller: secondaryPhoneCtrl,
          keyboardType: TextInputType.phone,
        ),
        _TextInput(
          label: 'Email',
          controller: emailCtrl,
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }

  Widget _potentialStep(SaleDropdownDataResponse ddl) {
    final packages = selectedPlan == null
        ? <PackageItem>[]
        : (ddl.package ?? [])
        .where((e) => e.plan?.trim() == selectedPlan?.value?.trim())
        .toList();

    final deadLeadStatus = (ddl.saleStatus ?? [])
        .where((e) => e.value == 'Dead Lead')
        .toList();

    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        const _StepTitle('Select Potential %.'),
        const SizedBox(height: 20),

        _PotentialDropInput(
          value: selectedPotential,
          potentialList: potentialList,
          onChanged: (v) {
            setState(() {
              selectedPotential = v ?? '1';

              if (selectedPotential == '0') {
                selectedStatus = deadLeadStatus.isNotEmpty ? deadLeadStatus.first : null;
              } else {
                selectedStatus = null;
              }

              selectedPlan = null;
              selectedPackage = null;
              selectedDiscount = null;
              selectedCustomerType = null;

              amountCtrl.clear();
              reasonCtrl.clear();
              followUpDateCtrl.clear();
              contractDateCtrl.clear();
              appointmentDateCtrl.clear();
              customerNoteCtrl.clear();
              latCtrl.clear();
              longCtrl.clear();

              isNotified = false;
              isReferral = false;
            });
          },
        ),

        if (selectedPotential == '0') ...[
          _SaleStatusDropInput(
            label: 'Status',
            value: selectedStatus,
            items: selectedPotential == '0'
                ? deadLeadStatus
                : (ddl.saleStatus ?? [])
                .where((e) => e.value != 'Dead Lead')
                .toList(),
            hint: 'Select Status',
            onChanged: (v) => setState(() => selectedStatus = v),
          ),

          _TextInput(
            label: 'Reason',
            controller: reasonCtrl,
            hint: 'Enter Reason',
          ),

          _DateInput(
            label: 'Follow Up',
            controller: followUpDateCtrl,
          ),

          CheckboxListTile(
            value: isNotified,
            onChanged: (v) => setState(() => isNotified = v ?? false),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Notify me after 6 months',
              style: TextStyle(color: Colors.white),
            ),
            checkColor: Colors.white,
            activeColor: const Color(0xFF00C853),
          ),
        ],

        if (selectedPotential == '1') ...[
          _DropdownInput(
            label: 'Customer\nType',
            value: selectedCustomerType,
            items: ddl.customerType ?? [],
            requiredMark: true,
            hint: 'Select Customer Type',
            onChanged: (v) => setState(() => selectedCustomerType = v),
          ),

          _SaleStatusDropInput(
            label: 'Status',
            value: selectedStatus,
            items: (ddl.saleStatus ?? [])
                .where((e) => e.value != 'Dead Lead')
                .toList(),
            requiredMark: true,
            hint: 'Select Status',
            onChanged: (v) => setState(() => selectedStatus = v),
          ),

          if (selectedStatus?.value == 'Contracted') ...[
            _TextInput(
              label: 'Lat',
              controller: latCtrl,
              hint: 'Enter latitude',
              requiredMark: true,
            ),

            _TextInput(
              label: 'Long',
              controller: longCtrl,
              hint: 'Enter longitude',
              requiredMark: true,
            ),

            _DateInput(
              label: 'Contract Date',
              controller: contractDateCtrl,
            ),

            _DateInput(
              label: 'Installation Appointment Date',
              controller: appointmentDateCtrl,
            ),

            _TextInput(
              label: 'Customer Note',
              controller: customerNoteCtrl,
              hint: 'Enter Note',
            ),
          ],

          _DropdownInput(
            label: 'Plan',
            value: selectedPlan,
            items: ddl.plan ?? [],
            requiredMark: true,
            hint: 'Select Plan',
            onChanged: (v) {
              setState(() {
                selectedPlan = v;
                selectedPackage = null;
                amountCtrl.clear();
              });
            },
          ),

          _PackageDropInput(
            label: 'Package',
            value: selectedPackage,
            items: packages,
            requiredMark: true,
            hint: 'Select Package',
            onChanged: (v) {
              setState(() {
                selectedPackage = v;
                amountCtrl.text = v?.value ?? '';
              });
            },
          ),

          _TextInput(
            label: 'Amount',
            controller: amountCtrl,
            keyboardType: TextInputType.number,
            hint: 'xxxxxxxx',
            requiredMark: true,
          ),

          _DropdownInput(
            label: 'Discount',
            value: selectedDiscount,
            items: ddl.discount ?? [],
            requiredMark: true,
            hint: '0%',
            onChanged: (v) => setState(() => selectedDiscount = v),
          ),

          _DateInput(
            label: 'Est. Contract\nDate',
            controller: estContractDateCtrl,
            requiredMark: true,
          ),

          _DateInput(
            label: 'Est. Start\nDate',
            controller: estStartDateCtrl,
            requiredMark: true,
          ),

          _DateInput(
            label: 'Est. Follow\nUp Date',
            controller: estFollowUpDateCtrl,
            requiredMark: true,
          ),

          CheckboxListTile(
            value: isReferral,
            onChanged: (v) => setState(() => isReferral = v ?? false),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Is Referral',
              style: TextStyle(color: Colors.white),
            ),
            checkColor: Colors.white,
            activeColor: const Color(0xFF00C853),
          ),
        ],
      ],
    );
  }

  Widget _notesStep() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const _StepTitle('Meeting Notes'),
        const SizedBox(height: 20),
        _TextInput(
          label: 'Meeting Notes',
          controller: meetingNoteCtrl,
          maxLines: 5,
          requiredMark: true,
        ),
        _TextInput(
          label: 'Next Step',
          controller: nextStepCtrl,
          maxLines: 5,
          requiredMark: true,
        ),
      ],
    );
  }


}

class _DateInput extends StatelessWidget {
  const _DateInput({
    required this.label,
    required this.controller,
    this.requiredMark = false,
  });

  final String label;
  final TextEditingController controller;
  final bool requiredMark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 26),
      child: Row(
        children: [
          _FieldLabel(label: label, requiredMark: requiredMark),
          Expanded(
            child: TextField(
              controller: controller,
              readOnly: true,
              textAlign: TextAlign.center,
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                  initialDate: DateTime.now(),
                );

                if (date != null) {
                  controller.text =
                  '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
                }
              },
              decoration: InputDecoration(
                hintText: '.....Select Date.....',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({
    required this.label,
    this.requiredMark = false,
  });

  final String label;
  final bool requiredMark;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: RichText(
        text: TextSpan(
          text: label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          children: [
            if (requiredMark)
              const TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}

class _StepTitle extends StatelessWidget {
  const _StepTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Color(0xFF00C853),
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({
    required this.currentStep,
    required this.totalSteps,
  });

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalSteps, (index) {
          final active = index <= currentStep;

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: active ? const Color(0xFF00C853) : Colors.white,
              shape: BoxShape.circle,
            ),
          );
        }),
      ),
    );
  }
}

class _OptionButton extends StatelessWidget {
  const _OptionButton({
    required this.text,
    required this.selected,
    required this.onTap,
  });

  final String text;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: selected ? const Color(0xFF00C853) : Colors.white,
          foregroundColor: selected ? Colors.white : const Color(0xFF064B2A),
          minimumSize: const Size(double.infinity, 46),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        onPressed: onTap,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class _TextInput extends StatelessWidget {
  const _TextInput({
    required this.label,
    required this.controller,
    this.keyboardType,
    this.maxLines = 1,
    this.hint = 'Text',
    this.requiredMark = false,
  });

  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final int maxLines;
  final String hint;
  final bool requiredMark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 26),
      child: Row(
        children: [
          SizedBox(
            width: 115,
            child: RichText(
              text: TextSpan(
                text: label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  if (requiredMark)
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              maxLines: maxLines,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: hint,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 18,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PackageDropInput extends StatelessWidget {
  const _PackageDropInput({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.requiredMark = false,
    this.hint,
  });

  final String label;
  final PackageItem? value;
  final List<PackageItem> items;
  final ValueChanged<PackageItem?> onChanged;
  final bool requiredMark;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 34),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _FieldLabel(label: label, requiredMark: requiredMark),
          Expanded(
            child: SizedBox(
              height: 60,
              child: DropdownButtonFormField<PackageItem>(
                value: value,
                isExpanded: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color(0xFF064B2A),
                  size: 40,
                ),
                dropdownColor: Colors.white,
                decoration: InputDecoration(
                  hintText: hint ?? 'Select Package',
                  hintStyle: const TextStyle(
                    color: Color(0xFFA9A9A9),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.only(
                    left: 28,
                    right: 18,
                    top: 16,
                    bottom: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: items.map((item) {
                  return DropdownMenuItem<PackageItem>(
                    value: item,
                    child: Center(
                      child: Text(
                        item.key ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFFA0A0A0),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SaleStatusDropInput extends StatelessWidget {
  const _SaleStatusDropInput({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.requiredMark = false,
    this.hint,
  });

  final String label;
  final SaleStatus? value;
  final List<SaleStatus> items;
  final ValueChanged<SaleStatus?> onChanged;
  final bool requiredMark;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    final validValue = value == null
        ? null
        : items.where((e) => e.key.toString() == value!.key.toString()).isNotEmpty
        ? items.firstWhere((e) => e.key.toString() == value!.key.toString())
        : null;

    return Padding(
      padding: const EdgeInsets.only(bottom: 34),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _FieldLabel(label: label, requiredMark: requiredMark),
          Expanded(
            child: SizedBox(
              height: 60,
              child: DropdownButtonFormField<SaleStatus>(
                value: validValue,
                isExpanded: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color(0xFF064B2A),
                  size: 40,
                ),
                dropdownColor: Colors.white,
                decoration: InputDecoration(
                  hintText: hint ?? 'Select Status',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: items.map((item) {
                  return DropdownMenuItem<SaleStatus>(
                    value: item,
                    child: Center(
                      child: Text(
                        item.value ?? '',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomButtons extends StatelessWidget {
  const _BottomButtons({
    required this.showBack,
    required this.onBack,
    required this.onNext,
    required this.nextText,
    this.onSkip,
    this.showSkip = true,
  });

  final bool showBack;
  final VoidCallback onBack;
  final VoidCallback onNext;
  final String nextText;
  final VoidCallback? onSkip;
  final bool showSkip;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (showBack)
                Expanded(
                  child: ElevatedButton(
                    onPressed: onBack,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF064B2A),
                      minimumSize: const Size.fromHeight(48),
                    ),
                    child: const Text(
                      'Back',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

              if (showBack) const SizedBox(width: 14),

              Expanded(
                child: ElevatedButton(
                  onPressed: onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00C853),
                    minimumSize: const Size.fromHeight(48),
                  ),
                  child: Text(nextText),
                ),
              ),
            ],
          ),

          if (showSkip) ...[
            const SizedBox(height: 12),
            TextButton(
              onPressed: onSkip,
              child: const Text(
                'Skip For Now',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _DropdownInput extends StatelessWidget {
  const _DropdownInput({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.requiredMark = false,
    this.hint,
  });

  final String label;
  final DdlItem? value;
  final List<DdlItem> items;
  final ValueChanged<DdlItem?> onChanged;
  final bool requiredMark;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return _DdlDropInput(
      label: label,
      value: value,
      items: items,
      onChanged: onChanged,
      requiredMark: requiredMark,
      hint: hint,
    );
  }
}

class _DdlDropInput extends StatelessWidget {
  const _DdlDropInput({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.requiredMark = false,
    this.hint,
  });

  final String label;
  final DdlItem? value;
  final List<DdlItem> items;
  final ValueChanged<DdlItem?> onChanged;
  final bool requiredMark;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return _LeadDropdown<DdlItem>(
      label: label,
      value: value,
      items: items,
      itemText: (item) => item.value ?? '',
      onChanged: onChanged,
      requiredMark: requiredMark,
      hint: hint,
    );
  }
}

class _LeadDropdown<T> extends StatelessWidget {
  const _LeadDropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.itemText,
    required this.onChanged,
    this.requiredMark = false,
    this.hint,
  });

  final String label;
  final T? value;
  final List<T> items;
  final String Function(T item) itemText;
  final ValueChanged<T?> onChanged;
  final bool requiredMark;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 34),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _FieldLabel(label: label, requiredMark: requiredMark),
          Expanded(
            child: SizedBox(
              height: 60,
              child: DropdownButtonFormField<T>(
                value: value,
                isExpanded: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color(0xFF064B2A),
                  size: 40,
                ),
                dropdownColor: Colors.white,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: const TextStyle(
                    color: Color(0xFFA9A9A9),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.only(
                    left: 28,
                    right: 18,
                    top: 16,
                    bottom: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
                items: items.map((item) {
                  return DropdownMenuItem<T>(
                    value: item,
                    child: Center(
                      child: Text(
                        itemText(item),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFFA0A0A0),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PotentialDropInput extends StatelessWidget {
  const _PotentialDropInput({
    required this.value,
    required this.onChanged,
    required this.potentialList,
  });

  final String? value;
  final ValueChanged<String?> onChanged;
  final List<PotentialItem> potentialList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 34),
      child: Row(
        children: [
          const _FieldLabel(label: 'Potential'),
          Expanded(
            child: SizedBox(
              height: 60,
              child: DropdownButtonFormField<String>(
                value: value,
                isExpanded: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color(0xFF064B2A),
                  size: 40,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: potentialList.map((item) {
                  return DropdownMenuItem<String>(
                    value: item.key,
                    child: Text(item.value,style: TextStyle(fontSize: 16),),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class LeadStep {
  final String key;
  final Widget widget;

  const LeadStep({
    required this.key,
    required this.widget,
  });
}

class PotentialItem {
  final String key;
  final String value;

  const PotentialItem({
    required this.key,
    required this.value,
  });
}