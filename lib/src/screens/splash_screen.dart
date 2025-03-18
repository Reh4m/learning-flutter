import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:learning_flutter/src/screens/home_screen.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterSplashScreen(
        duration: const Duration(milliseconds: 3800),
        nextScreen: HomeScreen(),
        backgroundColor: Colors.white,
        splashScreenBody: Center(child: Lottie.asset('assets/splash.json')),
      ),
    );
  }
}
