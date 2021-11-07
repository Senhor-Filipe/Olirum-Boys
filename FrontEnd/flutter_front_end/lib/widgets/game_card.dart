import 'package:flutter/material.dart';
import 'package:flutter_front_end/models/game.dart';

class GameCard extends StatelessWidget {
  final Game game;
  const GameCard({
    Key? key,
    required this.game
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/game_cover/${game.cover}"),
                fit: BoxFit.fitHeight,
                alignment: Alignment.topCenter,
            ),
        ),
        child: Text(game.gameName),
      ),
      color: Colors.transparent,
    );
  }
}