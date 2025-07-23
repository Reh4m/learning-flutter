import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning_flutter/src/themes/dark_theme.dart';
import 'package:learning_flutter/src/themes/light_theme.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: LightTheme.primaryColor,
    primaryColorLight: LightTheme.primaryColorLight,
    scaffoldBackgroundColor: LightTheme.backgroundColor,
    colorScheme: const ColorScheme.light(
      primary: LightTheme.primaryColor,
      secondary: LightTheme.primaryColorLight,
      surface: LightTheme.greyLighten2,
      error: LightTheme.error,
      onPrimary: LightTheme.onPrimaryColor,
      onSecondary: LightTheme.onPrimaryColor,
      onSurface: LightTheme.textPrimary,
      onError: LightTheme.onPrimaryColor,
    ),
    textTheme: GoogleFonts.robotoTextTheme(),
    cardColor: LightTheme.cardBackgroundColor,
    // Text Form Input
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: LightTheme.greyLighten2,
      labelStyle: const TextStyle(color: LightTheme.textSecondary),
      border: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: DarkTheme.primaryColor,
    primaryColorLight: DarkTheme.primaryColorLight,
    scaffoldBackgroundColor: DarkTheme.backgroundColor,
    colorScheme: const ColorScheme.dark(
      primary: DarkTheme.primaryColor,
      secondary: DarkTheme.primaryColorLight,
      surface: DarkTheme.cardBackgroundColor,
      error: DarkTheme.error,
      onPrimary: DarkTheme.onPrimaryColor,
      onSecondary: DarkTheme.onPrimaryColor,
      onSurface: DarkTheme.textPrimary,
      onError: DarkTheme.onPrimaryColor,
    ),
    textTheme: GoogleFonts.robotoTextTheme(),
    cardColor: DarkTheme.cardBackgroundColor,
    // Text Form Input
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: DarkTheme.cardBackgroundColor,
      labelStyle: const TextStyle(color: DarkTheme.textSecondary),
      border: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}
