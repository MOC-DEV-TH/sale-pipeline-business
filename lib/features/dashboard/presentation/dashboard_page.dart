import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sale_pipeline_business/features/traget/presentation/target_page.dart';
import 'package:sale_pipeline_business/utils/images.dart';

import '../../contracts/presentation/contracts_page.dart';
import '../../home/presentation/home_page.dart';
import '../../leads/presentation/leads_page.dart';
import '../../logout/presentation/logout_page.dart';
import '../controller/dashboard_controller.dart';
import '../widget/bottom_navigation_widget.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  static final PageController pageController = PageController(initialPage: 0);

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  final pages = const [
    HomePage(),
    LeadsPage(),
    ContractsPage(),
    TargetPage(),
    LogoutPage(),
  ];

  @override
  void dispose() {
    DashboardPage.pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final position = ref.watch(dashboardControllerProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF061B10),
      extendBody: true,
      body: Stack(
        children: [
          Container(
            color: const Color(0xFF061B10),
          ),

          Positioned.fill(
            child: Image.asset(
              kDashboardBgPatternImage,
              fit: BoxFit.cover,
              gaplessPlayback: true,
            ),
          ),

          PageView(
            controller: DashboardPage.pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              ref.read(dashboardControllerProvider.notifier).setPosition(index);
            },
            children: pages,
          ),

          if (position != 0)
            SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  kLogoImage,
                  width: 160,
                  height: 39,
                  gaplessPlayback: true,
                ),
              ),
            ),

          const Positioned(
            left: 22,
            right: 22,
            bottom: 18,
            child: BottomNavigationWidget(),
          ),
        ],
      ),
    );
  }
}

