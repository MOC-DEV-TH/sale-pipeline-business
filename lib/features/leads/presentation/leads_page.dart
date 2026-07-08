import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sale_pipeline_business/features/leads/model/leads_response.dart';
import 'package:sale_pipeline_business/network/api_constants.dart';
import 'package:sale_pipeline_business/widgets/lead_action_table_cell.dart';

import '../../../utils/secure_storage.dart';
import '../../../widgets/lead_list_page_template.dart';
import '../../../widgets/lead_search_box.dart';
import '../../../widgets/lead_status_box.dart';
import '../../../widgets/lead_table_cell.dart';
import '../data/leads_repository.dart';
import 'lead_detail_page.dart';

class LeadsPage extends ConsumerStatefulWidget {
  const LeadsPage({super.key});

  @override
  ConsumerState<LeadsPage> createState() => _LeadsPageState();
}

class _LeadsPageState extends ConsumerState<LeadsPage> {
  String businessName = '';
  String contactNo = '';
  String contractDate = '';
  String status = '';

  final contractDateCtrl = TextEditingController();

  @override
  void dispose() {
    contractDateCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///get uid
    final uid = ref.watch(getUidProvider);


    final leadsState = ref.watch(
      fetchLeadListProvider(
        uid: uid ?? '',
        filterParamName: _filterParam(),
      ),
    );

    return ListPageTemplate(
      title: 'Leads',
      filters: [
        SearchBox(
          hint: 'Business name',
          onSearch: (value) {
            setState(() => businessName = value);
          },
        ),
        SearchBox(
          hint: 'Est. Contract Date',
          controller: contractDateCtrl,
          isDatePicker: true,
          onSearch: (value) {
            setState(() => contractDate = value);
          },
          onClear: () {
            contractDateCtrl.clear();
            setState(() => contractDate = '');
          },
        ),
        SearchBox(
          hint: 'Contact No.',
          onSearch: (value) {
            setState(() => contactNo = value);
          },
        ),
        StatusBox(
          hint: 'Choose Status',
          items: const [
            'New Lead Potential',
            'Initial Call or Intro Meeting',
            'Good Feedback on Proposal to close',
            'Contracted',
          ],
          onChanged: (value) {
            setState(() => status = value ?? '');
          },
        ),
      ],
      table: leadsState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Text(
          e.toString(),
          style: const TextStyle(color: Colors.white),
        ),
        data: (data) => LeadsTable(
          leads: data.details ?? [],
          uid: uid,
        ),
      ),
    );
  }

  String _filterParam() {
    final params = <String>[];

    if (businessName.trim().isNotEmpty) {
      params.add("$kParamBusinessName${Uri.encodeComponent(businessName)}");
    }

    if (contactNo.trim().isNotEmpty) {
      params.add('$kParamContactNumber${Uri.encodeComponent(contactNo)}');
    }

    if (contractDate.trim().isNotEmpty) {
      params.add('$kParamEstContractDate${Uri.encodeComponent(contractDate)}');
    }

    if (status.trim().isNotEmpty) {
      params.add('$kParamStatus${Uri.encodeComponent(status)}');
    }

    return params.join();
  }
}


class LeadsTable extends ConsumerWidget {
     LeadsTable({
    super.key,
    required this.leads,
    required this.uid
  });

  final List<LeadDetailVO> leads;
  dynamic uid;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    if (leads.isEmpty) {
      return const Center(
        child: Text(
          'No leads found',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF0B3A22).withOpacity(0.96),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFF16894D)),
      ),
      child: Column(
        children: [
          const IntrinsicHeight(
            child: Row(
              children: [
                LeadTableCell(text: 'Business Name', isHeader: true, flex: 2),
                LeadTableCell(text: 'Status', isHeader: true, flex: 1),
                LeadTableCell(text: 'Est.\nContract\nDate', isHeader: true, flex: 1),
                LeadTableCell(text: 'Follow up\ndate', isHeader: true, isLast: true, flex: 1),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 14),
            height: 1,
            color: Colors.white.withOpacity(0.15),
          ),
          Column(
            children: List.generate(leads.length, (index) {
              final item = leads[index];

              return Column(
                children: [
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        LeadActionTableCell(
                          text: item.businessName ?? '-',
                          flex: 2,
                          onTap: () async{
                            final updated = await Navigator.of(context).push<bool>(
                              MaterialPageRoute(
                                builder: (_) => LeadDetailPage(
                                  uid: uid,
                                  leadId: item.lid.toString(),
                                ),
                              ),
                            );

                            if (updated == true) {
                              ref.invalidate(fetchLeadListProvider);
                            }
                          },
                        ),
                        LeadTableCell(
                          text: item.status ?? '-',
                          flex: 1,
                        ),
                        LeadTableCell(
                          text: item.estContractDate ?? '--------',
                          flex: 1,
                        ),
                        LeadTableCell(
                          text: item.followUpDate ??
                              item.followupDate ??
                              '--------',
                          flex: 1,
                          isLast: true,
                        ),
                      ],
                    ),
                  ),
                  if (index != leads.length - 1)
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 14),
                      height: 1,
                      color: Colors.white.withOpacity(0.15),
                    ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}