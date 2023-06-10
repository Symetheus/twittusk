import 'package:flutter/material.dart';
import 'package:twittusk/theme/colors.dart';
import 'package:twittusk/theme/dimens.dart';

const String defaultPolice = 'Avenir';

final CustomColors _darkColors = CustomColors.dark();

class AppTheme {
  static final ThemeData darkThemeData = _buildTheme(
    baseTheme: ThemeData.dark().copyWith(useMaterial3: false),
    textTheme: _buildTextTheme(
      textColor: _darkColors.onSurface,
      subtitleTextColor: _darkColors.textSecondary,
    ),
    customColors: _darkColors,
  );

  static ThemeData _buildTheme({
    required ThemeData baseTheme,
    required TextTheme textTheme,
    required CustomColors customColors,
  }) {
    final textTheme = _buildTextTheme(
      textColor: _darkColors.onSurface,
      subtitleTextColor: Colors.grey,
    );

    return ThemeData(
      textTheme: textTheme,
      primaryTextTheme: _buildTextTheme(
        textColor: customColors.primary,
        subtitleTextColor: customColors.primary,
      ),
      fontFamily: defaultPolice,
      primaryColor: customColors.primary,
      colorScheme: ColorScheme(
        primary: customColors.primary,
        secondary: customColors.secondary,
        surface: customColors.surface,
        background: customColors.background,
        error: customColors.error,
        onError: customColors.error,
        onPrimary: customColors.onPrimary,
        onSecondary: Colors.blue,
        onSurface: customColors.onSurface,
        onBackground: customColors.onBackground,
        brightness: baseTheme.brightness,
      ),
      iconTheme: baseTheme.iconTheme.copyWith(color: customColors.onPrimary),
      scaffoldBackgroundColor: customColors.background,
      buttonTheme: baseTheme.buttonTheme.copyWith(
        buttonColor: customColors.surface,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        textTheme: ButtonTextTheme.primary,
      ),
      inputDecorationTheme: baseTheme.inputDecorationTheme.copyWith(
          contentPadding: const EdgeInsets.all(16),
          labelStyle: TextStyle(fontSize: 13, color: customColors.textSecondary, fontFamily: defaultPolice),
          prefixStyle: TextStyle(fontSize: 13, color: customColors.textSecondary, fontFamily: defaultPolice),
          errorStyle: TextStyle(fontSize: 13, color: customColors.error, fontFamily: defaultPolice),
          errorMaxLines: 3,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: customColors.textSecondary),
            borderRadius: const BorderRadius.all(Radius.circular(Dimens.standardPadding)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: customColors.textSecondary),
            borderRadius: const BorderRadius.all(Radius.circular(Dimens.standardPadding)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: customColors.error),
            borderRadius: const BorderRadius.all(Radius.circular(Dimens.standardPadding)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: customColors.error, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(Dimens.standardPadding)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: customColors.primary, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(Dimens.standardPadding)),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: customColors.background),
            borderRadius: const BorderRadius.all(Radius.circular(Dimens.standardPadding)),
          )),
      snackBarTheme: SnackBarThemeData(
        actionTextColor: customColors.secondary,
      ),
    );
  }
}

TextTheme _buildTextTheme({required Color textColor, required Color subtitleTextColor}) {
  return TextTheme(
    titleMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: Dimens.subtitleTextSize,
      height: Dimens.subtitleLineHeight,
      color: textColor,
      fontFamily: defaultPolice,
    ),
    displayMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: Dimens.hugeTextSize,
      height: Dimens.hugeLineHeight,
      color: textColor,
      fontFamily: defaultPolice,
    ),
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: Dimens.largeTextSize,
      height: Dimens.largeLineHeight,
      color: textColor,
      fontFamily: defaultPolice,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: Dimens.standardTextSize,
      height: Dimens.standardLineHeight,
      color: textColor,
      fontFamily: defaultPolice,
    ),
  );
}

extension CustomTheme on ThemeData {
  bool get isThemeDark => brightness == Brightness.dark;
  bool get isThemeLight => brightness == Brightness.light;

  CustomColors get customColors => _darkColors;
}