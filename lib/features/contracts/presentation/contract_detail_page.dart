import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sale_pipeline_business/features/contracts/data/contracts_repository.dart';
import 'package:sale_pipeline_business/features/contracts/model/contracted_detail_response.dart';
import 'package:sale_pipeline_business/network/session_interceptor.dart';
import 'package:sale_pipeline_business/utils/app_colors.dart';
import 'package:sale_pipeline_business/utils/images.dart';

import '../../new_lead_step_page/data/new_lead_repository.dart';
import '../../new_lead_step_page/model/sale_dropdown_response.dart';

class ContractedDetailPage extends ConsumerStatefulWidget {
  const ContractedDetailPage({
    super.key,
    required this.uid,
    required this.profileId,
  });

  final String uid;
  final String profileId;

  @override
  ConsumerState<ContractedDetailPage> createState() =>
      _ContractedDetailPageState();
}

class _ContractedDetailPageState extends ConsumerState<ContractedDetailPage> {
  final nameController = TextEditingController();
  final businessNameController = TextEditingController();
  final addressController = TextEditingController();
  final contactNoController = TextEditingController();
  final secondaryContactNoController = TextEditingController();
  final emailController = TextEditingController();
  final currentPlanController = TextEditingController();
  final currentPackageController = TextEditingController();
  final amountController = TextEditingController();
  final latController = TextEditingController();
  final longController = TextEditingController();
  final appointmentDateController = TextEditingController();
  final contractDateController = TextEditingController();
  final noteController = TextEditingController();

  bool _initialized = false;
  bool _saving = false;

  String? division;
  String? township;
  String? customerType;
  String? planValue;
  String? packageValue;

  bool hasValue(dynamic value) {
    final text = value?.toString().trim();
    return text != null && text.isNotEmpty && text.toLowerCase() != 'null';
  }

  void initForm(ContractedDetail data) {
    if (_initialized) return;

    nameController.text = hasValue(data.firstname) ? data.firstname! : '';
    businessNameController.text =
    hasValue(data.businessName) ? data.businessName! : '';
    addressController.text = hasValue(data.address) ? data.address! : '';
    contactNoController.text = hasValue(data.phone1) ? data.phone1! : '';
    secondaryContactNoController.text =
    hasValue(data.phone2) ? data.phone2! : '';
    emailController.text = hasValue(data.email) ? data.email! : '';
    latController.text = hasValue(data.latitude) ? data.latitude! : '';
    longController.text = hasValue(data.longitude) ? data.longitude! : '';
    appointmentDateController.text = hasValue(data.installationAppointmentDate)
        ? data.installationAppointmentDate!
        : '';
    contractDateController.text =
    hasValue(data.contractedDate) ? data.contractedDate! : '';
    noteController.text = hasValue(data.notes) ? data.notes! : '';
    amountController.text = hasValue(data.packageTotal) ? data.packageTotal! : '';

    division = hasValue(data.division) ? data.division : null;
    township = hasValue(data.township) ? data.township : null;
    customerType = hasValue(data.customerType) ? data.customerType : null;

    planValue = hasValue(data.plan) ? data.plan : null;
    packageValue = hasValue(data.package) ? data.package : null;

    currentPlanController.text = data.plan ?? '';
    currentPackageController.text = data.package ?? '';

    _initialized = true;
  }

  @override
  void dispose() {
    nameController.dispose();
    businessNameController.dispose();
    addressController.dispose();
    contactNoController.dispose();
    secondaryContactNoController.dispose();
    emailController.dispose();
    currentPlanController.dispose();
    currentPackageController.dispose();
    amountController.dispose();
    latController.dispose();
    longController.dispose();
    appointmentDateController.dispose();
    contractDateController.dispose();
    noteController.dispose();
    super.dispose();
  }

  Future<void> onSave(ContractedDetail data) async {
    if (_saving) return;

    setState(() => _saving = true);

    String? errorMsg;

    if (!checkLatLongLength(latController.text.trim())) {
      errorMsg = 'Latitude field must be filled with format(00.000000)';
    } else if (!checkLatLongLength(longController.text.trim())) {
      errorMsg = 'Longitude field must be filled with format(00.000000)';
    } else if (emailController.text.trim().isNotEmpty &&
        !EmailValidator.validate(emailController.text.trim())) {
      errorMsg = 'Invalid Email Format';
    }

    if (errorMsg != null) {
      if (mounted) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMsg)),
        );
      }
      return;
    }

    final selectedPackage = hasValue(packageValue)
        ? packageValue
        : currentPackageController.text.trim();

    final selectedPlan = hasValue(planValue)
        ? planValue
        : currentPlanController.text.trim();

    final selectedAmount = hasValue(amountController.text)
        ? amountController.text.trim()
        : data.packageTotal;

    final payload = <String, dynamic>{
      'uid': widget.uid,
      'app_version': '1.0',
      'address': addressController.text.trim(),
      'package': selectedPackage,
      'plan': selectedPlan,
      'name': nameController.text.trim(),
      'business_name': businessNameController.text.trim(),
      'contact_number': contactNoController.text.trim(),
      'customer_type': customerType,
      'secondary_contact_number': secondaryContactNoController.text.trim(),
      'email': emailController.text.trim(),
      'division': division,
      'township': township,
      'profile_id': data.profileId ?? widget.profileId,
      'contracted_date': contractDateController.text.trim(),
      'installation_appointment_date':
      appointmentDateController.text.trim(),
      'customer_note': noteController.text.trim(),
      'lat': latController.text.trim(),
      'long': longController.text.trim(),
      'amount': selectedAmount,
    };

    payload.removeWhere((key, value) {
      if (key == 'package' || key == 'amount' || key == 'plan') {
        return false;
      }

      return value == null || (value is String && value.trim().isEmpty);
    });

    try {
      final repo = ref.read(contractsRepositoryProvider);
      await repo.updateContractedLead(payload: payload);

      if (!mounted) return;

      if (!SessionInterceptor.isSessionExpired) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: kPrimaryColor,
            duration: Duration(milliseconds: 1000),
            content: Text('Contract updated successfully.'),
          ),
        );

        ref.invalidate(fetchContractListProvider);
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

  @override
  Widget build(BuildContext context) {
    final detailAsync = ref.watch(
      fetchContractedLeadDetailProvider(
        uid: widget.uid,
        profileId: widget.profileId,
      ),
    );

    final ddlState = ref.watch(fetchSaleDropdownDataProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFF061B10),
      body: SafeArea(
        child: detailAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => errorView(error),
          data: (response) {
            return ddlState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => errorView(error),
              data: (ddl) {
                final data = response.details;

                if (data == null) {
                  return const Center(
                    child: Text(
                      'No contracted detail found',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                initForm(data);

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
                                    textField(
                                      'Name',
                                      nameController,
                                      data.firstname,
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
                                      'Primary Contact Number',
                                      contactNoController,
                                      data.phone1,
                                    ),
                                    textField(
                                      'Secondary Contact Number',
                                      secondaryContactNoController,
                                      data.phone2,
                                    ),
                                    textField(
                                      'Email',
                                      emailController,
                                      data.email,
                                    ),
                                    dropdownValueField(
                                      label: 'Customer Type',
                                      items: ddl.customerType ?? [],
                                      value: customerType,
                                      onChanged: (v) {
                                        setState(() => customerType = v);
                                      },
                                    ),
                                    textField(
                                      'Lat',
                                      latController,
                                      data.latitude,
                                    ),
                                    textField(
                                      'Long',
                                      longController,
                                      data.longitude,
                                    ),
                                    dateField(
                                      'Installation Appointment Date',
                                      appointmentDateController,
                                      data.installationAppointmentDate,
                                    ),
                                    dateField(
                                      'Contracted Date',
                                      contractDateController,
                                      data.contractedDate,
                                    ),
                                    textField(
                                      'Note',
                                      noteController,
                                      data.notes,
                                    ),
                                    dropdownValueField(
                                      label: 'Division',
                                      items: ddl.division ?? [],
                                      value: division,
                                      onChanged: (v) {
                                        setState(() => division = v);
                                      },
                                    ),
                                    dropdownValueField(
                                      label: 'Township',
                                      items: ddl.township ?? [],
                                      value: township,
                                      onChanged: (v) {
                                        setState(() => township = v);
                                      },
                                    ),
                                    textField(
                                      'Current Plan',
                                      currentPlanController,
                                      data.plan,
                                      enabled: false,
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
                                    textField(
                                      'Current Package',
                                      currentPackageController,
                                      data.package,
                                      enabled: false,
                                    ),
                                    dropdownPackageField(
                                      label: 'New Package',
                                      items: ddl.package ?? [],
                                      selectedPlan:
                                      planValue ?? currentPlanController.text,
                                      value: packageValue,
                                      onChanged: (item) {
                                        setState(() {
                                          packageValue = item?.key;
                                          currentPackageController.text =
                                              item?.key ?? '';
                                          amountController.text =
                                              item?.value ?? '';
                                        });
                                      },
                                    ),
                                    textField(
                                      'Amount',
                                      amountController,
                                      data.packageTotal,
                                      enabled: false,
                                    ),
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
                                onPressed:
                                _saving ? null : () => onSave(data),
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

  Widget errorView(Object error) {
    return Center(
      child: Text(
        error.toString(),
        style: const TextStyle(color: Colors.white),
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
            decoration: inputDecoration(
              hasValue(apiValue) ? apiValue! : 'xxxxxxxxxx',
            ),
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
          labelText(label),
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

  Widget dropdownValueField({
    required String label,
    required List<DdlItem> items,
    required String? value,
    required ValueChanged<String?> onChanged,
  }) {
    if (items.isEmpty) return const SizedBox();

    final values =
    items.map((e) => e.value).whereType<String>().toSet().toList();

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
              final selected = filteredItems.firstWhere((e) => e.key == v);
              onChanged(selected);
            },
            decoration: inputDecoration('Select $label'),
          ),
        ],
      ),
    );
  }

  Widget labelText(String label) {
    return Text(
      label,
      style: const TextStyle(color: Colors.white, fontSize: 14),
    );
  }

  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide.none,
      ),
      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide.none,
      ),
    );
  }

  Future<void> pickDate(TextEditingController controller) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selected == null) return;

    controller.text =
    '${selected.year}-${selected.month.toString().padLeft(2, '0')}-${selected.day.toString().padLeft(2, '0')}';
  }

  bool checkLatLongLength(String str) {
    final lat = str.split('.');
    final latList = [];

    for (int i = 0; i < lat.length; i++) {
      latList.add(lat[i]);
    }

    if (latList.length >= 2) {
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
}