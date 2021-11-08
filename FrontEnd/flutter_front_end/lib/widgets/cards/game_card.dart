import 'package:flutter/material.dart';
import 'package:flutter_front_end/models/game.dart';
import 'package:flutter_front_end/models/screen_arguments.dart';
import 'package:flutter_front_end/widgets/text/game_card_body.dart';

class GameCard extends StatefulWidget {

  final ScreenArguments data;
  final Game game;

  const GameCard({
    Key? key,
    required this.game,
    required this.data
  }) : super(key: key);

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.blueGrey,
      // onTap to redirect to Games screen
      onTap: () {
        Navigator.of(context).pushNamed(
          '/game',
          arguments: ScreenArguments(
              widget.data.username,
              widget.data.userId,
              widget.data.logged,
              widget.game.gameId
          )
        );
      },

      // Detects if mouse is hovering
      onHover: (value) {},

      child: Card(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/game_cover/${widget.game.cover}"),
              fit: BoxFit.fitHeight,
              alignment: Alignment.topCenter,
            ),
          ),
          child: GameCardBody(game: widget.game)
        ),
        color: Colors.transparent,
        elevation: 0,
      )
    );
  }
}