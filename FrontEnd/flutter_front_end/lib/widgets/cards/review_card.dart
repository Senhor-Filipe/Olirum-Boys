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
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                FutureBuilder(
                  future: fetchUserById(widget.review.userId),
                  builder: (context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const CircularProgressIndicator();
                      default:
                        if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}. Please, try again later");
                        } else {
                          return InkWell(
                            hoverColor: Colors.transparent,
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                '/user',
                                arguments: ScreenArguments(
                                  widget.data.username,
                                  widget.data.userId,
                                  widget.data.logged,
                                  widget.review.userId
                                )
                              );
                            },
                            child: Text(snapshot.data.username)
                          );
                        }
                    }
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
                FutureBuilder(
                  future: fetchGameById(widget.review.gameId),
                  builder: (context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const CircularProgressIndicator();
                      default:
                        if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}. Please, try again later");
                        } else {
                          return InkWell(
                            hoverColor: Colors.transparent,
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                '/game',
                                arguments: ScreenArguments(
                                    widget.data.username,
                                    widget.data.userId,
                                    widget.data.logged,
                                    snapshot.data.gameId
                                )
                              );
                            },
                            child: Row(
                              children: [
                                Text(snapshot.data.gameName),
                                const SizedBox(width: 20),
                                Image(
                                  image: AssetImage("assets/images/game_cover/${snapshot.data.cover}"),
                                  height: 50,
                                )
                              ],
                            )
                          );
                        }
                    }
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