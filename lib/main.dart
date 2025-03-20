import 'package:flutter/material.dart';
import 'package:learning_flutter/src/config/routes.dart';
import 'package:learning_flutter/src/themes/theme_manager.dart';
import 'package:learning_flutter/src/utils/global_values.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  String themeMode = prefs.getString('theme') ?? 'light';
  String themeColor = prefs.getString('themeColor') ?? 'defaultTheme';

  ColorMode themeModeEnum =
      themeMode == 'dark' ? ColorMode.dark : ColorMode.light;
  ThemeColor themeColorEnum =
      themeColor == 'defaultTheme'
          ? ThemeColor.defaultTheme
          : ThemeColor.values.byName(themeColor);

  CustomTheme customTheme = ThemeManager.getTheme(themeColorEnum);

  GlobalValues.themeApp.value = ThemeManager.getThemeInstance(
    customTheme,
    themeModeEnum,
  );
  GlobalValues.colorMode.value = themeModeEnum;
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
