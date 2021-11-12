import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_front_end/models/game.dart';
import 'package:flutter_front_end/models/review.dart';
import 'package:flutter_front_end/models/screen_arguments.dart';
import 'package:flutter_front_end/widgets/responsive.dart';
import 'package:flutter_front_end/widgets/tiles/review_list_tile.dart';

class GameSelected extends StatefulWidget {
  final ScreenArguments data;

  const GameSelected({
    Key? key,
    required this.data
  }) : super(key: key);

  @override
  _GameSelectedState createState() => _GameSelectedState();
}

class _GameSelectedState extends State<GameSelected> {
  Game? game;
  List<Review> reviews = [];
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      color: Colors.black38,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 0),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          FutureBuilder<Game>(
            future: fetchGameById(widget.data.dataId),
            builder: (context, AsyncSnapshot<Game> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.hasError) {
                  return SizedBox(
                    height: 500,
                    child: Center(
                      child: Text(
                        "Error: ${snapshot.error}. Please, try again later",
                        overflow: TextOverflow.ellipsis,
                      )
                    ),
                  );
                } else {
                  game = snapshot.data;
                  return Container(
                    color: Colors.indigo,
                    width: ResponsiveWidget.isSmallScreen(context)?
                      screenSize.width * 0.8:
                      ResponsiveWidget.isMediumScreen(context)?
                      screenSize.width * 0.7:
                      screenSize.width * 0.6,
                    child: ResponsiveWidget.isSmallScreen(context)?
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(15),
                            child: Image(
                              image: AssetImage(
                                "assets/images/game_cover/${game!.cover}"),
                              height: screenSize.height * 0.25,
                            ),
                          ),
                          Text(game!.gameName),
                          Text(game!.developer),
                          Text(game!.genre),
                          const SizedBox(height: 15)
                        ],
                      ):
                      ResponsiveWidget.isMediumScreen(context)?
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(25),
                              child: Image(
                                image: AssetImage(
                                  "assets/images/game_cover/${game!.cover}"),
                                height: screenSize.height * 0.3,
                              ),
                            ),
                            const Expanded(child: Text("")),
                            SizedBox(
                              width: screenSize.width * 0.3,
                              child: Column(
                                crossAxisAlignment:
                                  CrossAxisAlignment.end,
                                children: [
                                  const SizedBox(height: 10),
                                  Text(
                                    game!.gameName,
                                    style: const TextStyle(
                                      fontSize: 25,
                                      overflow: TextOverflow.ellipsis),
                                  ),
                                  SizedBox(
                                      height: screenSize.height * 0.15),
                                  Text("Developer: ${game!.developer}"),
                                  const SizedBox(height: 8),
                                  Text("Genre: ${game!.genre}"),
                                  const SizedBox(height: 15),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20)
                          ],
                        ):
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(25),
                              child: Image(
                                image: AssetImage(
                                  "assets/images/game_cover/${game!.cover}"),
                                height: screenSize.height * 0.4,
                              ),
                            ),
                            const Expanded(child: Text("")),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const SizedBox(height: 15),
                                Text(
                                  game!.gameName,
                                  style: const TextStyle(fontSize: 40),
                                ),
                                SizedBox(height: screenSize.height * 0.2),
                                Text("Developer: ${game!.developer}"),
                                const SizedBox(height: 10),
                                Text("Genre: ${game!.genre}"),
                                const SizedBox(height: 20),
                              ],
                            ),
                            const SizedBox(width: 50)
                          ],
                        ),
                  );
                }
              }
              return const SizedBox(
                height: 500,
                child: Center(
                  child: Text(
                    "No game has been found on the database!",
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              );
            },
          ),
          SizedBox(height: screenSize.height*0.05),
          Container(
            padding: const EdgeInsets.only(top: 30),
            width: ResponsiveWidget.isSmallScreen(context)?
            screenSize.width * 0.8:
            ResponsiveWidget.isMediumScreen(context)?
            screenSize.width * 0.7:
            screenSize.width * 0.6,
            child: FutureBuilder (
              future: fetchReviewListByGameId(widget.data.dataId),
              builder: (context, AsyncSnapshot snapshot) {
                if(snapshot.hasData) {
                  if(snapshot.hasError) {
                    return SizedBox(
                      height: 300,
                      child: Center(
                        child: Text(
                          "Error: ${snapshot.error}. Please, try again later",
                            overflow: TextOverflow.ellipsis,
                        )
                      ),
                    );
                  } else {
                    reviews = snapshot.data;
                    if (reviews.isEmpty) {
                      return const SizedBox(
                        height: 100,
                        child: Center(
                          child: Text(
                            "There are no reviews for this game",
                            overflow: TextOverflow.ellipsis,
                          )
                        ),
                      );
                    }
                    return Column(
                      children: [
                        SizedBox(
                          height: counter + 1 >= reviews.length?
                            reviews.length*200 + 50:
                            (counter + 1)*200 + 50,
                          child: ListView.builder(
                            itemCount: counter + 1 >= reviews.length?
                              reviews.length:
                              counter + 1,
                            itemExtent: 210,
                            itemBuilder: (context, index) {
                              return ReviewListTile(data: widget.data, review: reviews[index]);
                            },
                          ),
                        ),
                        Center(
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                counter = counter + 1;
                              });
                            },
                            child: counter + 1 >= reviews.length?
                              const Text("You reached the end"):
                              const Text("View more"),
                          ),
                        )
                      ],
                    );
                  }
                }
                return const SizedBox(
                  height: 300,
                  child: Center(
                    child: Text(
                      "No review has been found on the database!",
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                );
              },
            ),
          )
        ],
      ),
    );
  }
}