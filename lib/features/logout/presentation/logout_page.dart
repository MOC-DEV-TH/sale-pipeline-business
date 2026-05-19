import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sale_pipeline_business/utils/images.dart';

import '../../../utils/secure_storage.dart';
import '../../../utils/strings.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../../dashboard/presentation/dashboard_page.dart';

class LogoutPage extends ConsumerWidget {
  const LogoutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 80, 22, 110),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(22, 8, 22, 24),
            decoration: BoxDecoration(
              color: const Color(0xFF0B3A22).withOpacity(0.92),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: const Color(0xFF178D4E).withOpacity(0.55),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),

                const SizedBox(height: 36),

                SizedBox(
                  width: 220,
                  height: 220,
                  child: Image.asset(
                    kLogoutIllustrationImage,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 18),

                const Text(
                  'Logging Out',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  'Are you sure you want to log out?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.55),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 26),

                Row(
                  children: [
                    Expanded(
                      child: _LogoutButton(
                        text: 'No, Cancel',
                        color: const Color(0xFF0F5C35),
                        onTap: () {
                          ref
                              .read(dashboardControllerProvider.notifier)
                              .setPosition(0);
                          DashboardPage.pageController.animateToPage(
                            0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: _LogoutButton(
                        text: 'Yes, Log me Out',
                        color: const Color(0xFF09B957),
                        onTap: () async {
                          await ref
                              .read(secureStorageProvider)
                              .saveAuthStatus(kAuthNotLoggedIn);

                          ref.invalidate(dashboardControllerProvider);
                          ref.invalidate(secureStorageProvider);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onTap;

  const _LogoutButton({
    required this.text,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        child: Text(
          text,
          maxLines: 1,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
