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

  static TextTheme getTextTheme(FontFamily fontFamily, Brightness themeMode) {
    final baseTextTheme = _textThemes[fontFamily]!;

    return baseTextTheme.apply(
      displayColor: themeMode == Brightness.light ? Colors.black : Colors.white,
      bodyColor: themeMode == Brightness.light ? Colors.black : Colors.white,
    );
  }

  static TextTheme get roboto => _textThemes[FontFamily.roboto]!;
  static TextTheme get lato => _textThemes[FontFamily.lato]!;
  static TextTheme get openSans => _textThemes[FontFamily.openSans]!;
  static TextTheme get montserrat => _textThemes[FontFamily.montserrat]!;
  static TextTheme get poppins => _textThemes[FontFamily.poppins]!;
}
