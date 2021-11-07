import 'package:flutter/material.dart';
import 'package:flutter_front_end/screens/game_page.dart';
import 'package:flutter_front_end/screens/home_page.dart';
import 'package:flutter_front_end/screens/register_page.dart';
import 'package:flutter_front_end/screens/user_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return PageRouteBuilder(pageBuilder: (_, __, ___) => const HomePage());
      case '/register':
        return PageRouteBuilder(pageBuilder: (_, __, ___) => const RegisterPage());
      case '/game':
        return PageRouteBuilder(pageBuilder: (_, __, ___) => const GamePage());
      case '/user':
        return PageRouteBuilder(pageBuilder: (_, __, ___) => const UserPage());
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