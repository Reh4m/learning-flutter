import 'package:flutter/material.dart';

enum ThemeColor {
  defaultTheme,
  sunsetOrange,
  emeraldGreen,
  royalPurple,
  goldenYellow,
  midnight,
}

class CustomTheme {
  final Color primaryColor;
  final Color primaryColorLight;

  const CustomTheme({
    required this.primaryColor,
    required this.primaryColorLight,
  });
}

class ThemeManager {
  static final Map<ThemeColor, CustomTheme> _themeColors = {
    // Default theme
    ThemeColor.defaultTheme: const CustomTheme(
      primaryColor: Color(0xFF007AAD),
      primaryColorLight: Color(0xFFD9E2E9),
    ),
    // Sunset Orange theme
    ThemeColor.sunsetOrange: const CustomTheme(
      primaryColor: Color(0xFFFF5733),
      primaryColorLight: Color(0xFFFFE1D8),
    ),
    // Emerald Green theme
    ThemeColor.emeraldGreen: const CustomTheme(
      primaryColor: Color(0xFF2ECC71),
      primaryColorLight: Color(0xFFDDF6E3),
    ),
    // Royal Purple theme
    ThemeColor.royalPurple: const CustomTheme(
      primaryColor: Color(0xFF6C5CE7),
      primaryColorLight: Color(0xFFDEE0FD),
    ),
    // Golden Yellow theme
    ThemeColor.goldenYellow: const CustomTheme(
      primaryColor: Color(0xFFFFC300),
      primaryColorLight: Color(0xFFFFF4DB),
    ),
    // Midnight theme
    ThemeColor.midnight: const CustomTheme(
      primaryColor: Color(0xFF212529),
      primaryColorLight: Color(0xFFCDCED0),
    ),
  };

  /// Devuelve el ThemeData correspondiente al tema seleccionado
  static ThemeData getTheme(ThemeColor themeColor) {
    final colors = _themeColors[themeColor]!;

    return ThemeData(
      primaryColor: colors.primaryColor,
      primaryColorLight: colors.primaryColorLight,
    );
  }

  /// Getters para los temas
  static ThemeData get defaultTheme => getTheme(ThemeColor.defaultTheme);
  static ThemeData get sunsetOrangeTheme => getTheme(ThemeColor.sunsetOrange);
  static ThemeData get emeraldGreenTheme => getTheme(ThemeColor.emeraldGreen);
  static ThemeData get royalPurpleTheme => getTheme(ThemeColor.royalPurple);
  static ThemeData get goldenYellowTheme => getTheme(ThemeColor.goldenYellow);
  static ThemeData get midnightTheme => getTheme(ThemeColor.midnight);
}
