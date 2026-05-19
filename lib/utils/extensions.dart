import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:dio/dio.dart';

extension SnackBarExtensions on BuildContext {
  void showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green[700],
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

extension DialogExtensions on BuildContext {
  void showErrorDialog(String message, String title) {
    showDialog(
      context: this,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

extension NavigationX on BuildContext {
  Future<T?> nextPage<T>(Widget page) {
    return Navigator.push<T>(
      this,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  void popPage<T extends Object?>([T? result]) {
    Navigator.pop(this, result);
  }
}

extension DateTimeX on DateTime {
  // -------- Weekday --------
  String get weekdayName {
    switch (weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return '';
    }
  }

  /// -------- Month --------
  String get monthName {
    const months = [
      'January','February','March','April','May','June',
      'July','August','September','October','November','December',
    ];
    return months[month - 1];
  }

  String get monthYear => '$monthName $year';

  /// -------- Calendar headers --------
  static const weekHeaders = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
}


extension GreetingExtension on DateTime {
  String get greeting {
    final hour = this.hour;

    if (hour >= 5 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon';
    } else if (hour >= 17 && hour < 21) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }
}

extension FormattedDateExtension on DateTime {
  /// Example: "Tuesday, Nov 17, 2025"
  String get formattedFullDate {
    final formatter = DateFormat('EEEE, MMM d, y');
    return formatter.format(this);
  }
}


extension FormattedTimeExtension on DateTime {
  /// Returns time in 12-hour format with AM/PM, e.g. "09:00 AM"
  String get time12h {
    return DateFormat('hh:mm a').format(this);
  }
}

extension StringCasingExtension on String {
  /// Capitalizes the first letter of the string
  String capitalizeFirstLetter() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}

extension ThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => theme.colorScheme;
  TextTheme get text => theme.textTheme;

  Color get primary => colors.primary;
  Color get onPrimary => colors.onPrimary;

  Color get secondary => colors.secondary;
  Color get onSecondary => colors.onSecondary;
}

extension NetworkErrorX on DioException {
  bool get isNetworkError {
    if (type == DioExceptionType.connectionTimeout ||
        type == DioExceptionType.receiveTimeout ||
        type == DioExceptionType.sendTimeout ||
        type == DioExceptionType.connectionError) {
      return true;
    }

    if (type == DioExceptionType.unknown && error is SocketException) {
      return true;
    }

    return false;
  }
}


