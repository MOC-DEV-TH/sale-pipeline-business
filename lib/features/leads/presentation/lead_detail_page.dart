import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/images.dart';
import '../model/leads_response.dart';

class LeadDetailPage extends ConsumerStatefulWidget {
  const LeadDetailPage({super.key, required this.uid, required this.leadId});

  final String uid;
  final String leadId;

  @override
  ConsumerState<LeadDetailPage> createState() => _LeadDetailPageState();
}

class _LeadDetailPageState extends ConsumerState<LeadDetailPage> {
  int selectedTab = 0;

  /// =========================================================
  /// TEMP
  ///
  /// Replace this with your API response:
  ///
  /// final detailState = ref.watch(
  ///   fetchLeadDetailProvider(
  ///     leadId: widget.leadId,
  ///   ),
  /// );
  /// =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF061B10),
      body: SafeArea(
        child: Column(
          children: [
            /// Back button
            _Header(
              onBack: () {
                Navigator.of(context).pop();
              },
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 30),
                child: _buildDummyContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Remove this after connecting API.
  Widget _buildDummyContent() {
    final lead = LeadVO(
      lid: int.tryParse(widget.leadId),
      businessName: 'Urban Kitchen (Bonchon Myanmar)',
      secondaryContactNumber: 'Retainer + TikTok Content Management',
      status: "Waiting for the client's feedback",
      bizType: 'Website',
      channel: 'Partner',
      source: '10%',
      packageTotal: '12000000',
      leadAssign: 2,
      startDate: '2026-01-08',
      estContractDate: '2026-01-08',
      followUpDate: '2026-01-08',
      createdAt: '2026-01-08T08:40:35',
      updatedAt: '2026-01-08T08:40:35',
      createdByName: 'Sale 1',
      meetingNote:
          'Sent retainer package on 2nd June, 2026. Client chose "InoBird" media agency for it.',
      nextStep: 'Close the project',
    );

    return _LeadDetailBody(
      lead: lead,
      selectedTab: selectedTab,
      onTabChanged: (index) {
        setState(() {
          selectedTab = index;
        });
      },

      onEdit: () async {
        /// TODO
      },

      onActivity: () async {
        /// TODO
      },

      onReminder: () async {
        /// TODO
      },

      onDelete: () async {
        final confirmed = await _showDeleteDialog();

        if (confirmed != true) {
          return;
        }

        /// Call delete API here.

        if (!mounted) return;

        Navigator.of(context).pop(true);
      },
    );
  }

  Future<bool?> _showDeleteDialog() {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.75),
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(
              maxWidth: 420,
            ),
            padding: const EdgeInsets.fromLTRB(
              24,
              26,
              24,
              22,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF0B341F),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: const Color(0xFF397457),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.35),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Delete icon
                Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF2B24)
                        .withOpacity(0.12),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFFF2B24)
                          .withOpacity(0.35),
                    ),
                  ),
                  child: const Icon(
                    Icons.delete_outline_rounded,
                    color: Color(0xFFFF453A),
                    size: 34,
                  ),
                ),

                const SizedBox(height: 20),

                /// Title
                const Text(
                  'Delete Lead?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 10),

                /// Description
                const Text(
                  'Are you sure you want to delete this lead? '
                      'This action cannot be undone.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFB8C8BE),
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 26),

                /// Buttons
                Row(
                  children: [
                    /// Cancel
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(
                              dialogContext,
                            ).pop(false);
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(
                              color: Color(0xFF397457),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    /// Delete
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(
                              dialogContext,
                            ).pop(true);
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor:
                            const Color(0xFFFF2B24),
                            foregroundColor: Colors.white,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.delete_outline_rounded,
                                size: 19,
                              ),
                              SizedBox(width: 7),
                              Text(
                                'Delete',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// ===========================================================
/// HEADER
/// ===========================================================

class _Header extends StatelessWidget {
  const _Header({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 8),
      child: Row(
        children: [
          InkWell(
            onTap: onBack,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF0B341F),
                border: Border.all(color: const Color(0xFF397457)),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),

          const Spacer(),

          Image.asset(
            kLogoImage,
            width: 160,
            height: 39,
            gaplessPlayback: true,
          ),

          const Spacer(),

          const SizedBox(width: 68),
        ],
      ),
    );
  }
}

/// ===========================================================
/// BODY
/// ===========================================================

class _LeadDetailBody extends StatelessWidget {
  const _LeadDetailBody({
    required this.lead,
    required this.selectedTab,
    required this.onTabChanged,
    required this.onEdit,
    required this.onActivity,
    required this.onReminder,
    required this.onDelete,
  });

  final LeadVO lead;

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

        /// ===================================================
        /// TITLE
        /// ===================================================
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

        /// ===================================================
        /// BUSINESS BADGE
        /// ===================================================
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(
            color: const Color(0xFF116436),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Text(
            '#${lead.lid ?? '-'} | ${lead.businessName ?? '-'}',
            style: const TextStyle(color: Color(0xFFD6E6DD), fontSize: 13),
          ),
        ),

        const SizedBox(height: 16),

        /// ===================================================
        /// ACTION BUTTONS
        /// ===================================================
        Row(
          children: [
            Expanded(
              child: _ActionButton(
                backgroundColor: const Color(0xFFFFDF20),
                foregroundColor: const Color(0xFF263724),
                icon: Icons.edit_outlined,
                text: 'Edit',
                onTap: onEdit,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: _ActionButton(
                backgroundColor: const Color(0xFF00B950),
                foregroundColor: Colors.white,
                icon: Icons.note_add_outlined,
                text: 'Add Activity',
                onTap: onActivity,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: _ActionButton(
                backgroundColor: const Color(0xFF0F5B35),
                foregroundColor: Colors.white,
                icon: Icons.alarm_outlined,
                text: 'Create Reminder',
                onTap: onReminder,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: _ActionButton(
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

        /// ===================================================
        /// TABS
        /// ===================================================
        _LeadTabs(selectedIndex: selectedTab, onChanged: onTabChanged),

        const SizedBox(height: 28),

        if (selectedTab == 0)
          _LeadInfoTab(lead: lead)
        else if (selectedTab == 1)
          const _ActivityTab()
        else if (selectedTab == 2)
          const _ReminderTab()
      ],
    );
  }

  String _title() {
    if (_hasValue(lead.secondaryContactNumber)) {
      return lead.secondaryContactNumber!;
    }

    return lead.businessName ?? 'Lead Detail';
  }

  bool _hasValue(String? value) {
    return value != null && value.trim().isNotEmpty;
  }
}

/// ===========================================================
/// ACTION BUTTON
/// ===========================================================

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(7),
      child: Container(
        height: 68,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: foregroundColor, size: 24),

            const SizedBox(height: 7),

            Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: foregroundColor,
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ===========================================================
/// TABS
/// ===========================================================

class _LeadTabs extends StatelessWidget {
  const _LeadTabs({required this.selectedIndex, required this.onChanged});

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    const tabs = ['Lead Info', 'Activity', 'Reminder'];

    return Container(
      height: 45,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF0A2C1B),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFF619173)),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final selected = selectedIndex == index;

          return Expanded(
            child: InkWell(
              onTap: () {
                onChanged(index);
              },
              borderRadius: BorderRadius.circular(25),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFF087D3E)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                  border: selected
                      ? Border.all(color: const Color(0xFF13C760))
                      : null,
                ),
                child: Text(
                  tabs[index],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// ===========================================================
/// LEAD INFO
/// ===========================================================

class _LeadInfoTab extends StatelessWidget {
  const _LeadInfoTab({required this.lead});

  final LeadVO lead;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'GENERAL INFORMATION',
            style: TextStyle(color: Colors.white, fontSize: 11),
          ),

          const SizedBox(height: 24),

          /// Status
          _DetailRow(
            label: 'Status:',
            child: _StatusBadge(text: _display(lead.status)),
          ),

          _DetailTextRow(label: 'Title:', value: _display(_title())),

          _DetailTextRow(
            label: 'Campaign:',
            value: _display(lead.product ?? lead.businessName),
          ),

          _DetailTextRow(label: 'Type:', value: _display(lead.bizType)),

          _DetailTextRow(label: 'Channel:', value: _display(lead.channel)),

          _DetailTextRow(
            label: 'Country:',
            value: _display(lead.township ?? lead.division),
          ),

          _DetailTextRow(label: 'Funnel Stage:', value: _display(lead.source)),

          _DetailTextRow(
            label: 'Estimated Revenue:',
            value: _revenueText(),
            valueColor: const Color(0xFF00C754),
            valueSize: 16,
          ),

          _DetailTextRow(
            label: 'Assigned User:',
            value: lead.leadAssign != null ? 'Sale ${lead.leadAssign}' : '-',
          ),

          _DetailTextRow(
            label: 'Start Date:',
            value: _dateOnly(lead.startDate),
          ),

          _DetailTextRow(
            label: 'End Date:',
            value: _dateOnly(lead.estContractDate),
          ),

          _DetailTextRow(
            label: 'Closed Date:',
            value: _dateOnly(lead.followUpDate ?? lead.followupDate),
          ),

          _DetailTextRow(
            label: 'Creation Date:',
            value: _dateTime(lead.createdAt),
          ),

          _DetailTextRow(
            label: 'Modified Date:',
            value: _dateTime(lead.updatedAt),
          ),

          _DetailTextRow(
            label: 'Created By:',
            value: _display(lead.createdByName ?? lead.uploadedBy),
          ),

          const SizedBox(height: 12),

          _NoteSection(title: 'MEETING NOTE', text: _display(lead.meetingNote)),

          const SizedBox(height: 28),

          _NoteSection(title: 'NEXT STEP', text: _display(lead.nextStep)),
        ],
      ),
    );
  }

  String? _title() {
    if (_hasValue(lead.secondaryContactNumber)) {
      return lead.secondaryContactNumber;
    }

    return lead.businessName;
  }

  String _revenueText() {
    if (!_hasValue(lead.packageTotal)) {
      return '-';
    }

    final amount = double.tryParse(lead.packageTotal!.replaceAll(',', ''));

    if (amount == null) {
      return lead.packageTotal!;
    }

    final formatted = _formatMoney(amount);

    final currency = _currency();

    return '$formatted $currency';
  }

  String _currency() {
    final value = lead.package?.toLowerCase() ?? lead.plan?.toLowerCase() ?? '';

    if (value.contains('mmk') || value.contains('kyat')) {
      return 'MMK';
    }

    if (value.contains('thb') || value.contains('baht')) {
      return 'THB';
    }

    if (value.contains('usd') || value.contains('dollar')) {
      return 'USD';
    }

    return '';
  }

  String _formatMoney(double value) {
    final text = value.toStringAsFixed(value % 1 == 0 ? 0 : 2);

    final parts = text.split('.');

    final chars = parts[0].split('');

    final output = <String>[];

    for (int i = 0; i < chars.length; i++) {
      final remaining = chars.length - i;

      output.add(chars[i]);

      if (remaining > 1 && remaining % 3 == 1) {
        output.add(',');
      }
    }

    if (parts.length > 1) {
      return '${output.join()}.${parts[1]}';
    }

    return output.join();
  }

  String _display(String? value) {
    if (!_hasValue(value)) {
      return '-';
    }

    return value!;
  }

  bool _hasValue(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  String _dateOnly(String? value) {
    if (!_hasValue(value)) {
      return '-';
    }

    final date = DateTime.tryParse(value!);

    if (date == null) {
      if (value.length >= 10) {
        return value.substring(0, 10);
      }

      return value;
    }

    final month = date.month.toString().padLeft(2, '0');

    final day = date.day.toString().padLeft(2, '0');

    return '${date.year}-$month-$day';
  }

  String _dateTime(String? value) {
    if (!_hasValue(value)) {
      return '-';
    }

    final date = DateTime.tryParse(value!);

    if (date == null) {
      return value;
    }

    final local = date.toLocal();

    final month = local.month.toString().padLeft(2, '0');

    final day = local.day.toString().padLeft(2, '0');

    final hour = local.hour.toString().padLeft(2, '0');

    final minute = local.minute.toString().padLeft(2, '0');

    final second = local.second.toString().padLeft(2, '0');

    return '${local.year}-$month-$day '
        '$hour:$minute:$second';
  }
}

/// ===========================================================
/// DETAIL ROW
/// ===========================================================

class _DetailTextRow extends StatelessWidget {
  const _DetailTextRow({
    required this.label,
    required this.value,
    this.valueColor = Colors.white,
    this.valueSize = 14,
  });

  final String label;
  final String value;

  final Color valueColor;
  final double valueSize;

  @override
  Widget build(BuildContext context) {
    return _DetailRow(
      label: label,
      child: Text(
        value,
        style: TextStyle(
          color: valueColor,
          fontSize: valueSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 172,
            child: Text(
              label,
              style: const TextStyle(color: Color(0xFFC2CDC6), fontSize: 14),
            ),
          ),

          Expanded(child: child),
        ],
      ),
    );
  }
}

/// ===========================================================
/// STATUS BADGE
/// ===========================================================

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
        decoration: BoxDecoration(
          color: const Color(0xFF8AC4A5),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 11),
        ),
      ),
    );
  }
}

/// ===========================================================
/// NOTE
/// ===========================================================

class _NoteSection extends StatelessWidget {
  const _NoteSection({required this.title, required this.text});

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 11)),

        const SizedBox(height: 14),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 8, bottom: 16),
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(color: Color(0xFF34A262), width: 2),
              bottom: BorderSide(color: Color(0xFF116436)),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFFD8E0DB),
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

/// ===========================================================
/// ACTIVITY TAB
/// ===========================================================

class _ActivityTab extends StatelessWidget {
  const _ActivityTab();

  @override
  Widget build(BuildContext context) {
    const activities = [
      _ActivityDummyVO(
        title: 'Proposal Follow-up Call',
        type: 'Call',
        description:
            'Followed up on proposal sent earlier. Client requested clarification on project scope and timeline.',
        participants: 'Thiri Toe Win, Julia',
        createdBy: 'Thiri Toe Win',
        dateTime: '1 Sep 2026, 09:00 AM',
      ),
      _ActivityDummyVO(
        title: 'Project Requirement Meeting',
        type: 'Meeting',
        description:
            "Reviewed the client's requirements, objectives, and expected deliverables.",
        participants: 'Thiri Toe Win, Julia',
        createdBy: 'Thiri Toe Win',
        dateTime: '1 Sep 2026, 09:00 AM',
      ),
    ];

    return Column(
      children: activities
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: _ActivityCard(item: item),
            ),
          )
          .toList(),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  const _ActivityCard({required this.item});

  final _ActivityDummyVO item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(26, 18, 26, 16),
      decoration: BoxDecoration(
        color: const Color(0xFF0B341F),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF397457)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  item.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
                decoration: BoxDecoration(
                  color: const Color(0xFF8AC4A5),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Text(
                  item.type,
                  style: const TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 8),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: Color(0xFFACFFD0), width: 3),
              ),
            ),
            child: Text(
              item.description,
              style: const TextStyle(
                color: Color(0xFFD6DED9),
                fontSize: 13,
                height: 1.3,
              ),
            ),
          ),

          const SizedBox(height: 16),

          Text(
            item.participants,
            style: const TextStyle(color: Colors.white, fontSize: 11),
          ),

          const SizedBox(height: 12),

          Container(height: 1, color: const Color(0xFF116436)),

          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                child: Text(
                  item.createdBy,
                  style: const TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
              Text(
                item.dateTime,
                style: const TextStyle(color: Colors.white, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActivityDummyVO {
  final String title;
  final String type;
  final String description;
  final String participants;
  final String createdBy;
  final String dateTime;

  const _ActivityDummyVO({
    required this.title,
    required this.type,
    required this.description,
    required this.participants,
    required this.createdBy,
    required this.dateTime,
  });
}


/// ===========================================================
/// REMINDER TAB
/// ===========================================================
class _ReminderTab extends StatelessWidget {
  const _ReminderTab();

  @override
  Widget build(BuildContext context) {
    const reminders = [
      _ReminderDummyVO(
        description:
            'Followed up on proposal sent earlier. Client requested clarification on project scope and timeline.',
        participants: 'Thiri Toe Win, Julia',
        createdBy: 'Thiri Toe Win',
        dateTime: '1 Sep 2026, 09:00 AM',
      ),
    ];

    return Column(
      children: reminders
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: _ReminderCard(item: item),
            ),
          )
          .toList(),
    );
  }
}

class _ReminderCard extends StatelessWidget {
  const _ReminderCard({required this.item});

  final _ReminderDummyVO item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(26, 18, 26, 16),
      decoration: BoxDecoration(
        color: const Color(0xFF0B341F),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF397457)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 62,
                height: 62,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF087C3E),
                ),
                child: const Icon(
                  Icons.alarm_outlined,
                  color: Colors.white,
                  size: 31,
                ),
              ),

              const SizedBox(width: 18),

              Expanded(
                child: Text(
                  item.description,
                  style: const TextStyle(
                    color: Color(0xFFD6DED9),
                    fontSize: 13,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.only(left: 80),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                item.participants,
                style: const TextStyle(color: Colors.white, fontSize: 11),
              ),
            ),
          ),

          const SizedBox(height: 14),

          Container(
            margin: const EdgeInsets.only(left: 80),
            height: 1,
            color: const Color(0xFF116436),
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                child: Text(
                  item.createdBy,
                  style: const TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
              Text(
                item.dateTime,
                style: const TextStyle(color: Colors.white, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReminderDummyVO {
  final String description;
  final String participants;
  final String createdBy;
  final String dateTime;

  const _ReminderDummyVO({
    required this.description,
    required this.participants,
    required this.createdBy,
    required this.dateTime,
  });
}
