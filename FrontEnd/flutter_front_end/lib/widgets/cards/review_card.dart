import 'package:flutter/material.dart';
import 'package:flutter_front_end/models/game.dart';
import 'package:flutter_front_end/models/review.dart';
import 'package:flutter_front_end/models/screen_arguments.dart';
import 'package:flutter_front_end/models/user.dart';
import 'package:flutter_front_end/widgets/responsive.dart';

class ReviewCard extends StatefulWidget {

  final Review review;
  final ScreenArguments data;

  const ReviewCard({
    Key? key,
    required this.review,
    required this.data
  }) : super(key: key);

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  User? user;
  Game? game;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                FutureBuilder<User>(
                  future: fetchUserById(widget.review.userId),
                  builder: (context, AsyncSnapshot<User> snapshot) {
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
                        user = snapshot.data;
                        return InkWell(
                          hoverColor: Colors.transparent,
                          onTap: () {
                            Navigator.of(context).pushNamed('/user',
                              arguments: ScreenArguments(
                                widget.data.username,
                                widget.data.userId,
                                widget.data.logged,
                                widget.review.userId));
                          },
                          child: Text(user!.username)
                        );
                      }
                    }
                    return const Flexible(
                      child: Center(
                        child: Text(
                          "NO DATA",
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    );
                  }
                ),
                const Expanded(child: Text("")),
                Text("${widget.review.score.toString()}/10")
              ],
            ),
            const SizedBox(height: 10),
            Container(
              height: 2,
              width: ResponsiveWidget.isSmallScreen(context)?350:ResponsiveWidget.isMediumScreen(context)?400:450,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Text(
                widget.review.reviewBody,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15
                ),
              ),
            ),
            Row(
              children: [
                const Expanded(child: Text("")),
                FutureBuilder<Game>(
                  future: fetchGameById(widget.review.gameId),
                  builder: (context, AsyncSnapshot<Game> snapshot) {
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
                        game = snapshot.data;
                        return InkWell(
                          hoverColor: Colors.transparent,
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              '/game',
                              arguments: ScreenArguments(
                                widget.data.username,
                                widget.data.userId,
                                widget.data.logged,
                                game!.gameId
                              )
                            );
                          },
                          child: Row(
                            children: [
                              Text(game!.gameName),
                              const SizedBox(width: 20),
                              Image(
                                image: AssetImage("assets/images/game_cover/${game!.cover}"),
                                height: 50,
                              )
                            ],
                          )
                        );
                      }
                    }
                    return const Flexible(
                      child: Center(
                        child: Text(
                          "NO DATA",
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    );
                  }
                )
              ],
            )
          ],
        ),
      ),

      color: const Color(0xFF141434),
    );
  }
}