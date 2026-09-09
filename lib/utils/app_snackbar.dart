import 'package:flutter/material.dart';

class AppSnackBar {
  AppSnackBar._();

  static void showError(BuildContext context, String message) {
    _show(context, message: message, backgroundColor: Colors.redAccent);
  }

  static void showSuccess(BuildContext context, String message) {
    _show(context, message: message, backgroundColor: const Color(0xFF00A84F));
  }

  static void _show(
    BuildContext context, {
    required String message,
    required Color backgroundColor,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: backgroundColor,
          behavior: SnackBarBehavior.floating,
          content: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
  }
}
