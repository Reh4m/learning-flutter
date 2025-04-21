import 'package:flutter/material.dart';
import 'package:learning_flutter/src/utils/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isLoggedIn', false);

    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, '/sign-in');
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
      appBar: _buildAppBar(context),
      drawer: _buildDrawer(context, themeProvider),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Home Screen'),
      actions: [
        IconButton(
          onPressed: () => logout(context),
          icon: const Icon(Icons.logout),
        ),
      ],
    );
  }

  Drawer _buildDrawer(BuildContext context, ThemeProvider themeProvider) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          _buildUserAccountHeader(context, themeProvider),
          _buildDrawerItem(
            icon: Icons.list,
            title: 'Todo List',
            onTap: () => Navigator.pushNamed(context, '/todo-list'),
          ),
          _buildDrawerItem(
            icon: Icons.movie_outlined,
            title: 'Popular Movies',
            onTap: () => Navigator.pushNamed(context, '/popular-movies'),
          ),
          const Divider(thickness: 0.1),
          _buildDrawerItem(
            icon: Icons.dashboard_customize_outlined,
            title: 'Customize Theme',
            onTap: () => Navigator.pushNamed(context, '/customize-theme'),
          ),
        ],
      ),
    );
  }

  Widget _buildUserAccountHeader(
    BuildContext context,
    ThemeProvider themeProvider,
  ) {
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
                () => _switchColorMode(
                  themeProvider,
                  isDarkMode ? ThemeMode.light : ThemeMode.dark,
                ),
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(leading: Icon(icon), title: Text(title), onTap: onTap);
  }
}
