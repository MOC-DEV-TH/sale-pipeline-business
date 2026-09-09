import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sale_pipeline_business/features/leads/controller/leads_controller.dart';
import 'package:sale_pipeline_business/features/leads/data/leads_repository.dart';
import 'package:sale_pipeline_business/features/leads/model/participants_response.dart';

import '../widgets/activity_form_field.dart';
import '../widgets/lead_action_form_common.dart';
import '../widgets/user_multi_select_field.dart';

class CreateReminderPage extends ConsumerStatefulWidget {
  const CreateReminderPage({
    super.key,
    required this.leadTitle,
    required this.businessName,
    required this.leadId,
  });

  final String leadTitle;
  final String businessName;
  final int leadId;

  @override
  ConsumerState<CreateReminderPage> createState() =>
      _CreateReminderPageState();
}

class _CreateReminderPageState
    extends ConsumerState<CreateReminderPage> {
  final noteController = TextEditingController();
  final dateController = TextEditingController();

  DateTime? selectedDateTime;

  List<ParticipantVO> selectedAssignees = [];

  @override
  void dispose() {
    noteController.dispose();
    dateController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final participantsState = ref.watch(
      leadParticipantsProvider(
        leadId: widget.leadId,
      ),
    );

    final controllerState = ref.watch(
      leadsControllerProvider,
    );

    return Stack(
      children: [
        Scaffold(
          backgroundColor: const Color(0xFF061B10),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                32,
                25,
                32,
                35,
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Header(
                    title: 'Create New Reminder',
                    onBack: () {
                      Navigator.pop(context);
                    },
                  ),

                  const SizedBox(height: 35),

                  Text(
                    widget.leadTitle,
                    style: const TextStyle(
                      color: Color(0xFF00C65A),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  LeadBadge(
                    leadId: widget.leadId,
                    businessName: widget.businessName,
                  ),

                  const SizedBox(height: 20),

                  /// Note
                  ActivityFormField(
                    label: 'Note',
                    required: true,
                    controller: noteController,
                    hint: 'Type Here',
                    maxLines: 6,
                  ),

                  const SizedBox(height: 20),

                  /// Date & Time
                  ActivityFormField(
                    label: 'Date & Time',
                    required: true,
                    controller: dateController,
                    hint: 'dd/mm/yyyy H:m',
                    readOnly: true,
                    suffixIcon: const Icon(
                      Icons.calendar_month_outlined,
                      color: Color(0xFF9CC9A9),
                    ),
                    onTap: _selectDateTime,
                  ),

                  const SizedBox(height: 20),

                  /// Assignee
                  participantsState.when(
                    loading: () {
                      return Container(
                        width: double.infinity,
                        height: 68,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0B341F),
                          borderRadius:
                          BorderRadius.circular(22),
                          border: Border.all(
                            color: const Color(0xFF56846A),
                          ),
                        ),
                        child: const Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Color(0xFF00C65A),
                            ),
                          ),
                        ),
                      );
                    },

                    error: (error, stack) {
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color:
                          Colors.red.withOpacity(0.10),
                          borderRadius:
                          BorderRadius.circular(18),
                          border: Border.all(
                            color: Colors.redAccent,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: Colors.redAccent,
                            ),

                            const SizedBox(width: 10),

                            Expanded(
                              child: Text(
                                error.toString(),
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ),

                            TextButton(
                              onPressed: () {
                                ref.invalidate(
                                  leadParticipantsProvider(
                                    leadId:
                                    widget.leadId,
                                  ),
                                );
                              },
                              child: const Text(
                                'Retry',
                                style: TextStyle(
                                  color:
                                  Color(0xFF00C65A),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },

                    data: (response) {
                      final participants =
                          response.data ?? [];

                      if (participants.isEmpty) {
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color:
                            const Color(0xFF0B341F),
                            borderRadius:
                            BorderRadius.circular(22),
                            border: Border.all(
                              color:
                              const Color(0xFF56846A),
                            ),
                          ),
                          child: const Text(
                            'No assignees available',
                            style: TextStyle(
                              color: Colors.white54,
                            ),
                          ),
                        );
                      }

                      return UserMultiSelectField(
                        label: 'Assignee',
                        required: true,
                        users: participants,
                        selectedUsers:
                        selectedAssignees,
                        onChanged: (users) {
                          setState(() {
                            selectedAssignees = users;
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 32),

                  BottomButtons(
                    onCancel: () {
                      Navigator.pop(context);
                    },
                    onSave: _save,
                  ),
                ],
              ),
            ),
          ),
        ),

        /// loading overlay
        if (controllerState.isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.45),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF00C65A),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _selectDateTime() async {
    final now = DateTime.now();

    final date = await showDatePicker(
      context: context,
      initialDate:
      selectedDateTime ?? now,
      firstDate: DateTime(
        now.year,
        now.month,
        now.day,
      ),
      lastDate: DateTime(2035),
    );

    if (date == null || !mounted) {
      return;
    }

    final time = await showTimePicker(
      context: context,
      initialTime:
      selectedDateTime != null
          ? TimeOfDay.fromDateTime(
        selectedDateTime!,
      )
          : TimeOfDay.now(),
    );

    if (time == null || !mounted) {
      return;
    }

    final result = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    setState(() {
      selectedDateTime = result;

      dateController.text =
      '${result.day.toString().padLeft(2, '0')}/'
          '${result.month.toString().padLeft(2, '0')}/'
          '${result.year} '
          '${result.hour.toString().padLeft(2, '0')}:'
          '${result.minute.toString().padLeft(2, '0')}';
    });
  }

  Future<void> _save() async {
    if (ref.read(leadsControllerProvider).isLoading) {
      return;
    }

    final note =
    noteController.text.trim();

    if (note.isEmpty) {
      _showError(
        'Note is required',
      );
      return;
    }

    if (selectedDateTime == null) {
      _showError(
        'Date & Time is required',
      );
      return;
    }

    if (selectedAssignees.isEmpty) {
      _showError(
        'Please choose at least one assignee',
      );
      return;
    }

    final participantIds =
    selectedAssignees
        .where(
          (participant) =>
      participant.id != null,
    )
        .map(
          (participant) =>
      participant.id!,
    )
        .toList();

    if (participantIds.isEmpty) {
      _showError(
        'Invalid assignee selection',
      );
      return;
    }

    final payload = <String, dynamic>{
      'note': note,

      'remind_at':
      _formatApiDateTime(
        selectedDateTime!,
      ),

      'participant_ids':
      participantIds,
    };

    debugPrint(
      '=============== CREATE REMINDER ===============',
    );

    debugPrint(
      'Lead ID >>> ${widget.leadId}',
    );

    debugPrint(
      'Payload >>> $payload',
    );

    debugPrint(
      '===============================================',
    );

    final success = await ref
        .read(
      leadsControllerProvider.notifier,
    )
        .createReminder(
      leadId: widget.leadId,
      payload: payload,
    );

    if (!mounted) {
      return;
    }

    if (!success) {
      final state = ref.read(
        leadsControllerProvider,
      );

      _showError(
        state.error?.toString() ??
            'Failed to create reminder',
      );

      return;
    }

    Navigator.of(context).pop(true);
  }

  String _formatApiDateTime(
      DateTime date,
      ) {
    final year =
    date.year.toString();

    final month =
    date.month
        .toString()
        .padLeft(2, '0');

    final day =
    date.day
        .toString()
        .padLeft(2, '0');

    final hour =
    date.hour
        .toString()
        .padLeft(2, '0');

    final minute =
    date.minute
        .toString()
        .padLeft(2, '0');

    final second =
    date.second
        .toString()
        .padLeft(2, '0');

    return '$year-$month-$day '
        '$hour:$minute:$second';
  }

  void _showError(
      String message,
      ) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor:
          Colors.redAccent,
          content: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
  }
}