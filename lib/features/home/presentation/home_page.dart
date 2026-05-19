import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sale_pipeline_business/routing/go_router/go_router_delegate.dart';
import 'package:sale_pipeline_business/utils/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final sections = const [
    'Follow Up Today',
    'Follow Up This Week',
    'Appointment Today',
    'Appointment This Week',
    'Referral Assignment',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 90),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _HomeHeader(),

            const SizedBox(height: 34),

            Expanded(
              child: ListView.separated(
                itemCount: sections.length,
                separatorBuilder: (_, __) => const SizedBox(height: 20),
                itemBuilder: (_, index) {
                  return _ActivitySection(
                    title: sections[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            context.go(RoutePath.chooseTask.path);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24,
          ),
        ),

        const SizedBox(width: 10),

        const Text(
          'Your Activity This Week',
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

class _ActivitySection extends StatelessWidget {
  final String title;

  const _ActivitySection({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14.5,
            fontWeight: FontWeight.w800,
          ),
        ),

        const SizedBox(height: 8),

        const _ActivityTable(),
      ],
    );
  }
}

class _ActivityTable extends StatelessWidget {
  const _ActivityTable();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: const Color(0xFF0D3A23).withOpacity(0.92),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF1E8E55).withOpacity(0.65),
        ),
      ),
      child: Row(
        children: const [
          _TableHeaderCell(text: 'Date'),
          _VerticalDividerLine(),
          _TableHeaderCell(text: 'Business'),
          _VerticalDividerLine(),
          _TableHeaderCell(text: 'Status'),
          _VerticalDividerLine(),
          _TableHeaderCell(text: 'Follow Up Via', flex: 2),
        ],
      ),
    );
  }
}

class _TableHeaderCell extends StatelessWidget {
  final String text;
  final int flex;

  const _TableHeaderCell({
    required this.text,
    this.flex = 1,
  });

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