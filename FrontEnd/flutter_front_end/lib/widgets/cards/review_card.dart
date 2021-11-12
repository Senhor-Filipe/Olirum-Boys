import 'package:flutter/material.dart';
import 'package:flutter_front_end/models/review.dart';
import 'package:flutter_front_end/models/screen_arguments.dart';
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
                InkWell(
                  hoverColor: Colors.transparent,
                  onTap: () {
                    widget.review.user != null?
                    Navigator.of(context).pushNamed('/user',
                      arguments: ScreenArguments(
                        widget.data.user,
                        widget.data.logged,
                        widget.review.user!.userId)):
                    Navigator.of(context).pushNamed('/error',
                        arguments: ScreenArguments(
                            widget.data.user,
                            widget.data.logged,
                            0))
                    ;
                  },
                  child: widget.review.user != null?
                  Text(widget.review.user!.username):
                  const Text("User not found")
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
                InkWell(
                  hoverColor: Colors.transparent,
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      '/game',
                      arguments: ScreenArguments(
                        widget.data.user,
                        widget.data.logged,
                        widget.review.game!.gameId
                      )
                    );
                  },
                  child: Row(
                    children: [
                      Text(widget.review.game!.gameName),
                      const SizedBox(width: 20),
                      Image(
                        image: AssetImage("assets/images/game_cover/${widget.review.game!.cover}"),
                        height: 50,
                      )
                    ],
                  )
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