import 'dart:convert';
import 'package:http/http.dart';

Future<List<Review>> fetchReviewList() async {
  Response response = await get(Uri.parse("http://127.0.0.1:8080/review"));

  final _extractedData = json.decode(response.body) as Map<String, dynamic>;

  List<Review> _data = [];
  List<Review> _fetchedData = [];

  _extractedData['review_list'].forEach((value) {
    _fetchedData.add(Review(
        reviewId: value['review_id'],
        userId: value['user_id'],
        gameId: value['game_id'],
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
        userId: value['user_id'],
        gameId: value['game_id'],
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
      userId: _extractedData['user_id'],
      gameId: _extractedData['game_id'],
      reviewBody: _extractedData['review_body'],
      score: _extractedData['score']
  );

  _data = _fetchedData;

  return _data;
}

class Review {
  int reviewId;
  int userId;
  int gameId;
  String reviewBody;
  int score;

  Review({
    required this.reviewId,
    required this.userId,
    required this.gameId,
    required this.reviewBody,
    required this.score
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
        reviewId: json['review_id'],
        userId: json['user_id'],
        gameId: json['game_id'],
        reviewBody: json['review_body'].toString(),
        score: json['score']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['review_id'] = reviewId;
    data['user_id'] = userId;
    data['game_id'] = gameId;
    data['review_body'] = reviewBody;
    data['score'] = score;
    return data;
  }
}
