import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColours.obsidian,
    primaryColor: AppColours.electricBlue,
    useMaterial3: true,

    colorScheme: const ColorScheme.dark(
      primary: AppColours.electricBlue,
      secondary: AppColours.emberOrange,
      surface: AppColours.graphite,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );
}