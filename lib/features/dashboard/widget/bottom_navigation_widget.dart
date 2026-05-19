import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sale_pipeline_business/utils/app_colors.dart';
import 'package:sale_pipeline_business/utils/images.dart';

import '../../../routing/go_router/go_router_delegate.dart';
import '../controller/dashboard_controller.dart';
import '../presentation/dashboard_page.dart';

class BottomNavigationWidget extends ConsumerWidget {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(dashboardControllerProvider);

    return Container(
      height: 70,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
      padding: const EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
        color: kCardColor,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: Colors.white.withOpacity(0.18),
        ),
      ),
      child: Row(
        children: [
          _NavItem(
            index: 0,
            currentIndex: position,
            iconName: kHomeImage,
            activeIconName: kActiveHomeImage,
            label: 'Dashboard',
            onTap: () => _onTap(context, ref, 0),
          ),
          _NavItem(
            index: 1,
            currentIndex: position,
            iconName: kLeadsImage,
            activeIconName: kActiveLeadsImage,
            label: 'Leads',
            onTap: () => _onTap(context, ref, 1),
          ),
          _NavItem(
            index: 2,
            currentIndex: position,
            iconName: kContractsImage,
            activeIconName: kActiveContractsImage,
            label: 'Contracts',
            onTap: () => _onTap(context, ref, 2),
          ),
          _NavItem(
            index: 3,
            currentIndex: position,
            iconName: kTargetIconImage,
            activeIconName: kActiveTargetIconImage,
            label: 'Target',
            onTap: () => _onTap(context, ref, 3),
          ),
          _NavItem(
            index: 4,
            currentIndex: position,
            iconName: kLogoutImage,
            activeIconName: kLogoutImage,
            label: 'Log Out',
            onTap: () => _onTap(context, ref, 4),
          ),
        ],
      ),
    );
  }

  void _onTap(BuildContext context, WidgetRef ref, int index) {
    ref.read(dashboardControllerProvider.notifier).setPosition(index);

    DashboardPage.pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );

    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go(RoutePath.leads.path);
        break;
      case 2:
        context.go(RoutePath.contracts.path);
        break;
      case 3:
        context.go(RoutePath.target.path);
        break;
      case 4:
        context.go(RoutePath.logout.path);
        break;
    }
  }
}

class _NavItem extends StatelessWidget {
  final int index;
  final int currentIndex;
  final String iconName;
  final String activeIconName;
  final String label;
  final VoidCallback onTap;

  const _NavItem({
    required this.index,
    required this.currentIndex,
    required this.iconName,
    required this.activeIconName,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = index == currentIndex;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected ? kPrimaryColor.withOpacity(0.4) : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             isSelected ? Image.asset(
                activeIconName,
                height: 18,
              ) : Image.asset(
               iconName,
               height: 18,
             ),
              const SizedBox(height: 2),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isSelected ? 10 : 8,
                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}