import 'package:flutter/material.dart';
import 'package:flutter_front_end/models/review.dart';
import 'package:flutter_front_end/models/screen_arguments.dart';

class ReviewListTileUser extends StatefulWidget {
  final ScreenArguments data;
  final Review review;

  const ReviewListTileUser({
    Key? key,
    required this.data,
    required this.review
  }) : super(key: key);

  @override
  _ReviewListTileUserState createState() => _ReviewListTileUserState();
}

class _ReviewListTileUserState extends State<ReviewListTileUser> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListTile(
        tileColor: Colors.indigo,
        leading: Text(
          widget.review.score.toString(),
          style: const TextStyle(
              fontSize: 20
          ),
        ),
        title: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: InkWell(
                hoverColor: Colors.transparent,
                onTap: () {
                  Navigator.of(context).pushNamed('/game',
                      arguments: ScreenArguments(
                          widget.data.user,
                          widget.data.logged,
                          widget.review.game!.gameId));
                },
                child: Text(widget.review.game!.gameName)
            )
        ),
        subtitle: Container(
          margin: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/user',
                      arguments: ScreenArguments(
                          widget.data.user,
                          widget.data.logged,
                          widget.review.game!.gameId));
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    widget.review.reviewBody,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 6,
                  ),
                ),
              ),
              const Expanded(child: Text("")),
              Image(
                image: AssetImage("assets/images/game_cover/${widget.review.game!.cover}"),
                height: 130,
              ),
              const SizedBox(width: 20)
            ],
          ),
        ),
      ),
    );
  }

}