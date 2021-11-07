import 'package:flutter/material.dart';
import 'package:flutter_front_end/route_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // App title
      title: 'GoldenConsole',
      // Sets default page - Current default page: screens.dart
      initialRoute: '/',
      // Sets Route management from route_generator.dart
      onGenerateRoute: RouteGenerator.generateRoute,
      // Sets the theme and style of the site/app
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Sets configuration of the app colors
        brightness: Brightness.dark,
        primaryColor: Colors.amber,
      ),
    );
  }
}