import 'package:flutter/material.dart';
import 'package:writing_app/utils/global_text.dart';

class GlobalThemeData {
  static final Color _lightFocusColor = Colors.black.withValues(alpha: 0.12);
  static final Color _darkFocusColor = Colors.white.withValues(alpha: 0.12);

  static ThemeData themeData(
    ColorScheme colorScheme,
    Color focusColor,
    BuildContext context,
    bool isMobile,
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
        titleSmall: GlobalTextStyles.titleSmall(colorScheme, isMobile),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.secondary,
          textStyle: GlobalTextStyles.labelLarge(
            colorScheme,
            isMobile,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.surface,
          textStyle: GlobalTextStyles.labelLarge(colorScheme, isMobile),
        ),
      ),
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
    tertiary: Color.fromARGB(255, 107, 203, 197),
    error: Colors.redAccent,
    onError: Colors.white,
    surface: Color(0xFFFEFEFE),
    primaryContainer: Color(0xEAEAEAEA),
    onSurface: Color(0xFF07182B),
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFF1A1A1A),
    onPrimary: Color(0xFFF4F4F4),
    secondary: Color(0xFF7A77D9),
    secondaryContainer: Color(0xFF2E2B59),
    onSecondary: Color(0xFFC3C0FF),
    tertiary: Color(0xFF5FC0BB),
    error: Colors.redAccent,
    onError: Colors.black,
    surface: Color.fromARGB(255, 36, 36, 36),
    primaryContainer: Color(0xFF242424),
    onSurface: Color(0xFFE0E0E0),
    brightness: Brightness.dark,
  );
}
