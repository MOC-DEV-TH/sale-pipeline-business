import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sale_pipeline_business/features/leads/model/lead_detail_response.dart';
import 'package:sale_pipeline_business/utils/app_colors.dart';

import '../../../network/session_interceptor.dart';
import '../../../utils/images.dart';
import '../../new_lead_step_page/data/new_lead_repository.dart';
import '../../new_lead_step_page/model/sale_dropdown_response.dart';
import '../data/leads_repository.dart';

class LeadDetailPage extends ConsumerStatefulWidget {
  const LeadDetailPage({
    super.key,
    required this.uid,
    required this.leadId,
  });

  final String uid;
  final String leadId;

  @override
  ConsumerState<LeadDetailPage> createState() => _LeadDetailPageState();
}

class _LeadDetailPageState extends ConsumerState<LeadDetailPage> {
  final businessNameController = TextEditingController();
  final addressController = TextEditingController();
  final contactPersonController = TextEditingController();
  final primaryContactController = TextEditingController();
  final secondaryContactController = TextEditingController();
  final emailController = TextEditingController();
  final currentIspController = TextEditingController();
  final currentPlanController = TextEditingController();
  final currentPackageController = TextEditingController();
  final amountController = TextEditingController();
  final weightedController = TextEditingController();
  final meetingNotesController = TextEditingController();
  final nextStepController = TextEditingController();
  final estContractDateController = TextEditingController();
  final estStartDateController = TextEditingController();
  final estFollowUpDateController = TextEditingController();
  final latController = TextEditingController();
  final longController = TextEditingController();
  final appointmentDateController = TextEditingController();
  final contractDateController = TextEditingController();
  final customerNoteController = TextEditingController();
  final estimateFlightDateController = TextEditingController();

  bool _initialized = false;
  bool _saving = false;

  String? source;
  String? businessType;
  String? customerType;
  String? division;
  String? township;
  String? designation;
  String? followUpVia;
  String? discount;
  String? planValue;
  String? packageValue;

  dynamic leadStatus;
  String? leadStatusName;

  bool hasValue(dynamic value) {
    final text = value?.toString().trim();
    return text != null && text.isNotEmpty && text.toLowerCase() != 'null';
  }

  void initForm(LeadDetailVO data, SaleDropdownDataResponse ddl) {
    if (_initialized) return;

    source = data.leadSource;
    businessType = data.businessType;
    customerType = data.customerType;
    division = data.division;
    township = data.township;
    designation = data.designation;
    followUpVia = data.followupVia;
    discount = data.discount;

    leadStatus = findKeyByValue(ddl.saleStatus, data.status);
    leadStatusName = data.status;

    planValue = data.plan;
    packageValue = data.package;

    businessNameController.text = data.businessName ?? '';
    addressController.text = data.address ?? '';
    contactPersonController.text = data.firstname ?? '';
    primaryContactController.text = data.contactno ?? '';
    secondaryContactController.text = data.secondaryContactNumber ?? '';
    emailController.text = data.email ?? '';
    currentIspController.text = data.currentIsp ?? '';
    currentPlanController.text = data.plan ?? '';
    currentPackageController.text = data.package ?? '';
    amountController.text = data.packageTotal ?? '';
    weightedController.text = data.weighted ?? '';
    meetingNotesController.text = data.meetingNotes ?? '';
    nextStepController.text = data.nextStep ?? '';
    estContractDateController.text = data.estContractDate ?? '';
    estStartDateController.text = data.estStartDate ?? '';
    estFollowUpDateController.text = data.estFollowUpDate ?? '';
    latController.text = data.latitude ?? '';
    longController.text = data.longitude ?? '';
    appointmentDateController.text = data.installationAppointmentDate ?? '';
    contractDateController.text = data.contractDate ?? '';
    customerNoteController.text = data.customerNote ?? '';
    estimateFlightDateController.text = data.estimateFlightdate ?? '';

    _initialized = true;
  }

  dynamic findKeyByValue(List<dynamic>? items, String? apiValue) {
    if (!hasValue(apiValue) || items == null || items.isEmpty) return null;

    for (final item in items) {
      if (item.value?.toString().trim().toLowerCase() ==
          apiValue.toString().trim().toLowerCase()) {
        return item.key;
      }
    }

    return null;
  }

  String? findValueByKey(List<dynamic>? items, dynamic key) {
    if (key == null || items == null || items.isEmpty) return null;

    for (final item in items) {
      if (item.key?.toString() == key.toString()) {
        return item.value?.toString();
      }
    }

    return null;
  }

  dynamic findItemByKey(List<dynamic>? items, dynamic key) {
    if (key == null || items == null || items.isEmpty) return null;

    for (final item in items) {
      if (item.key?.toString() == key.toString()) {
        return item;
      }
    }

    return null;
  }

  @override
  void dispose() {
    businessNameController.dispose();
    addressController.dispose();
    contactPersonController.dispose();
    primaryContactController.dispose();
    secondaryContactController.dispose();
    emailController.dispose();
    currentIspController.dispose();
    currentPlanController.dispose();
    currentPackageController.dispose();
    amountController.dispose();
    weightedController.dispose();
    meetingNotesController.dispose();
    nextStepController.dispose();
    estContractDateController.dispose();
    estStartDateController.dispose();
    estFollowUpDateController.dispose();
    latController.dispose();
    longController.dispose();
    appointmentDateController.dispose();
    contractDateController.dispose();
    customerNoteController.dispose();
    estimateFlightDateController.dispose();
    super.dispose();
  }

  Future<void> onSave(LeadDetailVO data) async {
    if (_saving) return;

    setState(() => _saving = true);

    final map = <String, dynamic>{
      'lid': data.lid ?? widget.leadId,
      'uid': widget.uid,
      'app_version': '1.0',

      'source': source,
      'business_type': businessType,
      'business_name': businessNameController.text.trim(),
      'designation': designation,
      'contact_person': contactPersonController.text.trim(),
      'potential': data.potential,
      'address': addressController.text.trim(),
      'status': leadStatus,
      'customer_type': customerType,

      'followup_via': followUpVia,
      'estimate_flightdate': estimateFlightDateController.text.trim(),
      'current_isp': currentIspController.text.trim(),

      'followup_date': '',
      'weight': weightedController.text.trim(),
      'amount': amountController.text.trim(),

      'division': division,
      'township': township,

      'package': currentPackageController.text.trim(),
      'plan': currentPlanController.text.trim(),
      'discount': discount,

      'contracted_date': contractDateController.text.trim(),
      'installation_appointment_date':
      appointmentDateController.text.trim(),

      'customer_note': customerNoteController.text.trim(),
      'lat': latController.text.trim(),
      'long': longController.text.trim(),

      'contact_number': primaryContactController.text.trim(),
      'secondary_contact_number':
      secondaryContactController.text.trim(),
      'email': emailController.text.trim(),

      'meeting_notes': meetingNotesController.text.trim(),
      'next_step': nextStepController.text.trim(),

      'est_contract_date': estContractDateController.text.trim(),
      'est_start_date': estStartDateController.text.trim(),
      'follow_up_date': estFollowUpDateController.text.trim(),
    };

    map.removeWhere(
          (key, value) =>
      value == null || (value is String && value.trim().isEmpty),
    );

    String? errorMsg;

    final email = emailController.text.trim();

    if (leadStatusName == 'Contracted') {
      if (!checkEmptyData()) {
        errorMsg = 'Please fill all required fields!!!';
      } else if (!checkLatLongLength(latController.text.trim())) {
        errorMsg = 'Latitude field must be filled with format(00.000000)';
      } else if (!checkLatLongLength(longController.text.trim())) {
        errorMsg = 'Longitude field must be filled with format(00.000000)';
      }
    } else {
      if (email.isNotEmpty && !isValidEmail(email)) {
        errorMsg = 'Invalid Email Format';
      } else if (!checkEstDateEmptyData()) {
        errorMsg = 'Please fill all required fields!!!';
      }
    }

    if (errorMsg != null) {
      if (mounted) {
        setState(() => _saving = false);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.red,
              content: Text(errorMsg)),
        );
      }
      return;
    }

    try {
      final repo = ref.read(leadsRepositoryProvider);
      await repo.updateLead(payload: map);

      if (!mounted) return;

      if (!SessionInterceptor.isSessionExpired) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: kPrimaryColor,
            duration: Duration(milliseconds: 1000),
            content: Text('Lead updated successfully.'),
          ),
        );

        ref.invalidate(fetchLeadListProvider);
      }
    } catch (e) {
      if (!mounted) return;

      if (!SessionInterceptor.isSessionExpired) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  bool checkEmptyData() {
    if (appointmentDateController.text.trim() == '' ||
        customerNoteController.text.trim() == '' ||
        contractDateController.text.trim() == '' ||
        latController.text.trim() == '' ||
        longController.text.trim() == '') {
      return false;
    } else {
      return true;
    }
  }

  bool checkEstDateEmptyData() {
    if (estContractDateController.text.trim() == '' ||
        estStartDateController.text.trim() == '' ||
        estFollowUpDateController.text.trim() == '') {
      return false;
    } else {
      return true;
    }
  }

  bool checkLatLongLength(String str) {
    final lat = str.split('.');
    List latList = [];

    for (int i = 0; i < lat.length; i++) {
      latList.add(lat[i]);
    }

    debugPrint(latList.length.toString());

    if (latList.length >= 2) {
      debugPrint(latList[0].toString().length.toString());
      debugPrint(latList[1].toString().length.toString());

      if (latList[0].toString().length != 2) {
        return false;
      } else if (latList[1].toString().length != 6) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }


  bool isValidEmail(String email) {
    final regex = RegExp(
      r'^[\w.-]+@([\w-]+\.)+[\w-]{2,4}$',
    );
    return regex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    final detailAsync = ref.watch(
      fetchLeadDetailProvider(
        uid: widget.uid,
        leadId: widget.leadId,
      ),
    );

    final ddlState = ref.watch(fetchSaleDropdownDataProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFF061B10),
      body: SafeArea(
        child: detailAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(
            child: Text(
              error.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          data: (response) {
            return ddlState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(
                child: Text(
                  error.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              data: (ddl) {
                final data = response.details;

                if (data == null) {
                  return const Center(
                    child: Text(
                      'No lead detail found',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                initForm(data, ddl);

                return GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Stack(
                    children: [
                      Container(color: const Color(0xFF061B10)),
                      Positioned.fill(
                        child: Image.asset(
                          kDashboardBgPatternImage,
                          fit: BoxFit.cover,
                          gaplessPlayback: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            const SizedBox(height: 30),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    data.businessName ?? '',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => Navigator.pop(context),
                                  child: const Text(
                                    '<< Back',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                 children: [
                                   dropdownValueField(
                                     label: 'Source',
                                     items: ddl.saleSource ?? [],
                                     value: source,
                                     onChanged: (v) => setState(() => source = v),
                                   ),

                                   dropdownValueField(
                                     label: 'Business Type',
                                     items: ddl.saleBusinessType ?? [],
                                     value: businessType,
                                     onChanged: (v) => setState(() => businessType = v),
                                   ),

                                   dropdownValueField(
                                     label: 'Customer Type',
                                     items: ddl.customerType ?? [],
                                     value: customerType,
                                     onChanged: (v) => setState(() => customerType = v),
                                   ),

                                   dropdownValueField(
                                     label: 'Division',
                                     items: ddl.division ?? [],
                                     value: division,
                                     onChanged: (v) => setState(() => division = v),
                                   ),

                                   dropdownValueField(
                                     label: 'Township',
                                     items: ddl.township ?? [],
                                     value: township,
                                     onChanged: (v) => setState(() => township = v),
                                   ),

                                   textField(
                                     'Business Name',
                                     businessNameController,
                                     data.businessName,
                                   ),

                                   textField(
                                     'Address',
                                     addressController,
                                     data.address,
                                   ),

                                   textField(
                                     'Contact Person Name',
                                     contactPersonController,
                                     data.firstname,
                                   ),

                                   dropdownValueField(
                                     label: 'Designation',
                                     items: ddl.saleDesignation ?? [],
                                     value: designation,
                                     onChanged: (v) => setState(() => designation = v),
                                   ),

                                   textField(
                                     'Primary Contact Number',
                                     primaryContactController,
                                     data.contactno,
                                   ),

                                   textField(
                                     'Secondary Contact Number',
                                     secondaryContactController,
                                     data.secondaryContactNumber,
                                   ),

                                   textField(
                                     'Email',
                                     emailController,
                                     data.email,
                                   ),

                                   textField(
                                     'Current ISP',
                                     currentIspController,
                                     data.currentIsp,
                                   ),

                                   dropdownValueField(
                                     label: 'New Plan',
                                     items: ddl.plan ?? [],
                                     value: planValue,
                                     onChanged: (v) {
                                       setState(() {
                                         planValue = v;
                                         packageValue = null;
                                         currentPlanController.text = v ?? '';
                                         currentPackageController.clear();
                                         amountController.clear();
                                       });
                                     },
                                   ),

                                   dropdownPackageField(
                                     label: 'New Package',
                                     items: ddl.package ?? [],
                                     selectedPlan: planValue ?? currentPlanController.text,
                                     value: packageValue,
                                     onChanged: (item) {
                                       setState(() {
                                         packageValue = item?.key;
                                         currentPackageController.text = item?.key ?? '';
                                         amountController.text = item?.value ?? '';
                                       });
                                     },
                                   ),

                                   textField(
                                     'Amount',
                                     amountController,
                                     data.packageTotal,
                                     enabled: false,
                                   ),

                                   dropdownValueField(
                                     label: 'Discount',
                                     items: ddl.discount ?? [],
                                     value: discount,
                                     onChanged: (v) => setState(() => discount = v),
                                   ),

                                   leadStatusDropdown(items: ddl.saleStatus ?? []),

                                   if (leadStatusName == 'Contracted') ...[
                                     textField('Lat', latController, data.latitude),
                                     textField('Long', longController, data.longitude),
                                     dateField(
                                       'Installation Appointment Date',
                                       appointmentDateController,
                                       data.installationAppointmentDate,
                                     ),
                                     dateField(
                                       'Contracted Date',
                                       contractDateController,
                                       data.contractDate,
                                     ),
                                     textField(
                                       'Note',
                                       customerNoteController,
                                       data.customerNote,
                                     ),
                                   ],

                                   textField(
                                     'Weighted%',
                                     weightedController,
                                     data.weighted,
                                     enabled: false,
                                   ),

                                   textField(
                                     'Meeting Notes',
                                     meetingNotesController,
                                     data.meetingNotes,
                                     maxLines: 3,
                                   ),

                                   textField(
                                     'Next Step',
                                     nextStepController,
                                     data.nextStep,
                                     maxLines: 3,
                                   ),

                                   dateField(
                                     'Est.Contract Date',
                                     estContractDateController,
                                     data.estContractDate,
                                   ),

                                   dateField(
                                     'Est.Start Date',
                                     estStartDateController,
                                     data.estStartDate,
                                   ),

                                   dateField(
                                     'Est.Follow Up Date',
                                     estFollowUpDateController,
                                     data.estFollowUpDate,
                                   ),

                                   if (shouldShowFollowUp()) ...[
                                     dropdownValueField(
                                       label: 'Follow Up Via',
                                       items: ddl.followupVia ?? [],
                                       value: followUpVia,
                                       onChanged: (v) => setState(() => followUpVia = v),
                                     ),
                                     dateField(
                                       'Estimate Flight Date',
                                       estimateFlightDateController,
                                       data.estimateFlightdate,
                                     ),
                                   ],
                                 ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            Align(
                              alignment: Alignment.centerRight,
                              child: MaterialButton(
                                height: 45,
                                minWidth: 150,
                                color: kPrimaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                onPressed: _saving ? null : () => onSave(data),
                                child: _saving
                                    ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                                    : const Text(
                                  'Save',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget textField(
      String label,
      TextEditingController controller,
      String? apiValue, {
        bool enabled = true,
        int maxLines = 1,
      }) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelText(label),
          TextFormField(
            controller: controller,
            enabled: enabled,
            maxLines: maxLines,
            decoration: inputDecoration(apiValue ?? ''),
          ),
        ],
      ),
    );
  }

  Widget dateField(
      String label,
      TextEditingController controller,
      String? apiValue,
      ) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelText(label, showCalendar: label == 'Estimate Flight Date'),
          InkWell(
            onTap: () => pickDate(controller),
            child: AbsorbPointer(
              child: TextFormField(
                controller: controller,
                readOnly: true,
                decoration: inputDecoration(
                  hasValue(apiValue) ? apiValue! : 'Select $label',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

Widget dropdownField({
  required String label,
  required List<dynamic> items,
  required dynamic value,
  required ValueChanged<dynamic> onChanged,
}) {
  final validValue = items.any((e) => e.key?.toString() == value?.toString())
      ? value
      : null;

  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText(label),
        DropdownButtonFormField<dynamic>(
          value: validValue,
          isExpanded: true,
          items: items.map((item) {
            return DropdownMenuItem<dynamic>(
              value: item.key,
              child: Text(item.value?.toString() ?? ''),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: inputDecoration('Select $label'),
        ),
      ],
    ),
  );
}

  Widget dropdownValueField({
    required String label,
    required List<DdlItem> items,
    required String? value,
    required ValueChanged<String?> onChanged,
  }) {
    if (items.isEmpty) return const SizedBox();

    final values = items.map((e) => e.value).whereType<String>().toSet().toList();
    final validValue = values.contains(value) ? value : null;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelText(label),
          DropdownButtonFormField<String>(
            value: validValue,
            isExpanded: true,
            items: values.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
            decoration: inputDecoration('Select $label'),
          ),
        ],
      ),
    );
  }

  Widget leadStatusDropdown({
    required List<SaleStatus> items,
  }) {
    if (items.isEmpty) return const SizedBox();

    final validValue = items.any(
          (e) => e.key?.toString() == leadStatus?.toString(),
    )
        ? leadStatus
        : null;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelText('Lead Status'),
          DropdownButtonFormField<dynamic>(
            value: validValue,
            isExpanded: true,
            items: items.map((item) {
              return DropdownMenuItem<dynamic>(
                value: item.key,
                child: Text(item.value ?? ''),
              );
            }).toList(),
            onChanged: (v) {
              setState(() {
                leadStatus = v;

                final selected = items.firstWhere(
                      (e) => e.key.toString() == v.toString(),
                );

                leadStatusName = selected.value;
                weightedController.text = selected.weight ?? '';
              });
            },
            decoration: inputDecoration('Select Lead Status'),
          ),
        ],
      ),
    );
  }

  Widget dropdownPackageField({
    required String label,
    required List<PackageItem> items,
    required String? selectedPlan,
    required String? value,
    required ValueChanged<PackageItem?> onChanged,
  }) {
    final filteredItems = items
        .where((e) => e.plan?.trim() == selectedPlan?.trim())
        .toList();

    if (filteredItems.isEmpty) return const SizedBox();

    final validValue = filteredItems.any((e) => e.key == value) ? value : null;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelText(label),
          DropdownButtonFormField<String>(
            value: validValue,
            isExpanded: true,
            items: filteredItems.map((item) {
              return DropdownMenuItem<String>(
                value: item.key,
                child: Text(item.key ?? ''),
              );
            }).toList(),
            onChanged: (v) {
              final selected = filteredItems.firstWhere(
                    (e) => e.key == v,
              );

              onChanged(selected);
            },
            decoration: inputDecoration('Select $label'),
          ),
        ],
      ),
    );
  }

  Widget labelText(String label, {bool showCalendar = false}) {
    final requiredLabels = [
      'Lat',
      'Long',
      'Installation Appointment Date',
      'Contracted Date',
      'Note',
      'Est.Contract Date',
      'Est.Start Date',
      'Est.Follow Up Date',
    ];

    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        if (requiredLabels.contains(label))
          const Text('*', style: TextStyle(color: Colors.red)),
        if (showCalendar)
          const Icon(Icons.calendar_month, color: Colors.white, size: 18),
      ],
    );
  }

  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: BorderSide.none,
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: BorderSide.none,
      ),
    );
  }

  bool shouldShowFollowUp() {
    return leadStatus == 'Keep Follow Up' ||
        leadStatus == 'Proposal Follow Up' ||
        leadStatus == 'Appointment' ||
        leadStatus == 'Contract Follow Up' ||
        leadStatus == 'Contracted';
  }

  Future<void> pickDate(TextEditingController controller) async {
    final now = DateTime.now();

    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (date == null) return;

    controller.text =
    '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}