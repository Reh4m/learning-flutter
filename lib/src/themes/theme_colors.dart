import 'package:flutter/material.dart';

enum ThemeColor {
  defaultTheme,
  sunsetOrange,
  emeraldGreen,
  royalPurple,
  goldenYellow,
  midnightDark,
}

class CustomTheme {
  final Color primaryColor;
  final Color primaryColorLight;

  const CustomTheme({
    required this.primaryColor,
    required this.primaryColorLight,
  });
}

// App theme colors available for the app
class ThemeColors {
  static const Map<ThemeColor, CustomTheme> _themeColors = {
    // Default theme
    ThemeColor.defaultTheme: CustomTheme(
      primaryColor: Color(0xFF007AAD),
      primaryColorLight: Color(0xFFBDD7E7),
    ),
    // Sunset Orange theme
    ThemeColor.sunsetOrange: CustomTheme(
      primaryColor: Color(0xFFFF5733),
      primaryColorLight: Color(0xFFFFE1D8),
    ),
    // Emerald Green theme
    ThemeColor.emeraldGreen: CustomTheme(
      primaryColor: Color(0xFF2ECC71),
      primaryColorLight: Color(0xFFDDF6E3),
    ),
    // Royal Purple theme
    ThemeColor.royalPurple: CustomTheme(
      primaryColor: Color(0xFF6C5CE7),
      primaryColorLight: Color(0xFFDEE0FD),
    ),
    // Golden Yellow theme
    ThemeColor.goldenYellow: CustomTheme(
      primaryColor: Color(0xFFFFC300),
      primaryColorLight: Color(0xFFFFF4DB),
    ),
    // Midnight theme
    ThemeColor.midnightDark: CustomTheme(
      primaryColor: Color(0xFF212529),
      primaryColorLight: Color(0xFFCDCED0),
    ),
  };

  // Get the ThemeData corresponding to the selected theme
  static CustomTheme getCustomTheme(ThemeColor themeColor) {
    return _themeColors[themeColor]!;
  }

  static CustomTheme get defaultTheme =>
      getCustomTheme(ThemeColor.defaultTheme);
  static CustomTheme get sunsetOrangeTheme =>
      getCustomTheme(ThemeColor.sunsetOrange);
  static CustomTheme get emeraldGreenTheme =>
      getCustomTheme(ThemeColor.emeraldGreen);
  static CustomTheme get royalPurpleTheme =>
      getCustomTheme(ThemeColor.royalPurple);
  static CustomTheme get goldenYellowTheme =>
      getCustomTheme(ThemeColor.goldenYellow);
  static CustomTheme get midnightTheme =>
      getCustomTheme(ThemeColor.midnightDark);
}
