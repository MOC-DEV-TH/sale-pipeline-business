import 'package:flutter/material.dart';

import '../../../widgets/contract_action_table_cell.dart';
import '../../../widgets/lead_list_page_template.dart';
import '../../../widgets/lead_search_box.dart';
import '../../../widgets/lead_table_cell.dart';

class ContractsPage extends StatelessWidget {
  const ContractsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListPageTemplate(
      title: 'Leads',
      filters: [SearchBox(hint: 'Business name',onSearch: (value){},)],
      table: ContractsTable(),
    );
  }
}

class ContractItemVO {
  final String sn;
  final String businessName;
  final String status;

  const ContractItemVO({
    required this.sn,
    required this.businessName,
    required this.status,
  });
}

class ContractsTable extends StatelessWidget {
  const ContractsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final contracts = [
      const ContractItemVO(
        sn: '1',
        businessName: 'Mojoenet',
        status: 'Customer\nSigned\nPending',
      ),

      const ContractItemVO(
        sn: '2',
        businessName: 'MOCI',
        status: 'Customer\nSigned\nPending',
      ),

      const ContractItemVO(
        sn: '3',
        businessName: 'Brndwrx',
        status: 'Customer\nSigned\nPending',
      ),
    ];

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
          IntrinsicHeight(
            child: Row(
              children: const [
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
                        LeadTableCell(text: item.sn, flex: 1),
                        LeadTableCell(text: item.businessName, flex: 2),
                        LeadTableCell(text: item.status, flex: 2),
                        ContractActionTableCell(
                          flex: 2,
                          isLast: true,
                          onEdit: () {
                            debugPrint('Edit ${item.businessName}');
                          },
                          onSigned: () {
                            debugPrint('Signed ${item.businessName}');
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
