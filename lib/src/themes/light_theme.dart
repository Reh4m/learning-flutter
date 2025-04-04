// Flutter custom light theme based on blue color
import 'package:flutter/material.dart';

class LightTheme {
  static const Color backgroundColor = Color(0xF9F9F9F9);
  static const Color cardBackgroundColor = Color(0xFFFFFFFF);

  static Color primaryColor = Color(
    0xFF007AAD,
  ); // Non-constant to allow customization
  static Color primaryColorLight = Color(
    0xFFD9E2E9,
  ); // Non-constant to allow customization
  static const Color onPrimaryColor = Color(0xFFFFFFFF);

  static const Color textPrimary = Color(0xFF313131);
  static const Color textPrimaryLight = Color(0xFFA2A2A2);
  static const Color textSecondary = Color(0xFF242424);

  static const Color greyLighten1 = Color(0xFFE3E3E3);
  static const Color greyLighten2 = Color(0xFFEDEDED);
  static const Color greyLighten3 = Color(0xFFD8D8D8);

  static const Color success = Color(0xFF5BBA6F);
  static const Color warning = Color(0xFFFF8A80);
  static const Color error = Color(0xFFEF5350);
  static const Color info = Color(0xFF5AC8FA);
}
