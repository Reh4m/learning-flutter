import 'package:flutter/material.dart';
import 'package:learning_flutter/src/screens/appearance/index.dart';
import 'package:learning_flutter/src/screens/home_screen.dart';
import 'package:learning_flutter/src/screens/movies/popular_details_screen.dart';
import 'package:learning_flutter/src/screens/movies/popular_screen.dart';
import 'package:learning_flutter/src/screens/auth/sign_in_screen.dart';
import 'package:learning_flutter/src/screens/auth/sign_up_screen.dart';
import 'package:learning_flutter/src/screens/splash_screen.dart';
import 'package:learning_flutter/src/screens/todo/todo_form_screen.dart';
import 'package:learning_flutter/src/screens/todo/todo_screen.dart';

class AppRouter {
  static Map<String, WidgetBuilder> routes = {
    '/': (_) => const HomeScreen(),
    '/splash-screen': (_) => const SplashScreen(),
    '/sign-in': (_) => const SignInScreen(),
    '/sign-up': (_) => const SignUpScreen(),
    '/customize-theme': (_) => const CustomizeThemeScreen(),
    '/todo-list': (_) => const TodoScreen(),
    '/todo-form': (_) => const TodoFormScreen(),
    '/popular-movies': (_) => const PopularScreen(),
    '/popular-details': (_) => const PopularDetailsScreen(),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/splash-screen':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/sign-in':
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case '/sign-up':
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case '/customize-theme':
        return MaterialPageRoute(builder: (_) => const CustomizeThemeScreen());
      case '/todo-list':
        return MaterialPageRoute(builder: (_) => const TodoScreen());
      case '/todo-form':
        return MaterialPageRoute(builder: (_) => const TodoFormScreen());
      case '/popular-movies':
        return MaterialPageRoute(builder: (_) => const PopularScreen());
      case '/popular-details':
        return MaterialPageRoute(builder: (_) => const PopularDetailsScreen());
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
