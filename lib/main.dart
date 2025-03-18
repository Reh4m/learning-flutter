import 'package:flutter/material.dart';
import 'package:learning_flutter/src/config/routes.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learning Flutter',
      onGenerateRoute: Routes.generateRoute,
      initialRoute: '/splash-screen',
    );
  }
}
