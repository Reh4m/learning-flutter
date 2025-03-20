import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeFonts {
  static final Map<String, TextTheme> _textThemes = {
    'Roboto': GoogleFonts.robotoTextTheme(),
    'Lato': GoogleFonts.latoTextTheme(),
    'Open Sans': GoogleFonts.openSansTextTheme(),
    'Montserrat': GoogleFonts.montserratTextTheme(),
    'Poppins': GoogleFonts.poppinsTextTheme(),
  };

  static TextTheme getTextTheme(String fontFamily, Brightness themeMode) {
    final baseTextTheme = _textThemes[fontFamily]!;

    return baseTextTheme.apply(
      displayColor: themeMode == Brightness.light ? Colors.black : Colors.white,
      bodyColor: themeMode == Brightness.light ? Colors.black : Colors.white,
    );
  }

  static TextTheme get roboto => _textThemes['Roboto']!;
  static TextTheme get lato => _textThemes['Lato']!;
  static TextTheme get openSans => _textThemes['Open Sans']!;
  static TextTheme get montserrat => _textThemes['Montserrat']!;
  static TextTheme get poppins => _textThemes['Poppins']!;
}
