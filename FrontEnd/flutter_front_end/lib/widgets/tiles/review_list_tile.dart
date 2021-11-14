import 'package:flutter/material.dart';
import 'package:flutter_front_end/models/review.dart';
import 'package:flutter_front_end/models/screen_arguments.dart';

class ReviewListTile extends StatefulWidget {
  final ScreenArguments data;
  final Review review;

  const ReviewListTile({
    Key? key,
    required this.data,
    required this.review
  }) : super(key: key);

  @override
  _ReviewListTileState createState() => _ReviewListTileState();
}

class _ReviewListTileState extends State<ReviewListTile> {
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
              Navigator.of(context).pushNamed('/user',
                  arguments: ScreenArguments(
                      widget.data.user,
                      widget.data.logged,
                      widget.review.user!.userId));
            },
            child: Text(widget.review.user!.username)
          )
        ),
        subtitle: Container(
          margin: const EdgeInsets.only(top: 10),
          child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/user',
                    arguments: ScreenArguments(
                        widget.data.user,
                        widget.data.logged,
                        widget.review.user!.userId));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 10, right: 30),
                child: Text(
                  widget.review.reviewBody,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 6,
                ),
              ),
          ),
        ),
      ),
    );
  }

}