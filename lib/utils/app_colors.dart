import 'package:flutter/material.dart';

/// Use Remote-Config–driven colors from your Theme (set via remoteThemesProvider).
extension AppColors on BuildContext {
  Color get kBackgroundColor => Theme.of(this).colorScheme.background;
  Color get kPrimaryColor    => Theme.of(this).colorScheme.primary;
  Color get kSecondaryColor  => Theme.of(this).colorScheme.secondary;
}

const Color kBackgroundColor = Colors.white;
const Color kPrimaryColor = Color(0xFF00AF4C);
const Color kSecondaryColor = Color(0xFF14532D);
const Color kBottomNavigationSelectedColor = Color(0XFF16B04C);
const Color kCardColor = Color(0XFF12351e);
