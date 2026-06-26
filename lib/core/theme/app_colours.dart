import 'package:flutter/material.dart';

class AppColours {
  // Backgrounds (Inspired by Gemini's clean workspace)
  static const background = Color(0xFFF0F4F9);       // Crisp ice-blue/grey workspace background
  static const surface = Color(0xFFFFFFFF);          // Clean white for primary cards
  static const surfaceSecondary = Color(0xFFE9EEF6); // Soft tint for hover states & inputs

  // Gemini Signature Sparkle Gradient (The magic combination)
  static const geminiBlue = Color(0xFF4285F4);
  static const geminiPurple = Color(0xFF9B72CB);
  static const geminiPink = Color(0xFFD96570);

  // Core App Accents
  static const electricBlue = Color(0xFF1A73E8);
  static const violet = Color(0xFF7B61FF);

  // Status (Softer, modern tones)
  static const emerald = Color(0xFF1EA657);
  static const amber = Color(0xFFF9AB00);
  static const crimson = Color(0xFFD93025);

  // Text (Google Material standards)
  static const textPrimary = Color(0xFF1F1F1F);   // Deep off-black for readability
  static const textSecondary = Color(0xFF4A4A4A); // Mid-toned grey for secondary info
  static const textMuted = Color(0xFF757575);     // Soft subtext

  // Borders & Faint Dividers
  static const glassBorder = Color(0xFFE1E3E1);

  // Reusable Gemini Gradient
  static const List<Color> geminiGradientColors = [
    geminiBlue,
    geminiPurple,
    geminiPink,
  ];

  static const Gradient geminiGradient = LinearGradient(
    colors: geminiGradientColors,
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
