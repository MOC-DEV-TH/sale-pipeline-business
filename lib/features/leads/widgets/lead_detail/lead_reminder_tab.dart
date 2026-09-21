import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sale_pipeline_business/features/leads/widgets/lead_detail/remove_log_confirm_dialog.dart';

import '../../../../utils/app_snackbar.dart';
import '../../controller/leads_controller.dart';
import '../../data/leads_repository.dart';
import '../../model/lead_reminder_response.dart';
import '../../presentation/edit_reminder_page.dart';
import 'lead_log_card.dart';
import 'lead_log_option_sheet.dart';
import 'lead_tab_error.dart';
import 'lead_tab_loading.dart';

class ReminderTab extends ConsumerWidget {
  const ReminderTab({super.key, required this.leadId});

  final int leadId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(leadRemindersProvider(leadId: leadId));

    return state.when(
      loading: () {
        return const TabLoading();
      },

      error: (error, stack) {
        return TabError(
          message: error.toString(),
          onRetry: () {
            ref.invalidate(leadRemindersProvider(leadId: leadId));
          },
        );
      },

      data: (response) {
        final reminders = response.data ?? [];

        if (reminders.isEmpty) {
          return const _EmptyReminderView();
        }

        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 120),
          child: Column(
            children: List.generate(reminders.length, (index) {
              final reminder = reminders[index];

              return Padding(
                padding: EdgeInsets.only(
                  bottom: index == reminders.length - 1 ? 0 : 18,
                ),
                child: LeadLogCard(
                  description: reminder.note ?? '-',

                  participants: _participantNames(reminder),

                  creatorName: reminder.creatorName ?? '-',

                  dateTime: formatDateTime(reminder.createdAt),

                  showReminderIcon: true,

                  onMoreTap: () {
                    showLeadLogOptionSheet(
                      context: context,
                      title: 'Select Options',
                      editText: 'Edit Reminder',
                      removeText: 'Remove Reminder',
                      removeSuccessMessage: 'Reminder removed successfully',

                      onEdit: () {
                        _editReminder(context, ref, reminder);
                      },

                      onRemove: () {
                        return _removeReminder(context, ref, reminder);
                      },
                    );
                  },
                ),
              );
            }),
          ),
        );
      },
    );
  }

  String _participantNames(LeadReminderVO reminder) {
    final participants = reminder.participants ?? [];

    if (participants.isEmpty) {
      return '-';
    }

    return participants
        .map((e) => e.name ?? '')
        .where((name) => name.trim().isNotEmpty)
        .join(', ');
  }

  String formatDateTime(DateTime? dateTime) {
    if (dateTime == null) {
      return '-';
    }

    return DateFormat('d MMM yyyy, h:mm a').format(dateTime.toLocal());
  }

  Future<void> _editReminder(
    BuildContext context,
    WidgetRef ref,
    LeadReminderVO reminder,
  ) async {
    final updated = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => EditReminderPage(
          reminder: reminder,
          leadTitle: '',
          businessName: '',
        ),
      ),
    );

    if (updated == true) {
      ref.invalidate(leadRemindersProvider(leadId: leadId));
    }
  }

  Future<bool> _removeReminder(
    BuildContext context,
    WidgetRef ref,
    LeadReminderVO reminder,
  ) async {
    final reminderId = reminder.id;

    if (reminderId == null) {
      AppSnackBar.showError(context, 'Invalid reminder ID');

      return false;
    }

    final confirmed = await showRemoveLogConfirmDialog(
      context: context,
      title: 'Remove Reminder?',
      message:
          'Are you sure you want to remove this reminder? '
          'This action cannot be undone.',
      confirmText: 'Remove',
    );

    if (confirmed != true) {
      return false;
    }

    final success = await ref
        .read(leadsControllerProvider.notifier)
        .removeReminder(leadId: leadId, reminderId: reminderId);

    if (!context.mounted) {
      return false;
    }

    if (!success) {
      final error = ref.read(leadsControllerProvider).error;

      AppSnackBar.showError(
        context,
        error?.toString() ?? 'Failed to remove reminder',
      );

      return false;
    }

    ref.invalidate(leadRemindersProvider(leadId: leadId));

    return true;
  }
}

class _EmptyReminderView extends StatelessWidget {
  const _EmptyReminderView();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 70),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.alarm_outlined, size: 44, color: Colors.white38),
            SizedBox(height: 12),
            Text(
              'No reminders found',
              style: TextStyle(color: Colors.white60, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
