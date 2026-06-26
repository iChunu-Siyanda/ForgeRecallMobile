import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:forge_recall/core/theme/app_colours.dart';

class AppTypography {
  static TextStyle headlineLarge =
      GoogleFonts.spaceGrotesk(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    color: AppColours.textPrimary,
  );

  static TextStyle headlineMedium =
      GoogleFonts.spaceGrotesk(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColours.textPrimary,
  );

  static TextStyle title =
      GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColours.textPrimary,
  );

  static TextStyle body =
      GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColours.textSecondary,
  );

  static TextStyle caption =
      GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColours.textMuted,
  );

  static TextStyle data =
      GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
    color: AppColours.textPrimary,
  );
}
