import 'package:flutter/material.dart';
import 'package:learning_flutter/src/themes/theme.dart';

enum ColorMode { light, dark, system }

class GlobalValues {
  static ValueNotifier themeApp = ValueNotifier(AppTheme.lightTheme);
  static ValueNotifier colorMode = ValueNotifier(ColorMode.light);
}
