import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/leads_controller.dart';
import '../data/leads_repository.dart';
import '../model/lead_reminder_response.dart';
import '../model/participants_response.dart';

import '../widgets/activity_form_field.dart';
import '../widgets/lead_action_form_common.dart';
import '../widgets/user_multi_select_field.dart';

class EditReminderPage extends ConsumerStatefulWidget {
  const EditReminderPage({
    super.key,
    required this.reminder,
    required this.leadTitle,
    required this.businessName,
  });

  final LeadReminderVO reminder;

  final String leadTitle;
  final String businessName;

  @override
  ConsumerState<EditReminderPage> createState() => _EditReminderPageState();
}

class _EditReminderPageState extends ConsumerState<EditReminderPage> {
  final noteController = TextEditingController();

  final dateController = TextEditingController();

  DateTime? selectedDateTime;

  List<ParticipantVO> selectedAssignees = [];

  bool _participantsInitialized = false;

  int get leadId => widget.reminder.leadId ?? 0;

  @override
  void initState() {
    super.initState();

    _parseReminder();
  }

  void _parseReminder() {
    noteController.text = widget.reminder.note ?? '';

    selectedDateTime = DateTime.tryParse(
      widget.reminder.remindAtLocal ?? '',
    );

    if (selectedDateTime != null) {
      dateController.text = _formatDisplayDateTime(selectedDateTime!);
    } else if (widget.reminder.remindAtLocal != null) {
      dateController.text = widget.reminder.remindAtLocal!;
    }
  }

  @override
  void dispose() {
    noteController.dispose();
    dateController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final participantsState = ref.watch(
      leadParticipantsProvider(leadId: leadId),
    );

    final controllerState = ref.watch(leadsControllerProvider);

    return Stack(
      children: [
        Scaffold(
          backgroundColor: const Color(0xFF061B10),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(32, 25, 32, 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(
                    title: 'Edit Reminder',
                    onBack: () {
                      Navigator.pop(context);
                    },
                  ),

                  const SizedBox(height: 35),

                  LeadBadge(leadId: leadId, businessName: widget.businessName),

                  const SizedBox(height: 20),

                  ActivityFormField(
                    label: 'Note',
                    required: true,
                    controller: noteController,
                    hint: 'Type Here',
                    maxLines: 6,
                  ),

                  const SizedBox(height: 20),

                  ActivityFormField(
                    label: 'Remind At',
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

                  participantsState.when(
                    loading: () {
                      return const SizedBox(
                        height: 68,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF00C65A),
                          ),
                        ),
                      );
                    },

                    error: (error, stack) {
                      return Text(
                        error.toString(),
                        style: const TextStyle(color: Colors.redAccent),
                      );
                    },

                    data: (response) {
                      final participants = response.data ?? [];

                      _initializeParticipants(participants);

                      return UserMultiSelectField(
                        label: 'Participants',
                        required: true,
                        users: participants,
                        selectedUsers: selectedAssignees,
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

        if (controllerState.isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.black45,
              child: const Center(
                child: CircularProgressIndicator(color: Color(0xFF00C65A)),
              ),
            ),
          ),
      ],
    );
  }

  void _initializeParticipants(List<ParticipantVO> allParticipants) {
    if (_participantsInitialized) {
      return;
    }

    _participantsInitialized = true;

    final selectedIds = widget.reminder.participantIds ?? [];

    selectedAssignees = allParticipants.where((participant) {
      return participant.id != null && selectedIds.contains(participant.id);
    }).toList();
  }

  Future<void> _selectDateTime() async {
    final initial = selectedDateTime ?? DateTime.now();

    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );

    if (date == null || !mounted) {
      return;
    }

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
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

      dateController.text = _formatDisplayDateTime(result);
    });
  }

  Future<void> _save() async {
    if (ref.read(leadsControllerProvider).isLoading) {
      return;
    }

    final note = noteController.text.trim();

    if (note.isEmpty) {
      _showError('Note is required');
      return;
    }

    if (selectedDateTime == null) {
      _showError('Date & Time is required');
      return;
    }

    if (selectedAssignees.isEmpty) {
      _showError('Please choose at least one assignee');
      return;
    }

    final reminderId = widget.reminder.id;

    if (reminderId == null || leadId <= 0) {
      _showError('Invalid reminder');
      return;
    }

    final payload = <String, dynamic>{
      'note': note,

      'remind_at': _formatApiDateTime(selectedDateTime!),

      'participant_ids': selectedAssignees
          .where((participant) => participant.id != null)
          .map((participant) => participant.id!)
          .toList(),
    };

    debugPrint('EDIT REMINDER >>> $payload');

    final success = await ref
        .read(leadsControllerProvider.notifier)
        .updateReminder(
          leadId: leadId,
          reminderId: reminderId,
          payload: payload,
        );

    if (!mounted) {
      return;
    }

    if (!success) {
      final error = ref.read(leadsControllerProvider).error;

      _showError(error?.toString() ?? 'Failed to update reminder');

      return;
    }

    Navigator.pop(context, true);
  }

  String _formatDisplayDateTime(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year} '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }

  String _formatApiDateTime(DateTime date) {
    return '${date.year.toString().padLeft(4, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')} '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}:'
        '${date.second.toString().padLeft(2, '0')}';
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(backgroundColor: Colors.redAccent, content: Text(message)),
      );
  }
}
