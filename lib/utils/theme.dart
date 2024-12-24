import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlobalThemeData {
  static final Color _lightFocusColor = Colors.black.withValues(alpha: 0.12);
  static final Color _darkFocusColor = Colors.white.withValues(alpha: 0.12);
  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      canvasColor: colorScheme.surface,
      scaffoldBackgroundColor: colorScheme.surface,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      textTheme: TextTheme(
        // Big Title
        displayLarge: GoogleFonts.workSans(
          fontSize: 64,
          fontWeight: FontWeight.bold,
          color: colorScheme.onPrimary,
          letterSpacing: -1,
        ),

        // Dashboard Title
        titleLarge: GoogleFonts.workSans(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: colorScheme.onPrimary,
        ),

        // Body Text
        bodyMedium: GoogleFonts.workSans(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: colorScheme.onPrimary,
          letterSpacing: 0.02,
        ),

        // Semi-Bold Text
        labelMedium: GoogleFonts.workSans(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: colorScheme.onPrimary,
          letterSpacing: -0.02,
        ),

        labelSmall: GoogleFonts.workSans(
          fontSize: 16,
          fontWeight: FontWeight.w300,
          color: colorScheme.onSecondary,
          letterSpacing: 0.5,
        ),

        // Light Text
        bodySmall: GoogleFonts.workSans(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: colorScheme.onPrimary,
          letterSpacing: 2,
        ),
        displayMedium: GoogleFonts.workSans(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: colorScheme.onPrimary,
          letterSpacing: 0,
        ),
        displaySmall: GoogleFonts.workSans(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSecondary,
          letterSpacing: 0,
        ),

        // Bolded Text
        labelLarge: GoogleFonts.workSans(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: colorScheme.onPrimary,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);

  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFFF4F4F4),
    onPrimary: Color(0xFF07182B),
    secondary: Color(0xFFA7A3EB),
    onSecondary: Color.fromARGB(255, 130, 127, 192),
    error: Colors.redAccent,
    onError: Colors.white,
    surface: Color(0xFFFEFEFE),
    tertiary: Color(0xEAEAEAEA),
    onSurface: Color(0xFF07182B),
    brightness: Brightness.light,
  );
  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFFEFB11D),
    onPrimary: Colors.white,
    secondary: Color(0xFFA7A3EB),
    onSecondary: Colors.white,
    error: Colors.redAccent,
    onError: Colors.white,
    surface: Color(0xFF241E30),
    onSurface: Colors.white,
    brightness: Brightness.dark,
  );
}
