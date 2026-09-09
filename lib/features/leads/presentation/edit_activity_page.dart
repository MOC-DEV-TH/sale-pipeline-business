import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/leads_controller.dart';
import '../data/leads_repository.dart';
import '../model/lead_activity_response.dart';
import '../model/participants_response.dart';

import '../widgets/activity_form_field.dart';
import '../widgets/activity_type_dropdown.dart';
import '../widgets/lead_action_form_common.dart';
import '../widgets/user_multi_select_field.dart';

class EditActivityPage extends ConsumerStatefulWidget {
  const EditActivityPage({
    super.key,
    required this.activity,
    required this.leadTitle,
    required this.businessName,
  });

  final LeadActivityVO activity;
  final String leadTitle;
  final String businessName;

  @override
  ConsumerState<EditActivityPage> createState() => _EditActivityPageState();
}

class _EditActivityPageState extends ConsumerState<EditActivityPage> {
  final subjectController = TextEditingController();
  final dateController = TextEditingController();
  final descriptionController = TextEditingController();

  String? selectedType;

  DateTime? selectedDateTime;

  bool emailNotification = false;

  List<ParticipantVO> selectedParticipants = [];

  bool _participantsInitialized = false;

  int get leadId => widget.activity.leadId ?? 0;

  @override
  void initState() {
    super.initState();

    _parseActivity();
  }

  void _parseActivity() {
    subjectController.text = widget.activity.subject ?? '';

    descriptionController.text = widget.activity.description ?? '';

    selectedType = _normalizeType(widget.activity.type);

    selectedDateTime = DateTime.tryParse(
      widget.activity.activityAtLocal ?? '',
    );

    emailNotification = widget.activity.sendEmailReminder ?? false;

    if (selectedDateTime != null) {
      dateController.text = _formatDisplayDateTime(selectedDateTime!);
    } else if (widget.activity.activityAtLocal != null) {
      dateController.text = widget.activity.activityAtLocal!;
    }
  }

  String? _normalizeType(String? type) {
    if (type == null || type.trim().isEmpty) {
      return null;
    }

    final value = type.trim().toLowerCase();

    switch (value) {
      case 'call':
        return 'Call';

      case 'meeting':
        return 'Meeting';

      case 'email':
        return 'Email';

      case 'note':
        return 'Note';

      case 'task':
        return 'Task';

      default:
        return null;
    }
  }

  @override
  void dispose() {
    subjectController.dispose();
    dateController.dispose();
    descriptionController.dispose();

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
                    title: 'Edit Activity',
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

                  LeadBadge(leadId: leadId, businessName: widget.businessName),

                  const SizedBox(height: 20),

                  ActivityFormField(
                    label: 'Subject',
                    required: true,
                    controller: subjectController,
                    hint: 'Enter Subject',
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Type',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),

                  const SizedBox(height: 8),

                  ActivityTypeDropdown(
                    value: selectedType,
                    onChanged: (value) {
                      setState(() {
                        selectedType = value;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

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
                        selectedUsers: selectedParticipants,
                        onChanged: (users) {
                          setState(() {
                            selectedParticipants = users;
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  ActivityFormField(
                    label: 'Description',
                    required: true,
                    controller: descriptionController,
                    hint: 'Type Here',
                    maxLines: 8,
                  ),

                  const SizedBox(height: 14),

                  Row(
                    children: [
                      Checkbox(
                        value: emailNotification,
                        activeColor: const Color(0xFF00C65A),
                        onChanged: (value) {
                          setState(() {
                            emailNotification = value ?? false;
                          });
                        },
                      ),

                      const Expanded(
                        child: Text(
                          'Want to set an email notification reminding this activity?',
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

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

    final selectedIds = widget.activity.participantIds ?? [];

    selectedParticipants = allParticipants.where((participant) {
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

    if (subjectController.text.trim().isEmpty) {
      _showError('Subject is required');
      return;
    }

    if (selectedDateTime == null) {
      _showError('Date & Time is required');
      return;
    }

    if (selectedParticipants.isEmpty) {
      _showError('Please choose at least one participant');
      return;
    }

    if (descriptionController.text.trim().isEmpty) {
      _showError('Description is required');
      return;
    }

    final activityId = widget.activity.id;

    if (activityId == null || leadId <= 0) {
      _showError('Invalid activity');
      return;
    }

    final payload = <String, dynamic>{
      'subject': subjectController.text.trim(),

      if (selectedType != null) 'type': selectedType!.toLowerCase(),

      'activity_at': _formatApiDateTime(selectedDateTime!),

      'participant_ids': selectedParticipants
          .where((item) => item.id != null)
          .map((item) => item.id!)
          .toList(),

      'description': descriptionController.text.trim(),

      'send_email_reminder': emailNotification,
    };

    debugPrint('EDIT ACTIVITY >>> $payload');

    final success = await ref
        .read(leadsControllerProvider.notifier)
        .updateActivity(
          leadId: leadId,
          activityLogId: activityId,
          payload: payload,
        );

    if (!mounted) {
      return;
    }

    if (!success) {
      final error = ref.read(leadsControllerProvider).error;

      _showError(error?.toString() ?? 'Failed to update activity');

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
