import 'package:flutter/material.dart';
import 'package:learning_flutter/src/utils/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> handleLogout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isLoggedIn', false);

    Navigator.pushReplacementNamed(context, '/sign-in');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          IconButton(
            onPressed: () => handleLogout(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      drawer: _buildAppDrawer(context),
    );
  }

  Drawer _buildAppDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          _buildUserHeader(context),
          ListTile(
            onTap: () => Navigator.pushNamed(context, '/todo-list'),
            leading: const Icon(Icons.list),
            title: const Text('Todo List'),
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, '/popular-movies'),
            leading: const Icon(Icons.movie_outlined),
            title: const Text('Popular Movies'),
          ),
          const Divider(thickness: 0.1),
          ListTile(
            onTap: () => Navigator.pushNamed(context, '/customize-theme'),
            leading: const Icon(Icons.dashboard_customize_outlined),
            title: const Text('Customize Theme'),
          ),
        ],
      ),
    );
  }

  Widget _buildUserHeader(BuildContext context) {
    final themeProvider = context.read<ThemeProvider>();

    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Stack(
      children: <Widget>[
        UserAccountsDrawerHeader(
          currentAccountPictureSize: const Size.square(65.0),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColorLight.withAlpha(50),
            child: const Text(
              'ER',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
            ),
          ),
          accountName: const Text(
            'Emmanuel Ruiz Pérez',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          accountEmail: const Text('20030124@itcelaya.edu.mx'),
        ),
        Positioned(
          right: 16.0,
          top: 16.0,
          child: IconButton(
            onPressed:
                () => themeProvider.setThemeMode(
                  isDarkMode ? ThemeMode.light : ThemeMode.dark,
                ),
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              transitionBuilder:
                  (child, anim) => RotationTransition(
                    turns:
                        child.key == const ValueKey('light')
                            ? Tween<double>(begin: 1, end: 0.75).animate(anim)
                            : Tween<double>(begin: 0.75, end: 1).animate(anim),
                    child: ScaleTransition(scale: anim, child: child),
                  ),
              child: Icon(
                key:
                    isDarkMode
                        ? const ValueKey('light')
                        : const ValueKey('dark'),
                isDarkMode ? Icons.light_mode : Icons.dark_mode,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
