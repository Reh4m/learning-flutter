import 'package:flutter/material.dart';
import 'package:learning_flutter/src/config/routes.dart';
import 'package:learning_flutter/src/themes/theme.dart';
import 'package:learning_flutter/src/utils/global_values.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  String theme = prefs.getString('theme') ?? 'light';

  GlobalValues.themeApp.value =
      theme == 'dark' ? AppTheme.darkTheme : AppTheme.lightTheme;
  GlobalValues.colorMode.value =
      theme == 'dark' ? ColorMode.dark : ColorMode.light;

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
