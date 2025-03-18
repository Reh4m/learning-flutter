import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.brightness_4_outlined)),
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
