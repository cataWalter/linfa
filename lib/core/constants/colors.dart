import 'package:flutter/material.dart';

/// Linfa Color Palette
/// A nature-inspired color palette for the plant care app
class LinfaColors {
  LinfaColors._();

  // Primary - Fresh Green
  static const Color primary = Color(0xFF4CAF50);
  static const Color primaryLight = Color(0xFF81C784);
  static const Color primaryDark = Color(0xFF388E3C);

  // Secondary - Earth Brown
  static const Color secondary = Color(0xFF8D6E63);
  static const Color secondaryLight = Color(0xFFBCAAA4);
  static const Color secondaryDark = Color(0xFF5D4037);

  // Accent - Sky Blue
  static const Color accent = Color(0xFF4FC3F7);
  static const Color accentLight = Color(0xFF81D4FA);
  static const Color accentDark = Color(0xFF0288D1);

  // Status Colors
  static const Color healthy = Color(0xFF66BB6A);
  static const Color warning = Color(0xFFFFA726);
  static const Color danger = Color(0xFFEF5350);
  static const Color dormant = Color(0xFFBDBDBD);

  // Background Colors
  static const Color backgroundLight = Color(0xFFFAFAFA);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);

  // Text Colors
  static const Color textPrimaryLight = Color(0xFF212121);
  static const Color textSecondaryLight = Color(0xFF757575);
  static const Color textPrimaryDark = Color(0xFFFAFAFA);
  static const Color textSecondaryDark = Color(0xFFBDBDBD);

  // Reminder Type Colors
  static const Color watering = Color(0xFF42A5F5);
  static const Color fertilizing = Color(0xFFAB47BC);
  static const Color repotting = Color(0xFF66BB6A);
  static const Color cleaning = Color(0xFF26C6DA);
  static const Color pruning = Color(0xFFEF5350);
  static const Color misting = Color(0xFF29B6F6);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryLight, primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFFA8E063), Color(0xFF56AB2F)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
