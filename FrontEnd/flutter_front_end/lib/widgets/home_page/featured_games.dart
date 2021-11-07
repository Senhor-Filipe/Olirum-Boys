import 'package:flutter/material.dart';
import 'package:flutter_front_end/models/game.dart';
import 'package:flutter_front_end/text/title_1.dart';

import '../game_card.dart';
import '../responsive.dart';

class FeaturedGames extends StatefulWidget {
  const FeaturedGames({
    Key? key
  }) : super(key: key);

  @override
  _FeaturedGamesState createState() => _FeaturedGamesState();
}

class _FeaturedGamesState extends State<FeaturedGames> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Box measurements
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,

      // SizedBox child
      child: Column(

        //Columns Children
        children: <Widget> [

          // First child
          const Title1(text: "Top Games"),

          //Second child
          FutureBuilder(

            //FutureBuilder main parameters
            future: fetchGameList(),
            builder: (context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Text("Loading...");
                default:
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    return Expanded(
                        // TODO: Fix image position
                        // Expanded child
                        child: Padding(

                            // Padding main parameter
                            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 50),

                            // Padding Child
                            child: ResponsiveWidget.isSmallScreen(context)

                                // GridView for small Screen
                              ? GridView.count(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: MediaQuery.of(context).size.width / 70,
                                  children: [
                                    GameCard(game: snapshot.data[0]),
                                    GameCard(game: snapshot.data[1])
                                  ],
                              )

                                // GridView for medium Screen
                                : ResponsiveWidget.isMediumScreen(context)
                                ? GridView.count(
                                    crossAxisCount: 4,
                                    crossAxisSpacing: MediaQuery.of(context).size.width / 70,
                                    children: [
                                      GameCard(game: snapshot.data[0]),
                                      GameCard(game: snapshot.data[1]),
                                      GameCard(game: snapshot.data[2]),
                                      GameCard(game: snapshot.data[3])
                                    ],
                                )

                                // GridView for large screen
                                : GridView.count(
                                    crossAxisCount: 6,
                                    crossAxisSpacing: MediaQuery.of(context).size.width / 70,
                                    children: [
                                      GameCard(game: snapshot.data[0]),
                                      GameCard(game: snapshot.data[1]),
                                      GameCard(game: snapshot.data[2]),
                                      GameCard(game: snapshot.data[3]),
                                      GameCard(game: snapshot.data[4]),
                                      GameCard(game: snapshot.data[5])
                                    ]
                                )
                        )
                    );
                  }
              }
            },
          )
        ],
      ),
    );
  }
}