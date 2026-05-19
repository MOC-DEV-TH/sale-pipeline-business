import 'package:flutter/material.dart';

class ListPageTemplate extends StatelessWidget {
  final String title;
  final List<Widget> filters;
  final Widget table;

  const ListPageTemplate({
    required this.title,
    required this.filters,
    required this.table,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 34, 24, 110),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),

            Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF00C853),
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),

            const SizedBox(height: 26),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Search',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),

            const SizedBox(height: 12),

            LayoutBuilder(
              builder: (context, constraints) {
                final isMultiple = filters.length > 1;

                return Align(
                  alignment:
                  isMultiple ? Alignment.center : Alignment.centerLeft,
                  child: Wrap(
                    alignment:
                    isMultiple
                        ? WrapAlignment.center
                        : WrapAlignment.start,
                    spacing: 20,
                    runSpacing: 18,
                    children: filters,
                  ),
                );
              },
            ),

            const SizedBox(height: 34),

            /// scrollable table
            Expanded(
              child: SingleChildScrollView(
                child: table,
              ),
            ),
          ],
        ),
      ),
    );
  }
}