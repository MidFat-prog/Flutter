import 'package:flutter/material.dart';

/// Central color palette — pink & cute, but kept professional with a
/// deeper rose as the primary (not neon) and neutral text/grey tones
/// doing the heavy lifting everywhere else.
class AppColors {
  AppColors._();

  // Core brand pink
  static const Color primary = Color(0xFFD9548C); // rose pink — main buttons, AppBar, icons
  static const Color primaryDark = Color(0xFFB83E72); // pressed/emphasis states
  static const Color primaryLight = Color(0xFFF29CC0); // splash gradient end, soft accents

  // Soft tints for backgrounds/containers
  static const Color tint = Color(0xFFFCE9F1); // pale pink container fill
  static const Color tintBorder = Color(0xFFF6D3E4); // subtle pink border

  // Neutral text/surfaces (kept professional, not overly saturated)
  static const Color textDark = Color(0xFF2E2430);
  static const Color textGrey = Color(0xFF6E6470);
  static const Color surface = Colors.white;
  static const Color background = Colors.white;

  // Semantic (unchanged — keep financial/status colors legible)
  static const Color success = Color(0xFF2E9E5B);
  static const Color danger = Color(0xFFE05A6E);
}