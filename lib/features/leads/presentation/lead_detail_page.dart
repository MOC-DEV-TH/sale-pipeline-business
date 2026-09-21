import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:sale_pipeline_business/features/leads/widgets/lead_detail/delete_lead_dialog.dart';

import '../../../common_widgets/loading_view.dart';

import '../controller/leads_controller.dart';
import '../data/leads_repository.dart';
import '../model/lead_detail_response.dart';
import '../widgets/lead_detail/lead_api_error_view.dart';
import '../widgets/lead_detail/lead_detail_body.dart';
import '../widgets/lead_detail/lead_detail_header.dart' show Header;
import 'create_activity_page.dart';
import 'create_reminder_page.dart';
import 'edit_lead_page.dart';

class LeadDetailPage extends ConsumerStatefulWidget {
  const LeadDetailPage({super.key, required this.uid, required this.leadId});

  final String uid;
  final String leadId;

  @override
  ConsumerState<LeadDetailPage> createState() => _LeadDetailPageState();
}

class _LeadDetailPageState extends ConsumerState<LeadDetailPage> {
  int selectedTab = 0;

  int get _leadId {
    return int.tryParse(widget.leadId) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final leadControllerState = ref.watch(leadsControllerProvider);

    if (_leadId <= 0) {
      return const Scaffold(
        backgroundColor: Color(0xFF061B10),
        body: SafeArea(
          child: Center(
            child: Text(
              'Invalid lead ID',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    }

    /// =====================================================
    /// Lead Detail
    /// =====================================================

    final leadDetailState = ref.watch(fetchLeadDetailProvider(leadId: _leadId));

    return Stack(
      children: [
        Scaffold(
          backgroundColor: const Color(0xFF061B10),
          body: SafeArea(
            child: Column(
              children: [
                Header(
                  onBack: () {
                    Navigator.of(context).pop();
                  },
                ),

                Expanded(
                  child: leadDetailState.when(
                    loading: () {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF00C65A),
                        ),
                      );
                    },

                    error: (error, stack) {
                      return ApiErrorView(
                        message: error.toString(),
                        onRetry: () {
                          ref.invalidate(
                            fetchLeadDetailProvider(leadId: _leadId),
                          );
                        },
                      );
                    },

                    data: (response) {
                      final lead = response.data;

                      if (lead == null) {
                        return const Center(
                          child: Text(
                            'Lead not found',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }

                      return SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(16, 10, 16, 30),
                        child: LeadDetailBody(
                          lead: lead,
                          leadId: _leadId,
                          selectedTab: selectedTab,

                          onTabChanged: (index) {
                            setState(() {
                              selectedTab = index;
                            });
                          },

                          ///ON EDIT
                          onEdit: () async {
                            final updated =
                            await Navigator.of(context).push<bool>(
                              MaterialPageRoute(
                                builder: (_) => EditLeadPage(
                                  leadId: _leadId,
                                ),
                              ),
                            );

                            if (updated == true) {
                              ref.invalidate(
                                fetchLeadDetailProvider(
                                  leadId: _leadId,
                                ),
                              );

                              ref.invalidate(fetchLeadsByOrganizationIDProvider);

                            }
                          },

                          ///ON ACTIVITY
                          onActivity: () async {
                            final updated = await Navigator.of(context)
                                .push<bool>(
                                  MaterialPageRoute(
                                    builder: (_) => CreateActivityPage(
                                      leadId: _leadId,
                                      leadTitle: _leadTitle(lead),
                                      businessName: lead.businessName ?? '-',
                                    ),
                                  ),
                                );

                            if (updated == true) {
                              ref.invalidate(
                                leadActivityLogsProvider(leadId: _leadId),
                              );
                            }
                          },

                          ///ON REMINDER
                          onReminder: () async {
                            final updated = await Navigator.of(context)
                                .push<bool>(
                                  MaterialPageRoute(
                                    builder: (_) => CreateReminderPage(
                                      leadId: _leadId,
                                      leadTitle: _leadTitle(lead),
                                      businessName: lead.businessName ?? '-',
                                    ),
                                  ),
                                );

                            if (updated == true) {
                              ref.invalidate(
                                leadRemindersProvider(leadId: _leadId),
                              );
                            }
                          },

                          ///ON DELETE
                          onDelete: () async {
                            await _deleteLead(lead);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),

        /// Controller loading
        if (leadControllerState.isLoading)
          Container(
            color: Colors.black12,
            child: const Center(
              child: LoadingView(
                indicatorColor: Colors.white,
                indicator: Indicator.ballRotate,
              ),
            ),
          ),
      ],
    );
  }

  String _leadTitle(LeadDetailData lead) {
    final campaign = lead.labeledFields
        ?.where((field) => field.label == 'Campaign')
        .firstOrNull
        ?.value;

    if (campaign != null && campaign.trim().isNotEmpty) {
      return campaign;
    }

    if (lead.firstname != null && lead.firstname!.trim().isNotEmpty) {
      return lead.firstname!;
    }

    return lead.businessName ?? 'Lead Detail';
  }

  Future<void> _deleteLead(LeadDetailData lead) async {
    final confirmed = await showDeleteLeadDialog(context);

    if (confirmed != true) {
      return;
    }

    final leadId = lead.lid ?? _leadId;

    final success = await ref
        .read(leadsControllerProvider.notifier)
        .deleteLead(leadId: leadId);

    if (!mounted) {
      return;
    }

    if (!success) {
      final error = ref.read(leadsControllerProvider).error;

      _showError(error?.toString() ?? 'Failed to delete lead');

      return;
    }

    Navigator.of(context).pop(true);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(backgroundColor: Colors.red, content: Text(message)),
      );
  }
}
