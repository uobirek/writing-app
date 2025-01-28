import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlobalTextStyles {
  static TextStyle titleLarge(ColorScheme colorScheme, bool isMobile) {
    return GoogleFonts.workSans(
      fontSize: isMobile ? 32 : 72, // Smaller on mobile
      fontWeight: FontWeight.w800,
      color: colorScheme.onPrimary,
    );
  }

  static TextStyle titleMedium(ColorScheme colorScheme, bool isMobile) {
    return GoogleFonts.workSans(
      fontSize: isMobile ? 24 : 32,
      fontWeight: FontWeight.w600,
      color: colorScheme.onPrimary,
    );
  }

  static TextStyle bodyMedium(ColorScheme colorScheme, bool isMobile) {
    return GoogleFonts.workSans(
      fontSize: isMobile ? 14 : 16,
      fontWeight: FontWeight.normal,
      color: colorScheme.onPrimary,
      letterSpacing: 0.02,
    );
  }

  static TextStyle labelMedium(ColorScheme colorScheme, bool isMobile) {
    return GoogleFonts.workSans(
      fontSize: isMobile ? 14 : 16,
      fontWeight: FontWeight.w500,
      color: colorScheme.onPrimary,
      letterSpacing: -0.02,
    );
  }

  static TextStyle labelSmall(ColorScheme colorScheme, bool isMobile) {
    return GoogleFonts.workSans(
      fontSize: isMobile ? 12 : 16,
      fontWeight: FontWeight.w300,
      color: colorScheme.onSecondary,
      letterSpacing: 0.5,
    );
  }

  static TextStyle labelLarge(ColorScheme colorScheme, bool isMobile) {
    return GoogleFonts.workSans(
      fontSize: isMobile ? 14 : 16,
      fontWeight: FontWeight.w600,
      color: colorScheme.onPrimary,
      letterSpacing: -0.01,
    );
  }

  static TextStyle titleSmall(ColorScheme colorScheme, bool isMobile) {
    return GoogleFonts.berkshireSwash(
      fontSize: isMobile ? 26 : 34,
      fontWeight: FontWeight.w600,
      color: colorScheme.secondary,
      letterSpacing: -0.01,
    );
  }
}
