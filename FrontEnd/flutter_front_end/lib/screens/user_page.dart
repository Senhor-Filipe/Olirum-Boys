import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  final int data;

  const UserPage({
    Key? key,
    required this.data
  }) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement a way for the logged user to see his own and others profiles. If there's time, with different views for own profile and others
    throw UnimplementedError();
  }
}