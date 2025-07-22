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
  final String colorName;
  final Color primaryColor;
  final Color primaryColorLight;

  const CustomTheme({
    required this.colorName,
    required this.primaryColor,
    required this.primaryColorLight,
  });
}

// App theme colors available for the app
class ThemeColors {
  static const Map<ThemeColor, CustomTheme> themeColors = {
    // Default theme
    ThemeColor.defaultTheme: CustomTheme(
      colorName: 'Default',
      primaryColor: Color(0xFF007AAD),
      primaryColorLight: Color(0xFFBDD7E7),
    ),
    // Sunset Orange theme
    ThemeColor.sunsetOrange: CustomTheme(
      colorName: 'Sunset Orange',
      primaryColor: Color(0xFFFF5733),
      primaryColorLight: Color(0xFFFFE1D8),
    ),
    // Emerald Green theme
    ThemeColor.emeraldGreen: CustomTheme(
      colorName: 'Emerald Green',
      primaryColor: Color(0xFF2ECC71),
      primaryColorLight: Color(0xFFDDF6E3),
    ),
    // Royal Purple theme
    ThemeColor.royalPurple: CustomTheme(
      colorName: 'Royal Purple',
      primaryColor: Color(0xFF6C5CE7),
      primaryColorLight: Color(0xFFDEE0FD),
    ),
    // Golden Yellow theme
    ThemeColor.goldenYellow: CustomTheme(
      colorName: 'Golden Yellow',
      primaryColor: Color(0xFFFFC300),
      primaryColorLight: Color(0xFFFFF4DB),
    ),
    // Midnight theme
    ThemeColor.midnightDark: CustomTheme(
      colorName: 'Midnight Dark',
      primaryColor: Color(0xFF212529),
      primaryColorLight: Color(0xFFCDCED0),
    ),
  };

  // Get the ThemeData corresponding to the selected theme
  static CustomTheme getCustomTheme(ThemeColor themeColor) {
    return themeColors[themeColor]!;
  }
}
