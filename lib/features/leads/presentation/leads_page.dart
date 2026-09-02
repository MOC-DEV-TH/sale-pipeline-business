import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sale_pipeline_business/features/leads/model/leads_response.dart';
import 'package:sale_pipeline_business/utils/app_colors.dart';

import '../../choose_task_page/provider/selected_organization_provider.dart';
import '../data/leads_repository.dart';
import 'lead_detail_page.dart';

class LeadsPage extends ConsumerStatefulWidget {
  const LeadsPage({
    super.key,
  });

  @override
  ConsumerState<LeadsPage> createState() =>
      _LeadsPageState();
}

class _LeadsPageState extends ConsumerState<LeadsPage> {
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    final organizationId = ref.watch(
      selectedOrganizationProvider.select(
            (organization) => organization?.id,
      ),
    );

    if (organizationId == null) {
      return const SafeArea(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final leadsState = ref.watch(
      fetchLeadsByOrganizationIDProvider(
        organizationID: organizationId,
        pageNo: currentPage,
      ),
    );

    return Container(
      color: const Color(0xFF061B10),
      child: SafeArea(
        child: leadsState.when(
          loading: () {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF16B65B),
              ),
            );
          },

          error: (error, stackTrace) {
            return _ErrorView(
              message: error.toString(),
              onRetry: () {
                ref.invalidate(
                  fetchLeadsByOrganizationIDProvider(
                    organizationID: organizationId,
                    pageNo: currentPage,
                  ),
                );
              },
            );
          },

          data: (data) {
            final leads = data.details ?? [];
            final pagination = data.pagination;

            return RefreshIndicator(
              color: const Color(0xFF16B65B),
              onRefresh: () async {
                ref.invalidate(
                  fetchLeadsByOrganizationIDProvider(
                    organizationID: organizationId,
                    pageNo: currentPage,
                  ),
                );
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  16,
                  14,
                  16,
                  30,
                ),
                children: [
                  /// ==========================================
                  /// TITLE
                  /// ==========================================

                  const SizedBox(
                    height: 30,
                  ),

                  const Text(
                    'All Lead List',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(
                    height: 28,
                  ),

                  /// ==========================================
                  /// EMPTY
                  /// ==========================================

                  if (leads.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 80,
                      ),
                      child: Center(
                        child: Text(
                          'No leads found',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),

                  /// ==========================================
                  /// LEAD CARDS
                  /// ==========================================

                  ...List.generate(
                    leads.length,
                        (index) {
                      final lead = leads[index];

                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 28,
                        ),
                        child: LeadCard(
                          lead: lead,
                          onTap: () async {
                            final updated =
                            await Navigator.of(context).push<bool>(
                              MaterialPageRoute(
                                builder: (_) => LeadDetailPage(
                                  uid: lead.lid.toString(),
                                  leadId: lead.lid.toString(),
                                ),
                              ),
                            );

                            if (updated == true) {
                              ref.invalidate(
                                fetchLeadsByOrganizationIDProvider(
                                  organizationID: organizationId,
                                  pageNo: currentPage,
                                ),
                              );
                            }
                          },
                        ),
                      );
                    },
                  ),

                  /// ==========================================
                  /// PAGINATION
                  /// ==========================================

                  if (pagination != null &&
                      (pagination.lastPage ?? 1) > 1) ...[
                    const SizedBox(
                      height: 4,
                    ),

                    LeadPagination(
                      currentPage:
                      pagination.currentPage ?? currentPage,
                      lastPage:
                      pagination.lastPage ?? 1,
                      total:
                      pagination.total ?? 0,
                      perPage:
                      pagination.perPage ?? 20,
                      onPageChanged: (page) {
                        setState(() {
                          currentPage = page;
                        });
                      },
                    ),

                    const SizedBox(
                      height: 90,
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// ===========================================================
/// LEAD CARD
/// ===========================================================

class LeadCard extends StatelessWidget {
  const LeadCard({
    super.key,
    required this.lead,
    required this.onTap,
  });

  final LeadVO lead;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(
          26,
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(
            20,
            20,
            20,
            22,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF0B341F),
            borderRadius: BorderRadius.circular(
              26,
            ),
            border: Border.all(
              color: const Color(0xFF397457),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(
                  0.12,
                ),
                blurRadius: 14,
                offset: const Offset(
                  0,
                  5,
                ),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              /// =============================================
              /// CLIENT / BUSINESS
              /// =============================================

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 0,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF116436),
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                ),
                child: Text(
                  _businessLabel(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFFD5E7DB),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              /// =============================================
              /// PROJECT / LEAD NAME
              /// =============================================

              Text(
                _leadTitle(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  height: 1.25,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              /// =============================================
              /// STATUS CHIP
              /// =============================================

              if (_hasValue(lead.status))
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: 270,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8AC4A5),
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                  ),
                  child: Text(
                    lead.status!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFFF0F7F3),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

              const SizedBox(
                height: 10,
              ),

              /// =============================================
              /// TYPE / FUNNEL
              /// =============================================

              Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _InfoRow(
                      label: 'Type:',
                      value: _display(
                        lead.bizType,
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 20,
                  ),

                  Expanded(
                    child: _InfoRow(
                      label: 'Funnel Stage:',
                      value: _display(
                        lead.source,
                      ),
                      rightAligned: true,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 10,
              ),

              /// =============================================
              /// DATES
              /// =============================================

              Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _InfoRow(
                      label: 'Proposal Due:',
                      value: _dateOnly(
                        lead.estContractDate,
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 20,
                  ),

                  Expanded(
                    child: _InfoRow(
                      label: 'Closed Date:',
                      value: _dateOnly(
                        lead.followUpDate ??
                            lead.followupDate,
                      ),
                      rightAligned: true,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 10,
              ),

              /// =============================================
              /// DIVIDER
              /// =============================================

              Container(
                height: 1,
                width: double.infinity,
                color: const Color(
                  0xFF16894D,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              /// =============================================
              /// FOOTER
              /// =============================================

              Row(
                children: [
                  Expanded(
                    child: Text(
                      lead.createdByName ??
                          lead.uploadedBy ??
                          '-',
                      maxLines: 1,
                      overflow:
                      TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 12,
                  ),

                  Text(
                    _formatDateTime(
                      lead.createdAt,
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _businessLabel() {
    final id = lead.lid != null
        ? '#${lead.lid}'
        : '#-';

    final businessName =
    lead.businessName?.trim();

    if (businessName == null ||
        businessName.isEmpty) {
      return id;
    }

    return '$id | $businessName';
  }

  String _leadTitle() {
    /// Based on your API structure,
    /// secondaryContactNumber appears to contain
    /// the project / lead description in many records.
    if (_hasValue(
      lead.title,
    )) {
      return lead.title!;
    }


    return 'Untitled Lead';
  }

  String _display(
      String? value,
      ) {
    if (!_hasValue(value)) {
      return '-';
    }

    return value!;
  }

  bool _hasValue(
      String? value,
      ) {
    return value != null &&
        value.trim().isNotEmpty;
  }

  String _dateOnly(
      String? value,
      ) {
    if (!_hasValue(value)) {
      return '--------';
    }

    final parsed = DateTime.tryParse(
      value!,
    );

    if (parsed == null) {
      if (value.length >= 10) {
        return value.substring(
          0,
          10,
        );
      }

      return value;
    }

    final month = parsed.month
        .toString()
        .padLeft(
      2,
      '0',
    );

    final day = parsed.day
        .toString()
        .padLeft(
      2,
      '0',
    );

    return '${parsed.year}-$month-$day';
  }

  String _formatDateTime(
      String? value,
      ) {
    if (!_hasValue(value)) {
      return '-';
    }

    final date = DateTime.tryParse(
      value!,
    );

    if (date == null) {
      return value;
    }

    final localDate =
    date.toLocal();

    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final hour12 =
    localDate.hour == 0
        ? 12
        : localDate.hour > 12
        ? localDate.hour - 12
        : localDate.hour;

    final minute = localDate.minute
        .toString()
        .padLeft(
      2,
      '0',
    );

    final amPm =
    localDate.hour >= 12
        ? 'PM'
        : 'AM';

    return '${localDate.day} '
        '${months[localDate.month - 1]} '
        '${localDate.year}, '
        '$hour12:$minute $amPm';
  }
}

/// ===========================================================
/// INFO ROW
/// ===========================================================

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    this.rightAligned = false,
  });

  final String label;
  final String value;
  final bool rightAligned;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: rightAligned
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow:
            TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFFD5DDD8),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),

        const SizedBox(
          width: 10,
        ),

        Flexible(
          child: Text(
            value,
            maxLines: 1,
            overflow:
            TextOverflow.ellipsis,
            textAlign: rightAligned
                ? TextAlign.right
                : TextAlign.left,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

/// ===========================================================
/// ERROR
/// ===========================================================

class _ErrorView extends StatelessWidget {
  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(
          24,
        ),
        child: Column(
          mainAxisSize:
          MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.redAccent,
              size: 45,
            ),

            const SizedBox(
              height: 15,
            ),

            Text(
              message,
              textAlign:
              TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            ElevatedButton(
              onPressed: onRetry,
              style:
              ElevatedButton.styleFrom(
                backgroundColor:
                const Color(
                  0xFF16894D,
                ),
              ),
              child: const Text(
                'Retry',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ===========================================================
/// PAGINATION
/// ===========================================================

class LeadPagination extends StatelessWidget {
  const LeadPagination({
    super.key,
    required this.currentPage,
    required this.lastPage,
    required this.total,
    required this.perPage,
    required this.onPageChanged,
  });

  final int currentPage;
  final int lastPage;
  final int total;
  final int perPage;

  final ValueChanged<int>
  onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _resultText(),
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),

        const SizedBox(
          height: 14,
        ),

        Row(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            _PaginationArrow(
              icon: Icons.chevron_left,
              enabled: currentPage > 1,
              onTap: () {
                if (currentPage > 1) {
                  onPageChanged(
                    currentPage - 1,
                  );
                }
              },
            ),

            const SizedBox(
              width: 8,
            ),

            ..._pageNumbers().map(
                  (page) {
                if (page == -1) {
                  return const Padding(
                    padding:
                    EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    child: Text(
                      '...',
                      style: TextStyle(
                        color:
                        Colors.white70,
                      ),
                    ),
                  );
                }

                return Padding(
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 3,
                  ),
                  child: _PageButton(
                    page: page,
                    selected:
                    page == currentPage,
                    onTap: () {
                      if (page !=
                          currentPage) {
                        onPageChanged(
                          page,
                        );
                      }
                    },
                  ),
                );
              },
            ),

            const SizedBox(
              width: 8,
            ),

            _PaginationArrow(
              icon: Icons.chevron_right,
              enabled:
              currentPage < lastPage,
              onTap: () {
                if (currentPage <
                    lastPage) {
                  onPageChanged(
                    currentPage + 1,
                  );
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  String _resultText() {
    if (total == 0) {
      return '0 results';
    }

    final from =
        ((currentPage - 1) *
            perPage) +
            1;

    final calculatedTo =
        currentPage * perPage;

    final to = calculatedTo > total
        ? total
        : calculatedTo;

    return 'Showing $from - $to of $total';
  }

  List<int> _pageNumbers() {
    if (lastPage <= 5) {
      return List.generate(
        lastPage,
            (index) => index + 1,
      );
    }

    if (currentPage <= 3) {
      return [
        1,
        2,
        3,
        4,
        -1,
        lastPage,
      ];
    }

    if (currentPage >=
        lastPage - 2) {
      return [
        1,
        -1,
        lastPage - 3,
        lastPage - 2,
        lastPage - 1,
        lastPage,
      ];
    }

    return [
      1,
      -1,
      currentPage - 1,
      currentPage,
      currentPage + 1,
      -1,
      lastPage,
    ];
  }
}

class _PageButton extends StatelessWidget {
  const _PageButton({
    required this.page,
    required this.selected,
    required this.onTap,
  });

  final int page;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius:
      BorderRadius.circular(
        10,
      ),
      child: Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected
              ? const Color(
            0xFF16894D,
          )
              : const Color(
            0xFF0B341F,
          ),
          borderRadius:
          BorderRadius.circular(
            10,
          ),
          border: Border.all(
            color: const Color(
              0xFF16894D,
            ),
          ),
        ),
        child: Text(
          '$page',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: selected
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _PaginationArrow extends StatelessWidget {
  const _PaginationArrow({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
      enabled ? onTap : null,
      borderRadius:
      BorderRadius.circular(
        10,
      ),
      child: Container(
        width: 38,
        height: 38,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(
            0xFF0B341F,
          ),
          borderRadius:
          BorderRadius.circular(
            10,
          ),
          border: Border.all(
            color: enabled
                ? const Color(
              0xFF16894D,
            )
                : Colors.white24,
          ),
        ),
        child: Icon(
          icon,
          color: enabled
              ? Colors.white
              : Colors.white24,
        ),
      ),
    );
  }
}