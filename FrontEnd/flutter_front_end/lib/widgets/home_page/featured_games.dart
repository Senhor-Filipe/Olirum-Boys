import 'package:flutter/material.dart';
import 'package:flutter_front_end/models/game.dart';
import 'package:flutter_front_end/models/screen_arguments.dart';
import 'package:flutter_front_end/widgets/text/title_1.dart';

import '../cards/game_card.dart';
import '../responsive.dart';

class FeaturedGames extends StatefulWidget {
  final ScreenArguments data;

  const FeaturedGames({
    Key? key,
    required this.data
  }) : super(key: key);

  @override
  _FeaturedGamesState createState() => _FeaturedGamesState();
}

class _FeaturedGamesState extends State<FeaturedGames> {
  List<Game> games = [];
  Game gameDefault = Game(
      gameId: 0,
      gameName: "NO DATA",
      developer: "NO DATA",
      genre: "NO DATA",
      cover: "no_cover.jpg"
  );

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SizedBox(
      // Box measurements
      height: screenSize.height * 0.6,
      width: screenSize.width,

      // SizedBox child
      child: Container(
        color: Colors.black45,
        child: Column(

          //Columns Children
          children: <Widget> [

            // Divider
            const SizedBox(height: 10),

            // First child
            const Title1(text: "Featured Games"),

            //Second child
            FutureBuilder<List<Game>>(
              //FutureBuilder main parameters
              future: fetchGameList(),
              builder: (context, AsyncSnapshot<List<Game>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.hasError) {
                    return Flexible(
                      child: Center(
                        child: Text(
                          "Error: ${snapshot.error}. Please, try again later",
                          overflow: TextOverflow.ellipsis,
                        )
                      ),
                    );
                  } else {
                    games = snapshot.data!;
                    if (games.length < 5) {
                      games.add(gameDefault);
                      games.add(gameDefault);
                      games.add(gameDefault);
                      games.add(gameDefault);
                      games.add(gameDefault);
                    }
                    return Expanded(
                      // Expanded child
                      child: Container(

                        // Decorations
                        padding: EdgeInsets.only(
                          left: screenSize.width * 0.025,
                          right: screenSize.width * 0.025,
                          top: 45.0,
                          bottom: 55.0),

                        // Padding Child
                        child: ResponsiveWidget.isSmallScreen(context)?

                          // GridView for small Screen
                          Row(
                            children: [
                              SizedBox(
                                child: GameCard(
                                  game: games[0],
                                  data: widget.data
                                ),
                                width: screenSize.width * 0.45,
                              ),
                              SizedBox(
                                width: screenSize.width * 0.05
                              ),
                              SizedBox(
                                child: GameCard(
                                  game: games[1],
                                  data: widget.data
                                ),
                                width: screenSize.width * 0.45,
                              ),
                            ],
                          ):

                          // GridView for medium Screen
                          ResponsiveWidget.isMediumScreen(context)?
                          Row(
                            children: [
                              SizedBox(
                                child: GameCard(
                                  game: games[0],
                                  data: widget.data
                                ),
                                width: screenSize.width * 0.20,
                              ),
                              SizedBox(
                                width: screenSize.width * 0.05
                              ),
                              SizedBox(
                                child: GameCard(
                                  game: games[1],
                                  data: widget.data
                                ),
                                width: screenSize.width * 0.20,
                              ),
                              SizedBox(
                                width: screenSize.width * 0.05
                              ),
                              SizedBox(
                                child: GameCard(
                                  game: games[2],
                                  data: widget.data
                                ),
                                width: screenSize.width * 0.20,
                              ),
                              SizedBox(
                                width: screenSize.width * 0.05
                              ),
                              SizedBox(
                                child: GameCard(
                                  game: games[3],
                                  data: widget.data),
                                width: screenSize.width * 0.20,
                              ),
                            ],
                          ):

                          // GridView for large screen
                          Row(
                            children: [
                              SizedBox(
                                child: GameCard(
                                  game: games[0],
                                  data: widget.data
                                ),
                                width: screenSize.width * 0.15,
                              ),
                              SizedBox(
                                width: screenSize.width * 0.05
                              ),
                              SizedBox(
                                child: GameCard(
                                  game: games[1],
                                  data: widget.data
                                ),
                                width: screenSize.width * 0.15,
                              ),
                              SizedBox(
                                width: screenSize.width * 0.05
                              ),
                              SizedBox(
                                child: GameCard(
                                  game: games[2],
                                  data: widget.data
                                ),
                                width: screenSize.width * 0.15,
                              ),
                              SizedBox(
                                width: screenSize.width * 0.05
                              ),
                              SizedBox(
                                child: GameCard(
                                  game: games[3],
                                  data: widget.data
                                ),
                                width: screenSize.width * 0.15,
                              ),
                              SizedBox(
                                width: screenSize.width * 0.05
                              ),
                              SizedBox(
                                child: GameCard(
                                  game: games[4],
                                  data: widget.data),
                                width: screenSize.width * 0.15,
                              ),
                            ],
                          )
                      )
                    );
                  }
                }
                return const Flexible(
                    child: Center(
                      child: Text(
                        "No game has been found on the database!",
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                );
              },
            )
          ],
        ),
      )
    );
  }
}