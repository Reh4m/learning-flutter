import 'package:flutter/material.dart';
import 'package:learning_flutter/src/themes/theme.dart';
import 'package:learning_flutter/src/themes/theme_colors.dart';
import 'package:learning_flutter/src/themes/theme_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ColorMode { light, dark, system }

class ThemeProvider extends ChangeNotifier {
  final SharedPreferences prefs;
  ThemeData _currentAppTheme = AppTheme.lightTheme;

  ThemeData get currentAppTheme => _currentAppTheme;

  // Current theme values
  ColorMode _colorMode = ColorMode.light;
  ThemeColor _themeColor = ThemeColor.defaultTheme;
  String _fontFamily = 'Roboto';

  ColorMode get colorMode => _colorMode;
  ThemeColor get themeColor => _themeColor;
  String get fontFamily => _fontFamily;

  ThemeProvider(this.prefs);

  Future<void> loadAppTheme() async {
    // Load saved values from SharedPreferences
    String colorMode = prefs.getString('colorMode') ?? 'light';
    String themeColor = prefs.getString('themeColor') ?? 'defaultTheme';
    String fontFamily = prefs.getString('fontFamily') ?? 'Roboto';

    // Set the current theme values
    _colorMode = colorMode == 'light' ? ColorMode.light : ColorMode.dark;
    _themeColor = ThemeColor.values.byName(themeColor);
    _fontFamily = fontFamily;

    _updateAppTheme();
  }

  void _updateAppTheme() {
    final TextTheme textTheme = _getTextTheme();

    _currentAppTheme =
        _colorMode == ColorMode.light
            ? _getAppTheme(AppTheme.lightTheme, textTheme)
            : _getAppTheme(AppTheme.darkTheme, textTheme);

    notifyListeners();
  }

  TextTheme _getTextTheme() {
    return ThemeFonts.getTextTheme(_fontFamily);
  }

  ThemeData _getAppTheme(ThemeData theme, TextTheme textTheme) {
    return theme.copyWith(
      primaryColor: ThemeColors.getCustomTheme(_themeColor).primaryColor,
      primaryColorLight:
          ThemeColors.getCustomTheme(_themeColor).primaryColorLight,
      colorScheme: theme.colorScheme.copyWith(
        primary: ThemeColors.getCustomTheme(_themeColor).primaryColor,
        secondary: ThemeColors.getCustomTheme(_themeColor).primaryColorLight,
      ),
      textTheme: textTheme.copyWith(
        bodySmall: theme.textTheme.bodySmall,
        bodyMedium: theme.textTheme.bodyMedium,
        bodyLarge: theme.textTheme.bodyLarge,
      ),
    );
  }

  Future<void> updateColorMode(ColorMode colorMode) async {
    _colorMode = colorMode;

    await prefs.setString(
      'colorMode',
      colorMode == ColorMode.light ? 'light' : 'dark',
    );

    _updateAppTheme();
  }

  Future<void> updateThemeColor(ThemeColor themeColor) async {
    _themeColor = themeColor;

    await prefs.setString('themeColor', themeColor.name);

    _updateAppTheme();
  }

  Future<void> updateFontFamily(String fontFamily) async {
    _fontFamily = fontFamily;

    await prefs.setString('fontFamily', fontFamily);

    _updateAppTheme();
  }
}
