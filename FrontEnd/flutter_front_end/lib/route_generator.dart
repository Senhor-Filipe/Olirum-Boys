import 'package:flutter/material.dart';
import 'package:flutter_front_end/models/screen_arguments.dart';
import 'package:flutter_front_end/screens/game_page.dart';
import 'package:flutter_front_end/screens/home_page.dart';
import 'package:flutter_front_end/screens/register_page.dart';
import 'package:flutter_front_end/screens/user_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    ScreenArguments data = ScreenArguments("", 0, false, 0);

    if (args != null)
    {
      data = args as ScreenArguments;
    }

    switch (settings.name) {
      case '/':
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => HomePage(
              data: data,
            )
        );
      case '/register':
        // TODO when register page is finished, fix here (medium priority)
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => HomePage(
              data: data,
            )
        );
      case '/game':
        if (args is ScreenArguments) {
          return MaterialPageRoute(
            builder: (_) => GamePage(
              data: data,
            )
          );
        }
        return _errorRoute();
      case '/user':
        if (args is ScreenArguments) {
          return MaterialPageRoute(
            builder: (_) => UserPage(
              data: data,
            )
          );
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  // TODO: A better Error page, but this is fine (low priority)
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