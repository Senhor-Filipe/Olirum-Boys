import 'dart:convert';
import 'package:http/http.dart';

Future fetchGameList() async {
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

class GameResults {
  List<Game>? gameResults;

  GameResults({
    required this.gameResults
  });

  GameResults.fromJson(Map<String, dynamic> json) {
    if (json['game_list'] != null) {
      gameResults = [];
      json['game_list'].forEach((v) {
        gameResults!.add(Game.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (gameResults != null) {
      data['game_list'] = gameResults!.map((v) => v.toJson()).toList();
    }
    return data;
  }
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
