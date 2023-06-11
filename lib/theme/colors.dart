import 'package:flutter/material.dart';

class CustomColors {
  CustomColors.dark({
    this.primary = CustomDarkColors.yellowPiou,
    this.secondary = CustomDarkColors.yelloPiouLight,
    this.surface = CustomDarkColors.discord,
    this.background = CustomDarkColors.almostBlack,
    this.onBackground = CustomDarkColors.white,
    this.onPrimary = CustomDarkColors.trueBlack,
    this.onSecondary = CustomDarkColors.white,
    this.onSurface = CustomDarkColors.white,
    this.error = CustomDarkColors.red,
    this.success = CustomDarkColors.greenSuccess,
    this.textSecondary = CustomDarkColors.greyDark,
    this.textSecondaryLight = CustomDarkColors.grey,
    this.disabled = CustomDarkColors.disabled,
    this.backgroundElevated = Colors.red, // TO Implement
  });

  final Color primary;
  final Color secondary;
  final Color surface;
  final Color background;
  final Color backgroundElevated;
  final Color error;
  final Color success;
  final Color onPrimary;
  final Color onSecondary;
  final Color onSurface;
  final Color onBackground;

  final Color textSecondary;
  final Color textSecondaryLight;
  final Color disabled;
}

class CustomDarkColors {
  static const Color yellowPiou = Color(0xFFFCF177);
  static const Color yelloPiouLight = Color(0xFFFFF9B5);
  static const Color red = Color(0xFFFF5072);
  static const Color greenSuccess = Color(0xFF6BDB64);
  static const Color grey = Color(0xFF9DA0A5);
  static const Color greyDark = Color(0xFF636160);
  static const Color white = Color(0xFFF3F3F4);
  static const Color whiteIceberg = Color(0xFFFFFFFF);
  static const Color almostBlack = Color(0xFF0F1112);
  static const Color trueBlack = Color(0xFF000000);
  static const Color discord = Color(0xFF212427);
  static const Color disabled = Color(0xFF90B2BA);
}