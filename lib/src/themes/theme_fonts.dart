import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum FontFamily { roboto, lato, openSans, montserrat, poppins }

class ThemeFonts {
  static final Map<FontFamily, TextTheme> _textThemes = {
    FontFamily.roboto: GoogleFonts.robotoTextTheme(),
    FontFamily.lato: GoogleFonts.latoTextTheme(),
    FontFamily.openSans: GoogleFonts.openSansTextTheme(),
    FontFamily.montserrat: GoogleFonts.montserratTextTheme(),
    FontFamily.poppins: GoogleFonts.poppinsTextTheme(),
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
