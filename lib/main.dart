import 'package:flutter/material.dart';
import 'package:learning_flutter/src/config/routes.dart';
import 'package:learning_flutter/src/themes/theme.dart';
import 'package:learning_flutter/src/themes/theme_manager.dart';
import 'package:learning_flutter/src/utils/global_values.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  String themeMode = prefs.getString('theme') ?? 'light';
  String themeColor = prefs.getString('themeColor') ?? 'defaultTheme';

  ThemeColor themeColorEnum =
      themeColor == 'defaultTheme'
          ? ThemeColor.defaultTheme
          : ThemeColor.values.byName(themeColor);

  CustomTheme customTheme = ThemeManager.getTheme(themeColorEnum);

  ThemeData darkThemeInstance = AppTheme.darkTheme.copyWith(
    primaryColor: customTheme.primaryColor,
    primaryColorLight: customTheme.primaryColorLight,
    colorScheme: AppTheme.darkTheme.colorScheme.copyWith(
      primary: customTheme.primaryColor,
      secondary: customTheme.primaryColorLight,
    ),
  );

  ThemeData lightThemeInstance = AppTheme.lightTheme.copyWith(
    primaryColor: customTheme.primaryColor,
    primaryColorLight: customTheme.primaryColorLight,
    colorScheme: AppTheme.lightTheme.colorScheme.copyWith(
      primary: customTheme.primaryColor,
      secondary: customTheme.primaryColorLight,
    ),
  );

  GlobalValues.themeApp.value =
      themeMode == 'dark' ? darkThemeInstance : lightThemeInstance;
  GlobalValues.colorMode.value =
      themeMode == 'dark' ? ColorMode.dark : ColorMode.light;
  GlobalValues.themeColor.value = themeColorEnum;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: GlobalValues.themeApp,
      builder:
          (context, value, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Learning Flutter',
            theme: value,
            onGenerateRoute: Routes.generateRoute,
            initialRoute: '/splash-screen',
          ),
    );
  }
}
