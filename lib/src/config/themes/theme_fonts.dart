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

  static TextTheme getTextTheme(FontFamily fontFamily) {
    return _textThemes[fontFamily]!;
  }
}
