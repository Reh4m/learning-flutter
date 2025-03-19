import 'package:flutter/material.dart';
import 'package:learning_flutter/src/themes/light_theme.dart';

class AppTheme {
  const AppTheme();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: LightTheme.primaryColor,
    scaffoldBackgroundColor: LightTheme.backgroundColor,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: LightTheme.primaryColor,
      secondary: LightTheme.primaryColorLight,
      surface: LightTheme.backgroundColor,
      error: LightTheme.error,
      onPrimary: LightTheme.onPrimaryColor,
      onSecondary: LightTheme.onPrimaryColor,
      onSurface: LightTheme.textPrimary,
      onError: LightTheme.onPrimaryColor,
    ),
    cardColor: LightTheme.cardBackgroundColor,
    // Text Form Input
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: LightTheme.greyLighten2,
      labelStyle: TextStyle(color: LightTheme.textSecondary),
      border: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}
