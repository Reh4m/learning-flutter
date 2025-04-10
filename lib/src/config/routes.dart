import 'package:flutter/material.dart';
import 'package:learning_flutter/src/screens/settings/customize_theme/index.dart';
import 'package:learning_flutter/src/screens/home_screen.dart';
import 'package:learning_flutter/src/screens/movies/popular_details_screen.dart';
import 'package:learning_flutter/src/screens/movies/popular_screen.dart';
import 'package:learning_flutter/src/screens/auth/sign_in_screen.dart';
import 'package:learning_flutter/src/screens/auth/sign_up_screen.dart';
import 'package:learning_flutter/src/screens/splash_screen.dart';
import 'package:learning_flutter/src/screens/todo/todo_form_screen.dart';
import 'package:learning_flutter/src/screens/todo/todo_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> routes = {
    '/': (_) => HomeScreen(),
    '/splash-screen': (_) => SplashScreen(),
    '/sign-in': (_) => SignInScreen(),
    '/sign-up': (_) => SignUpScreen(),
    '/customize-theme': (_) => CustomizeThemeScreen(),
    '/todo-list': (_) => TodoScreen(),
    '/todo-form': (_) => TodoFormScreen(),
    '/popular-movies': (_) => PopularScreen(),
    '/popular-details': (_) => PopularDetailsScreen(),
  };

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
      case '/todo-form':
        return MaterialPageRoute(builder: (_) => TodoFormScreen());
      case '/popular-movies':
        return MaterialPageRoute(builder: (_) => PopularScreen());
      case '/popular-details':
        return MaterialPageRoute(builder: (_) => PopularDetailsScreen());
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
