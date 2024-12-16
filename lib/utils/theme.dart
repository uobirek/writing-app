import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color accentcolour1 = Color(0xFFEFB11D);
  static const Color accentcolour2 = Color(0xFFA7A3EB);
  static const Color background = Color(0xFFFCFCFC);
  static const Color verylight = Color(0xFFFEFEFE);
  static const Color text = Color(0xFF07182B);
  static const Color bigsquaregrey = Color(0xFFF4F4F4);
  static const Color darkergrey = Color(0xFFEAEAEA);
}

class AppTextStyles {
  static final TextStyle bigTitle = GoogleFonts.workSans(
      fontSize: 64,
      fontWeight: FontWeight.bold,
      color: AppColors.text,
      letterSpacing: -1);

  static final TextStyle dashboardTitle = GoogleFonts.workSans(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );

  static final TextStyle body = GoogleFonts.workSans(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: AppColors.text,
      letterSpacing: 2);

  static final TextStyle semibolded = GoogleFonts.workSans(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.text,
      letterSpacing: -0.02);

  static final TextStyle light = GoogleFonts.workSans(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: AppColors.text,
      letterSpacing: 2);

  static final TextStyle bolded = GoogleFonts.workSans(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColors.text,
      letterSpacing: -0.01);
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.accentcolour1,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: AppBarTheme(
      color: AppColors.bigsquaregrey,
      titleTextStyle: AppTextStyles.semibolded,
    ),
    textTheme: TextTheme(
        displayMedium: AppTextStyles.body,
        displayLarge: AppTextStyles.semibolded,
        titleLarge: AppTextStyles.bigTitle,
        titleMedium: AppTextStyles.dashboardTitle,
        labelMedium: AppTextStyles.light),
    cardColor: AppColors.verylight,
    dividerColor: AppColors.darkergrey,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accentcolour1, // Button background
        foregroundColor: AppColors.verylight, // Button text or icon color
      ),
    ),
  );
}
