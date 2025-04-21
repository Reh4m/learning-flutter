import 'package:flutter/material.dart';
import 'package:learning_flutter/src/utils/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isLoggedIn', false);
  }

  void _switchColorMode(
    ThemeProvider themeProvider,
    ThemeMode targetMode,
  ) async {
    await themeProvider.updateThemeMode(targetMode);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          IconButton(
            onPressed: () {
              logout();

              Navigator.pushReplacementNamed(context, '/sign-in');
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Stack(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Theme.of(
                      context,
                    ).primaryColorLight.withValues(alpha: 0.3),
                    child: Text(
                      'ER',
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  accountName: Text(
                    'Emmanuel Ruiz Pérez',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  accountEmail: Text('20030124@itcelaya.edu.mx'),
                ),
                Positioned(
                  right: 16.0,
                  top: 16.0,
                  child: IconButton(
                    onPressed:
                        () => _switchColorMode(
                          themeProvider,
                          themeProvider.themeMode == ThemeMode.dark
                              ? ThemeMode.light
                              : ThemeMode.dark,
                        ),
                    icon: Icon(
                      themeProvider.themeMode == ThemeMode.dark
                          ? Icons.light_mode
                          : Icons.dark_mode,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),

            ListTile(
              leading: Icon(Icons.list),
              title: Text('Todo List'),
              onTap: () {
                Navigator.pushNamed(context, '/todo-list');
              },
            ),
            ListTile(
              leading: Icon(Icons.movie_outlined),
              title: Text('Popular movies'),
              onTap: () {
                Navigator.pushNamed(context, '/popular-movies');
              },
            ),
            Divider(thickness: 0.1),
            ListTile(
              leading: Icon(Icons.dashboard_customize_outlined),
              title: Text('Customize theme'),
              onTap: () {
                Navigator.pushNamed(context, '/customize-theme');
              },
            ),
          ],
        ),
      ),
    );
  }
}
