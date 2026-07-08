import 'package:flutter/material.dart';

import '../features/dashboard/controller/dashboard_controller.dart';
import '../main.dart';
import '../utils/secure_storage.dart';
import '../utils/strings.dart';

class AppUtils {
  static bool _isSessionDialogShowing = false;

  static Future<void> showSessionExpireDialog({
    required BuildContext context,
  }) async {
    if (_isSessionDialogShowing) return;

    _isSessionDialogShowing = true;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            title: Row(
              children: const [
                Icon(
                  Icons.lock_outline_rounded,
                  color: Colors.red,
                ),
                SizedBox(width: 8),
                Text('Session Expired'),
              ],
            ),
            content: const Text(
              'Your account has been logged in on another device.\nPlease login again to continue.',
              textAlign: TextAlign.center,
            ),
            actions: [
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF0B7A3E),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    await container
                        .read(secureStorageProvider)
                        .saveAuthStatus(kAuthNotLoggedIn);

                    await container
                        .read(secureStorageProvider)
                        .saveAuthToken('');

                    container.invalidate(dashboardControllerProvider);
                    container.invalidate(secureStorageProvider);

                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text(
                    'Login Again',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    _isSessionDialogShowing = false;
  }
}