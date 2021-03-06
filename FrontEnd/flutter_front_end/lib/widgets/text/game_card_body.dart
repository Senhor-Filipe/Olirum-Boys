import 'package:flutter/material.dart';
import 'package:flutter_front_end/models/game.dart';

class GameCardBody extends StatelessWidget {
  final Game game;

  const GameCardBody({Key? key,
    required this.game
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 0),
      child: Column(
        children: [
          const Expanded(
            child: Text(""),
          ),
          Stack(
              children: [
                Container(
                  color: Colors.black.withOpacity(0.7),
                  width: 300,
                  height: 40
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      game.gameName,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height/50,
                        color: Colors.white,
                      ),
                    )
                  ),
                )
            ]
          )
        ],
      ),
    );
  }
}