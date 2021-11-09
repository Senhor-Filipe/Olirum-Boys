import 'package:flutter/material.dart';
import 'package:flutter_front_end/models/screen_arguments.dart';

class GameGridView extends StatefulWidget {
  final ScreenArguments data;

  const GameGridView({
    Key? key,
    required this.data
  }) : super(key: key);

  @override
  _GameGridViewState createState() => _GameGridViewState();
}

class _GameGridViewState extends State<GameGridView> {
  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}