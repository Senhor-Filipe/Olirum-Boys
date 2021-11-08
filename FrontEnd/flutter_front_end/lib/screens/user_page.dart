import 'package:flutter/material.dart';
import 'package:flutter_front_end/models/screen_arguments.dart';

class UserPage extends StatefulWidget {
  final ScreenArguments data;

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
    return widget.data.userId == widget.data.dataId?
    Text("This is your profile ${widget.data.username}"):
    Text("This is not your profile");
  }
}