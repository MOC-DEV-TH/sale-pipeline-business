import 'package:flutter/material.dart';

import '../../model/lead_detail_response.dart';
import 'lead_action_button.dart';
import 'lead_activity_tab.dart';
import 'lead_info_tab.dart';
import 'lead_reminder_tab.dart';
import 'lead_tabs.dart' show LeadTabs;

class LeadDetailBody extends StatelessWidget {
  const LeadDetailBody({super.key,
    required this.lead,
    required this.leadId,
    required this.selectedTab,
    required this.onTabChanged,
    required this.onEdit,
    required this.onActivity,
    required this.onReminder,
    required this.onDelete,
  });

  final LeadDetailData lead;
  final int leadId;

  final int selectedTab;

  final ValueChanged<int> onTabChanged;

  final VoidCallback onEdit;
  final VoidCallback onActivity;
  final VoidCallback onReminder;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 18),

        Text(
          _title(),
          style: const TextStyle(
            color: Color(0xFF09B954),
            fontSize: 24,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ),

        const SizedBox(height: 14),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(
            color: const Color(0xFF116436),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Text(
            '#${lead.lid ?? leadId} | '
                '${lead.businessName ?? '-'}',
            style: const TextStyle(color: Color(0xFFD6E6DD), fontSize: 13),
          ),
        ),

        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: ActionButton(
                backgroundColor: const Color(0xFFFFDF20),
                foregroundColor: const Color(0xFF263724),
                icon: Icons.edit_outlined,
                text: 'Edit',
                onTap: onEdit,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: ActionButton(
                backgroundColor: const Color(0xFF00B950),
                foregroundColor: Colors.white,
                icon: Icons.note_add_outlined,
                text: 'Add Activity',
                onTap: onActivity,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: ActionButton(
                backgroundColor: const Color(0xFF0F5B35),
                foregroundColor: Colors.white,
                icon: Icons.alarm_outlined,
                text: 'Create Reminder',
                onTap: onReminder,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: ActionButton(
                backgroundColor: const Color(0xFFFF2019),
                foregroundColor: Colors.white,
                icon: Icons.close,
                text: 'Delete',
                onTap: onDelete,
              ),
            ),
          ],
        ),

        const SizedBox(height: 38),

        LeadTabs(selectedIndex: selectedTab, onChanged: onTabChanged),

        const SizedBox(height: 28),

        if (selectedTab == 0)
          LeadInfoTab(lead: lead)
        else if (selectedTab == 1)
          ActivityTab(leadId: leadId)
        else
          ReminderTab(leadId: leadId),
      ],
    );
  }

  String _title() {
    final fields = lead.labeledFields ?? [];

    for (final field in fields) {
      if (field.label == 'Campaign' &&
          field.value != null &&
          field.value!.trim().isNotEmpty) {
        return field.value!;
      }
    }

    return lead.firstname ?? lead.businessName ?? 'Lead Detail';
  }
}