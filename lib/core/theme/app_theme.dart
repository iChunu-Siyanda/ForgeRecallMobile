import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    scaffoldBackgroundColor: AppColours.background,

    primaryColor: AppColours.electricBlue,

    colorScheme: const ColorScheme.dark(
      primary: AppColours.electricBlue,
      secondary: AppColours.violet,
      surface: AppColours.surface,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColours.textPrimary,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      foregroundColor: AppColours.textPrimary,
    ),

    cardTheme: CardThemeData(
      color: AppColours.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ),

    dividerTheme: const DividerThemeData(
      color: AppColours.surfaceSecondary,
      thickness: 1,
    ),

    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(
      backgroundColor: AppColours.electricBlue,
      foregroundColor: Colors.white,
    ),
  );
}
