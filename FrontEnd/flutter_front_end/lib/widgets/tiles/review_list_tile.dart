import 'package:flutter/material.dart';
import 'package:flutter_front_end/models/review.dart';
import 'package:flutter_front_end/models/screen_arguments.dart';
import 'package:flutter_front_end/models/user.dart';

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
  User? user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.indigo,
      leading: Text(
        widget.review.score.toString(),
        style: const TextStyle(
          fontSize: 20
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: FutureBuilder<User>(
            future: fetchUserById(widget.review.userId),
            builder: (context, AsyncSnapshot<User> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.hasError) {
                  return Text(
                    "Error: ${snapshot.error}. Please, try again later",
                    overflow: TextOverflow.ellipsis,
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
              return const Text(
                "USER NOT FOUND",
                overflow: TextOverflow.ellipsis,
              );
            }
        ),
      ),
      subtitle: Container(
        margin: const EdgeInsets.only(top: 20),
        child: Text(
          widget.review.reviewBody,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

}