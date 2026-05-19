import 'package:flutter/material.dart';
import 'package:sale_pipeline_business/widgets/lead_action_table_cell.dart';

import '../../../widgets/lead_list_page_template.dart';
import '../../../widgets/lead_search_box.dart';
import '../../../widgets/lead_status_box.dart';
import '../../../widgets/lead_table_cell.dart';

class LeadsPage extends StatelessWidget {
  const LeadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  ListPageTemplate(
      title: 'Leads',
      filters: [
        SearchBox(hint: 'Business name',onSearch: (value){},),
        SearchBox(
          hint: 'Est. Contract Date',
          isDatePicker: true,
          onSearch: (value) {
            debugPrint('contract date => $value');
          },
        ),
        SearchBox(hint: 'Contact No.',onSearch: (value){},),
        StatusBox(
          hint: 'Choose Status',
          items: const [
            'New Lead',
            'Potential',
            'Pending',
            'Customer Signed',
          ],
          onChanged: (value) {
            debugPrint(value);
          },
        ),
      ],
      table: LeadsTable(),
    );
  }
}


class LeadsTable extends StatelessWidget {
  const LeadsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final leads = [
      const LeadItemVO(
        businessName: 'Pipeline',
        status: 'New lead\nPotential',
        contractDate: '2026-03-01',
        followUpDate: '--------',
      ),

      const LeadItemVO(
        businessName: 'Mojoenet',
        status: 'Customer\nSigned',
        contractDate: '2026-04-10',
        followUpDate: '2026-04-15',
      ),

      const LeadItemVO(
        businessName: 'MOCI',
        status: 'Pending',
        contractDate: '2026-05-01',
        followUpDate: '--------',
      ),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF0B3A22).withOpacity(0.96),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFF16894D),
        ),
      ),
      child: Column(
        children: [
          /// header
          IntrinsicHeight(
            child: Row(
              children: const [
                LeadTableCell(
                  text: 'Business Name',
                  isHeader: true,
                  flex: 2,
                ),
                LeadTableCell(
                  text: 'Status',
                  isHeader: true,
                  flex: 1,
                ),
                LeadTableCell(
                  text: 'Est.\nContract\nDate',
                  isHeader: true,
                  flex: 1,
                ),
                LeadTableCell(
                  text: 'Follow up\ndate',
                  isHeader: true,
                  isLast: true,
                  flex: 1,
                ),
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 14),
            height: 1,
            color: Colors.white.withOpacity(0.15),
          ),

          /// rows
          Column(
            children: List.generate(
              leads.length,
                  (index) {
                final item = leads[index];

                return Column(
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          LeadActionTableCell(
                            text: item.businessName,
                            flex: 2,
                            onTap: () {
                              debugPrint('Open ${item.businessName}');
                            },
                          ),

                          LeadTableCell(
                            text: item.status,
                            flex: 1,
                          ),

                          LeadTableCell(
                            text: item.contractDate,
                            flex: 1,
                          ),

                          LeadTableCell(
                            text: item.followUpDate,
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
              },
            ),
          ),
        ],
      ),
    );
  }
}

class LeadItemVO {
  final String businessName;
  final String status;
  final String contractDate;
  final String followUpDate;

  const LeadItemVO({
    required this.businessName,
    required this.status,
    required this.contractDate,
    required this.followUpDate,
  });
}