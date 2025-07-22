import 'package:flutter/material.dart';
import 'package:learning_flutter/src/themes/dark_theme.dart';
import 'package:learning_flutter/src/themes/light_theme.dart';
import 'package:learning_flutter/src/themes/theme_fonts.dart';

class AppTheme {
  const AppTheme();

  static ThemeData generateLightTheme(FontFamily fontFamily) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: LightTheme.primaryColor,
      primaryColorLight: DarkTheme.primaryColorLight,
      scaffoldBackgroundColor: LightTheme.backgroundColor,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: LightTheme.primaryColor,
        secondary: LightTheme.primaryColorLight,
        surface: LightTheme.greyLighten2,
        error: LightTheme.error,
        onPrimary: LightTheme.onPrimaryColor,
        onSecondary: LightTheme.onPrimaryColor,
        onSurface: LightTheme.textPrimary,
        onError: LightTheme.onPrimaryColor,
      ),
      textTheme: ThemeFonts.getTextTheme(fontFamily, Brightness.light),
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

  static ThemeData generateDarkTheme(FontFamily fontFamily) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: DarkTheme.primaryColor,
      primaryColorLight: DarkTheme.primaryColorLight,
      scaffoldBackgroundColor: DarkTheme.backgroundColor,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: DarkTheme.primaryColor,
        secondary: DarkTheme.primaryColorLight,
        surface: DarkTheme.cardBackgroundColor,
        error: DarkTheme.error,
        onPrimary: DarkTheme.onPrimaryColor,
        onSecondary: DarkTheme.onPrimaryColor,
        onSurface: DarkTheme.textPrimary,
        onError: DarkTheme.onPrimaryColor,
      ),
      textTheme: ThemeFonts.getTextTheme(fontFamily, Brightness.dark),
      cardColor: DarkTheme.cardBackgroundColor,
      // Text Form Input
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: DarkTheme.cardBackgroundColor,
        labelStyle: TextStyle(color: DarkTheme.textSecondary),
        border: UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
