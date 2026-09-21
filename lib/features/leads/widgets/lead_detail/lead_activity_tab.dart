import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sale_pipeline_business/features/leads/widgets/lead_detail/remove_log_confirm_dialog.dart';
import '../../../../utils/app_snackbar.dart';
import '../../controller/leads_controller.dart';
import '../../data/leads_repository.dart';
import '../../model/lead_activity_response.dart';
import '../../presentation/edit_activity_page.dart';
import 'lead_log_card.dart';
import 'lead_log_option_sheet.dart';
import 'lead_tab_error.dart';
import 'lead_tab_loading.dart';

class ActivityTab extends ConsumerWidget {
  const ActivityTab({super.key, required this.leadId});

  final int leadId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(leadActivityLogsProvider(leadId: leadId));

    return state.when(
      loading: () {
        return const TabLoading();
      },

      error: (error, stack) {
        return TabError(
          message: error.toString(),
          onRetry: () {
            ref.invalidate(leadActivityLogsProvider(leadId: leadId));
          },
        );
      },

      data: (response) {
        final activities = response.data ?? [];

        if (activities.isEmpty) {
          return const _EmptyActivityView();
        }

        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 120),
          child: Column(
            children: List.generate(activities.length, (index) {
              final activity = activities[index];

              return Padding(
                padding: EdgeInsets.only(
                  bottom: index == activities.length - 1 ? 0 : 18,
                ),
                child: LeadLogCard(
                  title: activity.subject ?? '-',
                  type: activity.type ?? '-',
                  description: activity.description ?? '-',
                  participants: _participantNames(activity),
                  creatorName: activity.creatorName ?? '-',
                  dateTime: formatDateTime(activity.createdAt),

                  onMoreTap: () {
                    showLeadLogOptionSheet(
                      context: context,
                      title: 'Select Options',
                      editText: 'Edit Activity',
                      removeText: 'Remove Activity',
                      removeSuccessMessage: 'Activity removed successfully',

                      onEdit: () {
                        _editActivity(context,ref, activity);
                      },

                      onRemove: () {
                        return _removeActivity(context, ref, activity);
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

  String _participantNames(LeadActivityVO activity) {
    final participants = activity.participants ?? [];

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

    return DateFormat('d MMM yyyy, h:mm a').format(
      dateTime.toLocal(),
    );
  }

  Future<void> _editActivity(
      BuildContext context,
      WidgetRef ref,
      LeadActivityVO activity,
      ) async {
    final updated =
    await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => EditActivityPage(
          activity: activity,
          leadTitle:
          activity.subject ?? 'Activity',
          businessName: '',
        ),
      ),
    );

    if (updated == true) {
      ref.invalidate(
        leadActivityLogsProvider(
          leadId: leadId,
        ),
      );
    }
  }

  Future<bool> _removeActivity(
    BuildContext context,
    WidgetRef ref,
    LeadActivityVO activity,
  ) async {
    final activityId = activity.id;

    if (activityId == null) {
      AppSnackBar.showError(context, 'Invalid activity ID');

      return false;
    }

    final confirmed = await showRemoveLogConfirmDialog(
      context: context,
      title: 'Remove Activity?',
      message:
          'Are you sure you want to remove this activity? '
          'This action cannot be undone.',
      confirmText: 'Remove',
    );

    if (confirmed != true) {
      return false;
    }

    final success = await ref
        .read(leadsControllerProvider.notifier)
        .removeActivity(leadId: leadId, activityLogId: activityId);

    if (!context.mounted) {
      return false;
    }

    if (!success) {
      final error = ref.read(leadsControllerProvider).error;

      AppSnackBar.showError(
        context,
        error?.toString() ?? 'Failed to remove activity',
      );

      return false;
    }

    ref.invalidate(leadActivityLogsProvider(leadId: leadId));

    return true;
  }
}

class _EmptyActivityView extends StatelessWidget {
  const _EmptyActivityView();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 70),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.history_rounded, size: 44, color: Colors.white38),
            SizedBox(height: 12),
            Text(
              'No activities found',
              style: TextStyle(color: Colors.white60, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
