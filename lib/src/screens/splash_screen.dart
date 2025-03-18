import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _loadNextScreen() async {
    final prefs = await SharedPreferences.getInstance();

    final isUserLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isUserLoggedIn) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/');
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/sign-in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterSplashScreen(
        duration: const Duration(milliseconds: 3800),
        onEnd: () => _loadNextScreen(),
        backgroundColor: Colors.white,
        splashScreenBody: Center(child: Lottie.asset('assets/splash.json')),
      ),
    );
  }
}
