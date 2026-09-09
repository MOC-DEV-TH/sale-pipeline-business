import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sale_pipeline_business/features/leads/controller/leads_controller.dart';
import 'package:sale_pipeline_business/features/leads/data/leads_repository.dart';
import 'package:sale_pipeline_business/features/leads/model/participants_response.dart';

import '../widgets/activity_form_field.dart';
import '../widgets/activity_type_dropdown.dart';
import '../widgets/lead_action_form_common.dart';
import '../widgets/user_multi_select_field.dart';

class CreateActivityPage extends ConsumerStatefulWidget {
  const CreateActivityPage({
    super.key,
    required this.leadTitle,
    required this.businessName,
    required this.leadId,
  });

  final String leadTitle;
  final String businessName;
  final int leadId;

  @override
  ConsumerState<CreateActivityPage> createState() => _CreateActivityPageState();
}

class _CreateActivityPageState extends ConsumerState<CreateActivityPage> {
  final subjectController = TextEditingController();
  final dateController = TextEditingController();
  final descriptionController = TextEditingController();

  String? selectedType;

  List<ParticipantVO> selectedParticipants = [];

  DateTime? selectedDateTime;

  bool emailNotification = false;

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
      leadParticipantsProvider(leadId: widget.leadId),
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
                  /// Header
                  Header(
                    title: 'Create New Activity',
                    onBack: () {
                      Navigator.pop(context);
                    },
                  ),

                  const SizedBox(height: 35),

                  /// Lead title
                  Text(
                    widget.leadTitle,
                    style: const TextStyle(
                      color: Color(0xFF00C65A),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// Lead badge
                  LeadBadge(
                    leadId: widget.leadId,
                    businessName: widget.businessName,
                  ),

                  const SizedBox(height: 18),

                  /// Subject
                  ActivityFormField(
                    label: 'Subject',
                    required: true,
                    controller: subjectController,
                    hint: 'Enter Subject',
                  ),

                  const SizedBox(height: 20),

                  /// Type
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

                  /// Participants
                  participantsState.when(
                    loading: () {
                      return Container(
                        width: double.infinity,
                        height: 68,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0B341F),
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: const Color(0xFF56846A)),
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
                          color: Colors.red.withOpacity(0.10),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: Colors.redAccent),
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
                                    leadId: widget.leadId,
                                  ),
                                );
                              },
                              child: const Text(
                                'Retry',
                                style: TextStyle(color: Color(0xFF00C65A)),
                              ),
                            ),
                          ],
                        ),
                      );
                    },

                    data: (response) {
                      final participants = response.data ?? [];

                      if (participants.isEmpty) {
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0B341F),
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(color: const Color(0xFF56846A)),
                          ),
                          child: const Text(
                            'No participants available',
                            style: TextStyle(color: Colors.white54),
                          ),
                        );
                      }

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

                  /// Description
                  ActivityFormField(
                    label: 'Description',
                    required: true,
                    controller: descriptionController,
                    hint: 'Type Here',
                    maxLines: 8,
                  ),

                  const SizedBox(height: 14),

                  /// Email reminder
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: emailNotification,
                        activeColor: const Color(0xFF00C65A),
                        checkColor: Colors.white,
                        side: const BorderSide(color: Colors.white70),
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

                  /// Buttons
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

        /// Full-screen loading overlay
        if (controllerState.isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.45),
              child: const Center(
                child: CircularProgressIndicator(color: Color(0xFF00C65A)),
              ),
            ),
          ),
      ],
    );
  }

  /// =========================================================
  /// DATE + TIME
  /// =========================================================

  Future<void> _selectDateTime() async {
    final now = DateTime.now();

    final date = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? now,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(2035),
    );

    if (date == null || !mounted) {
      return;
    }

    final time = await showTimePicker(
      context: context,
      initialTime: selectedDateTime != null
          ? TimeOfDay.fromDateTime(selectedDateTime!)
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

  /// =========================================================
  /// SAVE
  /// =========================================================

  Future<void> _save() async {
    /// prevent double submit
    if (ref.read(leadsControllerProvider).isLoading) {
      return;
    }

    final subject = subjectController.text.trim();

    final description = descriptionController.text.trim();

    /// Subject
    if (subject.isEmpty) {
      _showError('Subject is required');

      return;
    }

    /// Date
    if (selectedDateTime == null) {
      _showError('Date & Time is required');

      return;
    }

    /// Participants
    if (selectedParticipants.isEmpty) {
      _showError('Please choose at least one participant');

      return;
    }

    /// Description
    if (description.isEmpty) {
      _showError('Description is required');

      return;
    }

    final participantIds = selectedParticipants
        .where((participant) => participant.id != null)
        .map((participant) => participant.id!)
        .toList();

    if (participantIds.isEmpty) {
      _showError('Invalid participant selection');

      return;
    }

    /// ==============================================
    /// API Payload
    ///
    /// Example:
    ///
    /// {
    ///   "subject": "Introductory Meeting",
    ///   "type": "meeting",
    ///   "activity_at": "2026-09-09 14:00:00",
    ///   "participant_ids": [1],
    ///   "description": "...",
    ///   "send_email_reminder": false
    /// }
    /// ==============================================

    final payload = <String, dynamic>{
      'subject': subject,

      if (selectedType != null && selectedType!.trim().isNotEmpty)
        'type': selectedType!.trim().toLowerCase(),

      'activity_at': _formatApiDateTime(selectedDateTime!),

      'participant_ids': participantIds,

      'description': description,

      'send_email_reminder': emailNotification,
    };

    debugPrint('=============== CREATE ACTIVITY ===============');

    debugPrint('Lead ID >>> ${widget.leadId}');

    debugPrint('Payload >>> $payload');

    debugPrint('================================================');

    final success = await ref
        .read(leadsControllerProvider.notifier)
        .createActivity(leadId: widget.leadId, payload: payload);

    if (!mounted) {
      return;
    }

    if (!success) {
      final controllerState = ref.read(leadsControllerProvider);

      final error = controllerState.error;

      _showError(error?.toString() ?? 'Failed to create activity');

      return;
    }

    /// Return true so LeadDetailPage can
    /// refresh activity logs.
    Navigator.of(context).pop(true);
  }

  /// =========================================================
  /// API DATE
  /// =========================================================

  String _formatApiDateTime(DateTime date) {
    final year = date.year.toString();

    final month = date.month.toString().padLeft(2, '0');

    final day = date.day.toString().padLeft(2, '0');

    final hour = date.hour.toString().padLeft(2, '0');

    final minute = date.minute.toString().padLeft(2, '0');

    final second = date.second.toString().padLeft(2, '0');

    return '$year-$month-$day '
        '$hour:$minute:$second';
  }

  /// =========================================================
  /// ERROR
  /// =========================================================

  void _showError(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(message, style: const TextStyle(color: Colors.white)),
        ),
      );
  }
}
