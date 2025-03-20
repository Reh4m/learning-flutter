import 'package:flutter/material.dart';
import 'package:learning_flutter/src/themes/theme.dart';
import 'package:learning_flutter/src/themes/theme_manager.dart';

enum ColorMode { light, dark, system }

class GlobalValues {
  // Theme and color mode
  static ValueNotifier themeApp = ValueNotifier(AppTheme.lightTheme);
  static ValueNotifier colorMode = ValueNotifier(ColorMode.light);
  static ValueNotifier themeColor = ValueNotifier(ThemeColor.defaultTheme);
}
