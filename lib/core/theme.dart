import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

typedef TextThemeBuilder = TextTheme Function([TextTheme? textTheme]);

class CustomTheme {
  static const Color primaryColor = Colors.brown;
  static const Color secondaryColor = Color(0xFF03DAC6);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color textColorLight = Color(0xFF000000);
  static const Color textColorDark = Color(0xFFFFFFFF);
  static const Color surfaceColorDark = Color(0xFF121212);

  static final TextTheme textTheme = GoogleFonts.spaceGroteskTextTheme();
  static final TextTheme arabicTextTheme = GoogleFonts.rakkasTextTheme();
  static final double arabicLineHeight = 1.9;

  static ThemeData lightTheme() {
    return ThemeData(
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: backgroundColor,
        onSurface: textColorLight,
      ),
      scaffoldBackgroundColor: backgroundColor,
      textTheme: textTheme.copyWith(
        bodyLarge: textTheme.bodyLarge?.copyWith(color: textColorLight),
        bodyMedium: textTheme.bodyMedium?.copyWith(color: textColorLight),
        bodySmall: textTheme.bodySmall?.copyWith(color: textColorLight),
        displayLarge: textTheme.displayLarge?.copyWith(color: textColorLight),
        displayMedium: textTheme.displayMedium?.copyWith(color: textColorLight),
        displaySmall: textTheme.displaySmall?.copyWith(color: textColorLight),
        headlineLarge: textTheme.headlineLarge?.copyWith(color: textColorLight),
        headlineMedium: textTheme.headlineMedium?.copyWith(color: textColorLight),
        headlineSmall: textTheme.headlineSmall?.copyWith(color: textColorLight),
        titleLarge: textTheme.titleLarge?.copyWith(color: textColorLight),
        titleMedium: textTheme.titleMedium?.copyWith(color: textColorLight),
        titleSmall: arabicTextTheme.titleSmall?.copyWith(color: textColorLight, height: arabicLineHeight),
      ),
      // (
      //   ThemeData.light().textTheme,
      // )
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      colorScheme: ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColorDark,
        onSurface: textColorDark,
      ),
      scaffoldBackgroundColor: surfaceColorDark,
      textTheme: textTheme.copyWith(
        bodyLarge: textTheme.bodyLarge?.copyWith(color: textColorDark),
        bodyMedium: textTheme.bodyMedium?.copyWith(color: textColorDark),
        bodySmall: textTheme.bodySmall?.copyWith(color: textColorDark),
        displayLarge: textTheme.displayLarge?.copyWith(color: textColorDark),
        displayMedium: textTheme.displayMedium?.copyWith(color: textColorDark),
        displaySmall: textTheme.displaySmall?.copyWith(color: textColorDark),
        headlineLarge: textTheme.headlineLarge?.copyWith(color: textColorDark),
        headlineMedium: textTheme.headlineMedium?.copyWith(color: textColorDark),
        headlineSmall: textTheme.headlineSmall?.copyWith(color: textColorDark),
        titleLarge: textTheme.titleLarge?.copyWith(color: textColorDark),
        titleMedium: textTheme.titleMedium?.copyWith(color: textColorDark),
        titleSmall: arabicTextTheme.titleSmall?.copyWith(color: textColorDark, height: arabicLineHeight),
      ),
      // (
      //   ThemeData.dark().textTheme,
      // ),
    );
  }
}