import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sale_pipeline_business/features/contracts/presentation/contract_detail_page.dart';
import 'package:sale_pipeline_business/features/contracts/presentation/signed_contracted_lead_webview_page.dart';

import '../../../utils/secure_storage.dart';
import '../../../widgets/contract_action_table_cell.dart';
import '../../../widgets/lead_list_page_template.dart';
import '../../../widgets/lead_search_box.dart';
import '../../../widgets/lead_table_cell.dart';
import '../data/contracts_repository.dart';
import '../model/contracts_response.dart';

class ContractsPage extends ConsumerStatefulWidget {
  const ContractsPage({super.key});

  @override
  ConsumerState<ContractsPage> createState() => _ContractsPageState();
}

class _ContractsPageState extends ConsumerState<ContractsPage> {
  String businessName = '';

  @override
  Widget build(BuildContext context) {
    final uid = ref.watch(getUidProvider);

    final contractsState = ref.watch(
      fetchContractListProvider(
        uid: uid ?? '',
        filterParamName: _filterParam(),
      ),
    );

    return ListPageTemplate(
      title: 'Contracts',
      filters: [
        SearchBox(
          hint: 'Business name',
          onSearch: (value) {
            setState(() => businessName = value);
          },
        ),
      ],
      table: contractsState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) =>
            Text(e.toString(), style: const TextStyle(color: Colors.white)),
        data: (data) => ContractsTable(contracts: data.details ?? [],uid: uid,),
      ),
    );
  }

  String _filterParam() {
    if (businessName.trim().isEmpty) return '';

    return '&business_name=${Uri.encodeComponent(businessName.trim())}';
  }
}

class ContractsTable extends ConsumerWidget {
  ContractsTable({super.key, required this.contracts,required this.uid});

  final List<ContractDetailVo> contracts;
  dynamic uid;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    if (contracts.isEmpty) {
      return const Center(
        child: Text(
          'No contracts found',
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
                LeadTableCell(text: 'SN', isHeader: true, flex: 1),
                LeadTableCell(text: 'Business Name', isHeader: true, flex: 2),
                LeadTableCell(text: 'Status', isHeader: true, flex: 2),
                LeadTableCell(
                  text: 'Action',
                  isHeader: true,
                  isLast: true,
                  flex: 2,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 14),
            height: 1,
            color: Colors.white.withOpacity(0.15),
          ),
          Column(
            children: List.generate(contracts.length, (index) {
              final item = contracts[index];

              return Column(
                children: [
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        LeadTableCell(text: '${index + 1}', flex: 1),
                        LeadTableCell(text: item.businessName ?? '-', flex: 2),
                        LeadTableCell(text: item.status ?? '-', flex: 2),
                        ContractActionTableCell(
                          flex: 2,
                          isLast: true,
                          onEdit: () async{
                            debugPrint('Edit ${item.businessName}');
                            final updated = await Navigator.of(context)
                                .push<bool>(
                                  MaterialPageRoute(
                                    builder: (_) => ContractedDetailPage(
                                      uid: uid,
                                      profileId: item.profileId.toString(),
                                    ),
                                  ),
                                );

                            if (updated == true) {
                              ref.invalidate(fetchContractListProvider);
                            }
                          },
                          onSigned: () async{
                            debugPrint('Signed ${item.businessName}');
                            final signed = await Navigator.push<bool>(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SignedContractedLeadWebViewPage(
                                  url: item.sign ?? '',
                                ),
                              ),
                            );

                            if (signed == true) {
                              ref.invalidate(fetchContractListProvider);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  if (index != contracts.length - 1)
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
