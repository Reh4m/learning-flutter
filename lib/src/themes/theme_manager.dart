import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning_flutter/src/themes/theme.dart';
import 'package:learning_flutter/src/utils/global_values.dart';

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
      primaryColorLight: Color(0xFFBDD7E7),
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

  // Devuelve el ThemeData correspondiente al tema seleccionado
  static CustomTheme getTheme(ThemeColor themeColor) {
    final colors = _themeColors[themeColor]!;

    return CustomTheme(
      primaryColor: colors.primaryColor,
      primaryColorLight: colors.primaryColorLight,
    );
  }

  static final Map<String, TextTheme> _textThemes = {
    'Roboto': GoogleFonts.robotoTextTheme(),
    'Lato': GoogleFonts.latoTextTheme(),
    'Open Sans': GoogleFonts.openSansTextTheme(),
    'Montserrat': GoogleFonts.montserratTextTheme(),
    'Poppins': GoogleFonts.poppinsTextTheme(),
  };

  static TextTheme getFontFamily(String fontFamily) {
    return _textThemes[fontFamily]!;
  }

  static ThemeData getLightTheme(CustomTheme customTheme) {
    return AppTheme.lightTheme.copyWith(
      primaryColor: customTheme.primaryColor,
      primaryColorLight: customTheme.primaryColorLight,
      colorScheme: AppTheme.lightTheme.colorScheme.copyWith(
        primary: customTheme.primaryColor,
        secondary: customTheme.primaryColorLight,
      ),
    );
  }

  static ThemeData getDarkTheme(CustomTheme customTheme) {
    return AppTheme.darkTheme.copyWith(
      primaryColor: customTheme.primaryColor,
      primaryColorLight: customTheme.primaryColorLight,
      colorScheme: AppTheme.darkTheme.colorScheme.copyWith(
        primary: customTheme.primaryColor,
        secondary: customTheme.primaryColorLight,
      ),
    );
  }

  static ThemeData getThemeInstance(
    CustomTheme customTheme,
    ColorMode themeMode,
  ) {
    return themeMode == ColorMode.dark
        ? getDarkTheme(customTheme)
        : getLightTheme(customTheme);
  }

  /// Getters para los temas
  static CustomTheme get defaultTheme => getTheme(ThemeColor.defaultTheme);
  static CustomTheme get sunsetOrangeTheme => getTheme(ThemeColor.sunsetOrange);
  static CustomTheme get emeraldGreenTheme => getTheme(ThemeColor.emeraldGreen);
  static CustomTheme get royalPurpleTheme => getTheme(ThemeColor.royalPurple);
  static CustomTheme get goldenYellowTheme => getTheme(ThemeColor.goldenYellow);
  static CustomTheme get midnightTheme => getTheme(ThemeColor.midnight);
}
