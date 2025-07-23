import 'package:flutter/material.dart';
import 'package:learning_flutter/src/themes/app_theme.dart';
import 'package:learning_flutter/src/themes/theme_colors.dart';
import 'package:learning_flutter/src/themes/theme_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  final SharedPreferences prefs;

  // Theme data
  ThemeMode _currentThemeMode = ThemeMode.light;
  ThemeData _currentLightTheme = AppTheme.lightTheme;
  ThemeData _currentDarkTheme = AppTheme.darkTheme;

  // Custom values
  ThemeColor _selectedThemeColor = ThemeColor.defaultTheme;
  FontFamily _selectedFontFamily = FontFamily.roboto;

  // Getters
  ThemeMode get themeMode => _currentThemeMode;
  ThemeData get lightTheme => _currentLightTheme;
  ThemeData get darkTheme => _currentDarkTheme;

  ThemeColor get themeColor => _selectedThemeColor;
  FontFamily get fontFamily => _selectedFontFamily;

  ThemeProvider(this.prefs) {
    _loadThemePreferences();
  }

  void _loadThemePreferences() {
    String themeModeString = prefs.getString('themeMode') ?? 'light';
    String themeColorString = prefs.getString('themeColor') ?? 'defaultTheme';
    String fontFamilyString = prefs.getString('fontFamily') ?? 'roboto';

    switch (themeModeString) {
      case 'light':
        _currentThemeMode = ThemeMode.light;
        break;
      case 'dark':
        _currentThemeMode = ThemeMode.dark;
        break;
      default:
        _currentThemeMode = ThemeMode.system;
    }

    _selectedThemeColor = ThemeColor.values.byName(themeColorString);
    _selectedFontFamily = FontFamily.values.byName(fontFamilyString);

    _updateThemeData();
  }

  void _updateThemeData() {
    final customTheme = ThemeColors.getCustomTheme(_selectedThemeColor);

    _currentLightTheme = AppTheme.lightTheme.copyWith(
      primaryColor: customTheme.primaryColor,
      primaryColorLight: customTheme.primaryColorLight,
      colorScheme: ColorScheme.light(
        primary: customTheme.primaryColor,
        secondary: customTheme.primaryColorLight,
      ),
      textTheme: ThemeFonts.getTextTheme(_selectedFontFamily),
    );

    _currentDarkTheme = AppTheme.darkTheme.copyWith(
      primaryColor: customTheme.primaryColor,
      primaryColorLight: customTheme.primaryColorLight,
      colorScheme: ColorScheme.dark(
        primary: customTheme.primaryColor,
        secondary: customTheme.primaryColorLight,
      ),
    );

    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    _currentThemeMode = themeMode;

    await prefs.setString('themeMode', _currentThemeMode.name);

    notifyListeners();
  }

  Future<void> setThemeColor(ThemeColor themeColor) async {
    _selectedThemeColor = themeColor;

    await prefs.setString('themeColor', themeColor.name);

    _updateThemeData();
  }

  Future<void> updateFontFamily(FontFamily fontFamily) async {
    _selectedFontFamily = fontFamily;

    await prefs.setString('fontFamily', fontFamily.name);

    _updateThemeData();
  }
}
