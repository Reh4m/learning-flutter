import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isLoggedIn', false);
  }

  @override
  Widget build(BuildContext context) {
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
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
              ),
              accountName: Text('Emmanuel Ruiz Pérez'),
              accountEmail: Text('20030124@itcelaya.edu.mx'),
            ),
            ListTile(
              leading: Icon(Icons.dashboard_customize_outlined),
              title: Text('Customize theme'),
              onTap: () {
                Navigator.pushNamed(context, '/customize-theme');
              },
            ),
            ListTile(
              leading: Icon(Icons.movie_outlined),
              title: Text('Popular movies'),
              onTap: () {
                Navigator.pushNamed(context, '/popular-movies');
              },
            ),
          ],
        ),
      ),
    );
  }
}
