import 'package:flutter/material.dart';
import 'package:learning_flutter/src/themes/theme.dart';
import 'package:learning_flutter/src/utils/global_values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isLoggedIn', false);
  }

  Future<void> toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (GlobalValues.themeApp.value == AppTheme.darkTheme) {
      GlobalValues.themeApp.value = AppTheme.lightTheme;
      await prefs.setString('theme', 'light');
    } else {
      GlobalValues.themeApp.value = AppTheme.darkTheme;
      await prefs.setString('theme', 'dark');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          ValueListenableBuilder(
            valueListenable: GlobalValues.themeApp,
            builder:
                (context, value, child) => IconButton(
                  onPressed: toggleTheme,
                  icon: Icon(
                    GlobalValues.themeApp.value == AppTheme.darkTheme
                        ? Icons.light_mode
                        : Icons.dark_mode,
                  ),
                ),
          ),
          IconButton(
            onPressed: () {
              logout();

              Navigator.pushReplacementNamed(context, '/sign-in');
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
