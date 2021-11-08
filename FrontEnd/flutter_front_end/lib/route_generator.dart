import 'package:flutter/material.dart';
import 'package:flutter_front_end/screens/game_page.dart';
import 'package:flutter_front_end/screens/home_page.dart';
import 'package:flutter_front_end/screens/register_page.dart';
import 'package:flutter_front_end/screens/user_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return PageRouteBuilder(pageBuilder: (_, __, ___) => const HomePage());
      case '/register':
        return PageRouteBuilder(pageBuilder: (_, __, ___) => const RegisterPage());
      case '/game':
        if (args is int) {
          return MaterialPageRoute(
            builder: (_) => GamePage(
              data: args,
            ),
          );
        }
        return _errorRoute();
      case '/user':
        if (args is int) {
          return MaterialPageRoute(
            builder: (_) => UserPage(
              data: args,
            ),
          );
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  // TODO: A better Error page
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}