import 'package:flutter/material.dart';
import 'package:learning_flutter/src/screens/customize_theme_screen.dart';
import 'package:learning_flutter/src/screens/home_screen.dart';
import 'package:learning_flutter/src/screens/sign_in_screen.dart';
import 'package:learning_flutter/src/screens/sign_up_screen.dart';
import 'package:learning_flutter/src/screens/splash_screen.dart';
import 'package:learning_flutter/src/screens/todo_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/splash-screen':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/sign-in':
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case '/sign-up':
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case '/customize-theme':
        return MaterialPageRoute(builder: (_) => CustomizeThemeScreen());
      case '/todo-list':
        return MaterialPageRoute(builder: (_) => TodoScreen());
      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
