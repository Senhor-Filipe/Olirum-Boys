import 'package:flutter/material.dart';
import 'package:flutter_front_end/models/screen_arguments.dart';

class SearchHeader extends StatefulWidget {
  final ScreenArguments data;

  const SearchHeader({
    Key? key,
    required this.data
  }) : super(key: key);

  @override
  _SearchHeaderState createState() => _SearchHeaderState();
}

class _SearchHeaderState extends State<SearchHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}