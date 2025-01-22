import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:writing_app/utils/global_text.dart';

class GlobalThemeData {
  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData themeData(
    ColorScheme colorScheme,
    Color focusColor,
    BuildContext context,
    bool isMobile, // Add the isMobile parameter
  ) {
    return ThemeData(
      colorScheme: colorScheme,
      canvasColor: colorScheme.surface,
      scaffoldBackgroundColor: colorScheme.surface,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      textTheme: TextTheme(
        titleLarge: GlobalTextStyles.titleLarge(colorScheme, isMobile),
        titleMedium: GlobalTextStyles.titleMedium(colorScheme, isMobile),
        bodyMedium: GlobalTextStyles.bodyMedium(colorScheme, isMobile),
        labelMedium: GlobalTextStyles.labelMedium(colorScheme, isMobile),
        labelSmall: GlobalTextStyles.labelSmall(colorScheme, isMobile),
        labelLarge: GlobalTextStyles.labelLarge(colorScheme, isMobile),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.secondary,
          textStyle: GlobalTextStyles.labelMedium(
              colorScheme, isMobile), // Example for button text
        ),
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: colorScheme.tertiary,
              textStyle: GlobalTextStyles.labelMedium(colorScheme, isMobile))),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.secondary,
        foregroundColor: colorScheme.surface,
      ),
    );
  }

  static ThemeData lightThemeData(BuildContext context, bool isMobile) =>
      themeData(lightColorScheme, _lightFocusColor, context, isMobile);
  static ThemeData darkThemeData(BuildContext context, bool isMobile) =>
      themeData(darkColorScheme, _darkFocusColor, context, isMobile);

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFFF4F4F4),
    onPrimary: Color(0xFF07182B),
    secondary: Color(0xFFA7A3EB),
    secondaryContainer: Color(0xFFE9E8FA),
    onSecondary: Color(0xFF827FC0),
    tertiary: Color(0xFFAF8A05),
    error: Colors.redAccent,
    onError: Colors.white,
    surface: Color(0xFFFEFEFE),
    primaryContainer: Color(0xEAEAEAEA),
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
