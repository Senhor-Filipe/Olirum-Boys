import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_front_end/models/game.dart';
import 'package:flutter_front_end/models/review.dart';
import 'package:flutter_front_end/models/screen_arguments.dart';
import 'package:flutter_front_end/widgets/cards/review_card.dart';
import 'package:flutter_front_end/widgets/responsive.dart';

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
  List<Review>? reviews = [];
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      color: Colors.black38,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 0),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          FutureBuilder<Game>(
            future: fetchGameById(widget.data.dataId),
            builder: (context, AsyncSnapshot<Game> snapshot) {
              game = snapshot.data;
              if (game == null) {
                return Container();
              }
              if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}. Please, try again later");
              } else {
                return Container(
                  color: Colors.indigo,
                  width: ResponsiveWidget.isSmallScreen(context)?screenSize.width*0.8:
                  ResponsiveWidget.isMediumScreen(context)?screenSize.width*0.7:
                  screenSize.width*0.6,
                  child: ResponsiveWidget.isSmallScreen(context)?
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Image(
                            image: AssetImage("assets/images/game_cover/${game!.cover}"),
                            height: screenSize.height*0.25,
                          ),
                        ),
                        Text(game!.gameName),
                        Text(game!.developer),
                        Text(game!.genre),
                        const SizedBox(height: 15)
                      ],
                    ): ResponsiveWidget.isMediumScreen(context)?
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(25),
                          child: Image(
                            image: AssetImage("assets/images/game_cover/${game!.cover}"),
                            height: screenSize.height*0.3,
                          ),
                        ),
                        const Expanded(child: Text("")),
                        Container(
                          width: screenSize.width*0.3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                game!.gameName,
                                style: const TextStyle(fontSize: 25, overflow: TextOverflow.ellipsis),
                              ),
                              SizedBox(height: screenSize.height*0.15),
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
                            image: AssetImage("assets/images/game_cover/${game!.cover}"),
                            height: screenSize.height*0.4,
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
                            SizedBox(height: screenSize.height*0.2),
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
            },
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: screenSize.width*0.8,
            child: FutureBuilder<List<Review>> (
              future: fetchReviewListByGameId(widget.data.dataId),
              builder: (context, AsyncSnapshot<List<Review>> snapshot) {
                // This is monstrous
                reviews!.add(snapshot.data![counter]);
                if (reviews!.isEmpty) {
                  return Container();
                }
                if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}. Please, try again later");
                } else {
                  return ListView.builder(
                    itemCount: reviews!.length,
                    itemBuilder: (context, itemIndex) {
                      return ReviewCard(review: reviews![itemIndex], data: widget.data);
                    }
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}