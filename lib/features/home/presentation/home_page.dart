import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sale_pipeline_business/features/home/data/home_repository.dart';
import 'package:sale_pipeline_business/features/home/model/report_summary_response.dart';
import 'package:sale_pipeline_business/routing/go_router/go_router_delegate.dart';
import 'package:sale_pipeline_business/utils/app_colors.dart';

import '../../choose_task_page/provider/selected_organization_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {


  @override
  Widget build(BuildContext context) {

    final organizationId = ref.watch(
      selectedOrganizationProvider.select(
            (organization) => organization?.id,
      ),
    );

    debugPrint(
      'Home Organization ID >>> $organizationId',
    );

    if (organizationId == null) {
      return const SafeArea(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final reportSummaryState = ref.watch(
      fetchReportSummaryByOrganizationIDProvider(
        organizationID: organizationId,
      ),
    );

    return SafeArea(
      child: reportSummaryState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Text(
            error.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        data: (response) {
          final details = response.details;

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(fetchReportSummaryByOrganizationIDProvider);
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _HomeHeader(),
                  const SizedBox(height: 34),
                  Expanded(
                    child: ListView(
                      children: [
                        _ActivitySection(
                          title: 'Follow Up Today',
                          items: details?.dailyFollowUpData ?? [],
                        ),
                        const SizedBox(height: 20),
                        _ActivitySection(
                          title: 'Follow Up This Week',
                          items: details?.weeklyFollowUpData ?? [],
                        ),
                        const SizedBox(height: 20),
                        _ActivitySection(
                          title: 'Appointment Today',
                          items: details?.dailyAppointmentData ?? [],
                        ),
                        const SizedBox(height: 20),
                        _ActivitySection(
                          title: 'Appointment This Week',
                          items: details?.weeklyAppointmentData ?? [],
                        ),
                        const SizedBox(height: 20),
                        _ReferralSection(
                          title: 'Referral Assignment',
                          items: details?.leadAssignedData ?? [],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            context.go(RoutePath.chooseTask.path);
          },
          child: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kCardColor,
              border: Border.all(
                color: Colors.white.withOpacity(0.12),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.18),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
        const SizedBox(width: 18),
        const Expanded(
          child: Text(
            'Your Activity This Week',
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 24,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),
        ),
      ],
    );
  }
}

class _ActivitySection extends StatelessWidget {
  const _ActivitySection({
    required this.title,
    required this.items,
  });

  final String title;
  final List<ActivityVO> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(title: title),
        const SizedBox(height: 8),
        _ActivityTable(items: items),
      ],
    );
  }
}

class _ActivityTable extends StatelessWidget {
  const _ActivityTable({
    required this.items,
  });

  final List<ActivityVO> items;

  @override
  Widget build(BuildContext context) {
    return _TableContainer(
      child: Column(
        children: [
          const SizedBox(
            height: 52,
            child: Row(
              children: [
                _TableHeaderCell(text: 'Date'),
                _VerticalDividerLine(),
                _TableHeaderCell(text: 'Business'),
                _VerticalDividerLine(),
                _TableHeaderCell(text: 'Status'),
                _VerticalDividerLine(),
                _TableHeaderCell(text: 'Follow Up Via', flex: 2),
              ],
            ),
          ),
          if (items.isEmpty)
            const _EmptyRow()
          else
            ...items.map(
                  (item) => SizedBox(
                height: 52,
                child: Row(
                  children: [
                    _TableCell(text: item.followupDate ?? '-'),
                    const _VerticalDividerLine(),
                    _TableCell(text: item.businessName ?? '-'),
                    const _VerticalDividerLine(),
                    _TableCell(text: item.status ?? '-'),
                    const _VerticalDividerLine(),
                    _TableCell(
                      text: item.followupVia ?? '-',
                      flex: 2,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ReferralSection extends StatelessWidget {
  const _ReferralSection({
    required this.title,
    required this.items,
  });

  final String title;
  final List<LeadAssignedVO> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(title: title),
        const SizedBox(height: 8),
        _TableContainer(
          child: Column(
            children: [
              const SizedBox(
                height: 52,
                child: Row(
                  children: [
                    _TableHeaderCell(text: 'Business', flex: 2),
                    _VerticalDividerLine(),
                    _TableHeaderCell(text: 'Contact'),
                    _VerticalDividerLine(),
                    _TableHeaderCell(text: 'Address', flex: 2),
                  ],
                ),
              ),
              if (items.isEmpty)
                const _EmptyRow()
              else
                ...items.map(
                      (item) => SizedBox(
                    height: 52,
                    child: Row(
                      children: [
                        _TableCell(
                          text: item.businessName ?? '-',
                          flex: 2,
                        ),
                        const _VerticalDividerLine(),
                        _TableCell(text: item.contactNo ?? '-'),
                        const _VerticalDividerLine(),
                        _TableCell(
                          text: item.address ?? '-',
                          flex: 2,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14.5,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class _TableContainer extends StatelessWidget {
  const _TableContainer({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kCardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF1E8E55).withOpacity(0.65),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: child,
      ),
    );
  }
}

class _TableHeaderCell extends StatelessWidget {
  const _TableHeaderCell({
    required this.text,
    this.flex = 1,
  });

  final String text;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _TableCell extends StatelessWidget {
  const _TableCell({
    required this.text,
    this.flex = 1,
  });

  final String text;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Text(
          text,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _VerticalDividerLine extends StatelessWidget {
  const _VerticalDividerLine();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: double.infinity,
      color: Colors.white.withOpacity(0.18),
    );
  }
}

class _EmptyRow extends StatelessWidget {
  const _EmptyRow();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 2,
      child: Center(
        child: Text(
          '',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}