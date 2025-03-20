import 'package:flutter/material.dart';
import 'package:learning_flutter/src/config/routes.dart';
import 'package:learning_flutter/src/utils/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  final themeProvider = ThemeProvider(prefs);
  await themeProvider.loadAppTheme();

  runApp(
    ChangeNotifierProvider(create: (_) => themeProvider, child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learning Flutter',
      theme: themeProvider.currentAppTheme,
      onGenerateRoute: Routes.generateRoute,
      initialRoute: '/splash-screen',
    );
  }
}
