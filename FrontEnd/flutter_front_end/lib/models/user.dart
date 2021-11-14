import 'dart:convert';
import 'dart:html';
import 'package:http/http.dart';

Future<List<User>> fetchUserList() async {
  Response response = await get(Uri.parse("http://127.0.0.1:8080/user"));

  final _extractedData = json.decode(response.body) as Map<String, dynamic>;

  List<User> _data = [];
  List<User> _fetchedData = [];

  _extractedData['user_list'].forEach((value) {
    _fetchedData.add(User(
      userId: value['user_id'],
      username: value['user_name'],
      pwd: value['user_pwd'],
    ));
  });

  _data = _fetchedData;

  return _data;
}

Future<User> fetchUserById(int id) async {
  Response response = await get(Uri.parse("http://127.0.0.1:8080/user/$id"));

  final _extractedData = json.decode(response.body) as Map<String, dynamic>;

  User _data;
  User _fetchedData;

  _fetchedData = User(
    userId: _extractedData['user_id'],
    username: _extractedData['user_name'],
    pwd: _extractedData['user_pwd'],
  );

  _data = _fetchedData;

  return _data;
}

class User {
  int userId;
  String username;
  String pwd;

  User({
    required this.userId,
    required this.username,
    required this.pwd,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userId: json['user_id'],
        username: json['user_name'].toString(),
        pwd: json['user_pwd'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = "";
    data['user_name'] = username;
    data['user_pwd'] = pwd;
    return data;
  }
}
