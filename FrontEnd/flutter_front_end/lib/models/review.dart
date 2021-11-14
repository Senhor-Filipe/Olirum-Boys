import 'dart:convert';
import 'package:flutter_front_end/models/user.dart';
import 'package:http/http.dart';

import 'game.dart';

Future<List<Review>> fetchReviewList() async {
  Response response = await get(Uri.parse("http://127.0.0.1:8080/review"));

  final _extractedData = json.decode(response.body) as Map<String, dynamic>;

  List<Review> _data = [];
  List<Review> _fetchedData = [];

  _extractedData['review_list'].forEach((value) {
    _fetchedData.add(Review(
        reviewId: value['review_id'],
        user: User(
          userId: value['user']['user_id'],
          username: value['user']['user_name'].toString(),
          pwd: value['user']['user_pwd'].toString()
        ),
        game: Game(
          gameId: value['game']['game_id'],
          gameName: value['game']['game_name'],
          developer: value['game']['developer'],
          genre: value['game']['genre'],
          cover: value['game']['cover']
        ),
        reviewBody: value['review_body'],
        score: value['score']));
  });

  _data = _fetchedData;

  return _data;
}

Future<List<Review>> fetchReviewListByGameId(int id) async {
  Response response = await get(Uri.parse("http://127.0.0.1:8080/game/review/$id"));

  final _extractedData = json.decode(response.body) as Map<String, dynamic>;

  List<Review> _data = [];
  List<Review> _fetchedData = [];

  _extractedData['review_list'].forEach((value) {
    _fetchedData.add(Review(
        reviewId: value['review_id'],
        user: User(
            userId: value['user']['user_id'],
            username: value['user']['user_name'].toString(),
            pwd: value['user']['user_pwd'].toString()
        ),
        game: Game(
            gameId: value['game']['game_id'],
            gameName: value['game']['game_name'],
            developer: value['game']['developer'],
            genre: value['game']['genre'],
            cover: value['game']['cover']
        ),
        reviewBody: value['review_body'],
        score: value['score']));
  });

  _data = _fetchedData;

  return _data;
}

Future<List<Review>> fetchReviewListByUserId(int id) async {
  Response response = await get(Uri.parse("http://127.0.0.1:8080/user/review/$id"));

  final _extractedData = json.decode(response.body) as Map<String, dynamic>;

  List<Review> _data = [];
  List<Review> _fetchedData = [];

  _extractedData['review_list'].forEach((value) {
    _fetchedData.add(Review(
        reviewId: value['review_id'],
        user: User(
            userId: value['user']['user_id'],
            username: value['user']['user_name'].toString(),
            pwd: value['user']['user_pwd'].toString()
        ),
        game: Game(
            gameId: value['game']['game_id'],
            gameName: value['game']['game_name'],
            developer: value['game']['developer'],
            genre: value['game']['genre'],
            cover: value['game']['cover']
        ),
        reviewBody: value['review_body'],
        score: value['score']));
  });

  _data = _fetchedData;

  return _data;
}

Future<Review> fetchReviewById(int id) async {
  Response response = await get(Uri.parse("http://127.0.0.1:8080/review/$id"));

  final _extractedData = json.decode(response.body) as Map<String, dynamic>;

  Review _data;
  Review _fetchedData;

  _fetchedData = Review(
      reviewId: _extractedData['review_id'],
      user: User(
          userId: _extractedData['user']['user_id'],
          username: _extractedData['user']['user_name'].toString(),
          pwd: _extractedData['user']['user_pwd'].toString()
      ),
      game: Game(
          gameId: _extractedData['game']['game_id'],
          gameName: _extractedData['game']['game_name'],
          developer: _extractedData['game']['developer'],
          genre: _extractedData['game']['genre'],
          cover: _extractedData['game']['cover']
      ),
      reviewBody: _extractedData['review_body'],
      score: _extractedData['score']
  );

  _data = _fetchedData;

  return _data;
}

class Review {
  int reviewId;
  User? user;
  Game? game;
  String reviewBody;
  int score;

  Review({
    required this.reviewId,
    required this.user,
    required this.game,
    required this.reviewBody,
    required this.score
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
        reviewId: json['review_id'],
        user: json['user'] != null? User.fromJson(json['user']): null,
        game: json['game'] != null? Game.fromJson(json['game']): null,
        reviewBody: json['review_body'].toString(),
        score: json['score']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['review_id'] = reviewId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (game != null) {
      data['game'] = game!.toJson();
    }
    data['review_body'] = reviewBody;
    data['score'] = score;
    return data;
  }
}
