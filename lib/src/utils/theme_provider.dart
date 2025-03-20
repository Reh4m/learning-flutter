import 'package:flutter/material.dart';
import 'package:learning_flutter/src/themes/dark_theme.dart';
import 'package:learning_flutter/src/themes/light_theme.dart';
import 'package:learning_flutter/src/themes/theme.dart';
import 'package:learning_flutter/src/themes/theme_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  final SharedPreferences prefs;

  // Theme data classes
  ThemeMode _themeMode = ThemeMode.light;
  ThemeData _lightTheme = AppTheme.generateLightTheme('Roboto');
  ThemeData _darkTheme = AppTheme.generateDarkTheme('Roboto');

  // Current theme values
  ThemeColor _themeColor = ThemeColor.defaultTheme;
  String _fontFamily = 'Roboto';

  // Getters
  ThemeMode get themeMode => _themeMode;
  ThemeData get lightTheme => _lightTheme;
  ThemeData get darkTheme => _darkTheme;

  ThemeColor get themeColor => _themeColor;
  String get fontFamily => _fontFamily;

  ThemeProvider(this.prefs);

  Future<void> loadAppTheme() async {
    // Load current theme mode
    String themeModeString = prefs.getString('themeMode') ?? 'light';

    // Load current theme values
    String themeColorString = prefs.getString('themeColor') ?? 'defaultTheme';

    // Load current font family
    String fontFamilyValue = prefs.getString('fontFamily') ?? 'Roboto';

    // Set values
    _themeMode = themeModeString == 'light' ? ThemeMode.light : ThemeMode.dark;
    _themeColor = ThemeColor.values.byName(themeColorString);
    _fontFamily = fontFamilyValue;

    // Update theme data classes
    _updateThemeData();

    _updateAppTheme();
  }

  void _updateThemeData() {
    LightTheme.primaryColor =
        ThemeColors.getCustomTheme(_themeColor).primaryColor;
    LightTheme.primaryColorLight =
        ThemeColors.getCustomTheme(_themeColor).primaryColorLight;
    DarkTheme.primaryColor =
        ThemeColors.getCustomTheme(_themeColor).primaryColor;
    DarkTheme.primaryColorLight =
        ThemeColors.getCustomTheme(_themeColor).primaryColorLight;
  }

  void _updateAppTheme() {
    _lightTheme = AppTheme.generateLightTheme(_fontFamily);
    _darkTheme = AppTheme.generateDarkTheme(_fontFamily);

    notifyListeners();
  }

  Future<void> updateThemeMode(ThemeMode themeMode) async {
    _themeMode = themeMode;

    await prefs.setString(
      'themeMode',
      themeMode == ThemeMode.light ? 'light' : 'dark',
    );

    _updateAppTheme();
  }

  Future<void> updateThemeColor(ThemeColor themeColor) async {
    _themeColor = themeColor;

    _updateThemeData();

    await prefs.setString('themeColor', themeColor.name);

    _updateAppTheme();
  }

  Future<void> updateFontFamily(String fontFamily) async {
    _fontFamily = fontFamily;

    await prefs.setString('fontFamily', fontFamily);

    _updateAppTheme();
  }
}
