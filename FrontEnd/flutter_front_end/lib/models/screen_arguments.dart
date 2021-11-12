import 'package:flutter_front_end/models/user.dart';

class ScreenArguments {
  User user;
  bool logged;
  int dataId;

  ScreenArguments(
      this.user,
      this.logged,
      this.dataId
      );
}