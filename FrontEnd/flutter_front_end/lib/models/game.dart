import 'dart:convert';
import 'package:http/http.dart';

Future<List<Game>> fetchGameList() async {
  Response response = await get(Uri.parse("http://127.0.0.1:8080/game"));

  final _extractedData = json.decode(response.body) as Map<String, dynamic>;

  List<Game> _data = [];
  List<Game> _fetchedData = [];

  _extractedData['game_list'].forEach((value) {
    _fetchedData.add(Game(
        gameId: value['game_id'],
        gameName: value['game_name'],
        developer: value['developer'],
        genre: value['genre'],
        cover: value['cover']
    ));
  });

  _data = _fetchedData;

  return _data;
}

Future<Game> fetchGameById(int id) async {
  Response response = await get(Uri.parse("http://127.0.0.1:8080/game/$id"));

  final _extractedData = json.decode(response.body) as Map<String, dynamic>;

  Game _data;
  Game _fetchedData;

  _fetchedData = Game(
      gameId: _extractedData['game_id'],
      gameName: _extractedData['game_name'],
      developer: _extractedData['developer'],
      genre: _extractedData['genre'],
      cover: _extractedData['cover']
  );

  _data = _fetchedData;

  return _data;
}

class Game {
  int gameId;
  String gameName;
  String developer;
  String genre;
  String cover;

  Game({
    required this.gameId,
    required this.gameName,
    required this.developer,
    required this.genre,
    required this.cover
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
        gameId: json['game_id'],
        gameName: json['game_name'].toString(),
        developer: json['developer'].toString(),
        genre: json['genre'].toString(),
        cover: json['cover'].toString()
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['game_id'] = gameId;
    data['game_name'] = gameName;
    data['developer'] = developer;
    data['genre'] = genre;
    data['cover'] = cover;
    return data;
  }
}
