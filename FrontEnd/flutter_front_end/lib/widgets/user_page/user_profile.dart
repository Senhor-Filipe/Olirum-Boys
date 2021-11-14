import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_front_end/models/user.dart';
import 'package:flutter_front_end/models/review.dart';
import 'package:flutter_front_end/models/screen_arguments.dart';
import 'package:flutter_front_end/widgets/responsive.dart';
import 'package:flutter_front_end/widgets/tiles/review_list_tile_user.dart';

class UserProfile extends StatefulWidget {
  final ScreenArguments data;

  const UserProfile({
    Key? key,
    required this.data
  }) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  User? user;
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
          FutureBuilder<User>(
            future: fetchUserById(widget.data.dataId),
            builder: (context, AsyncSnapshot<User> snapshot) {
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
                  user = snapshot.data;
                  return Container(
                    color: Colors.indigo,
                    width: ResponsiveWidget.isSmallScreen(context)?
                    screenSize.width * 0.8:
                    ResponsiveWidget.isMediumScreen(context)?
                    screenSize.width * 0.7:
                    screenSize.width * 0.6,
                    height: ResponsiveWidget.isSmallScreen(context)?
                    screenSize.height * 0.3:
                    ResponsiveWidget.isMediumScreen(context)?
                    screenSize.height * 0.2:
                    screenSize.height * 0.1,
                    child: ResponsiveWidget.isSmallScreen(context)?
                      widget.data.user.userId == user!.userId?
                        LayoutBuilder(
                          builder: (context, constraints) {
                            return Center(
                                child: Text(
                                  "Welcome to your profile page, ${widget.data.user.username}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                )
                            );
                          },
                        ):
                        LayoutBuilder(
                          builder: (context, constraints) {
                            return Center(
                              child: Text(
                                "This is ${user!.username} profile page",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              )
                            );
                          },
                        ):
                    ResponsiveWidget.isMediumScreen(context)?
                      widget.data.user.userId == user!.userId?
                        LayoutBuilder(
                          builder: (context, constraints) {
                            return Center(
                              child: Text(
                                "Welcome to your profile page, ${widget.data.user.username}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              )
                            );
                          },
                        ):
                        LayoutBuilder(
                          builder: (context, constraints) {
                            return Center(
                              child: Text(
                                "This is ${user!.username} profile page",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              )
                            );
                          },
                        ):
                      widget.data.user.userId == user!.userId?
                        LayoutBuilder(
                          builder: (context, constraints) {
                            return Center(
                              child: Text(
                                "Welcome to your profile page, ${widget.data.user.username}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              )
                            );
                          },
                        ):
                        LayoutBuilder(
                          builder: (context, constraints) {
                            return Center(
                              child: Text(
                                "This is ${user!.username} profile page",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              )
                            );
                          },
                        ),
                  );
                }
              }
              return const SizedBox(
                  height: 500,
                  child: Center(
                    child: Text(
                      "This user does not exists!",
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
              future: fetchReviewListByUserId(widget.data.dataId),
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
                      return Container(
                        color: Colors.indigo,
                        child: SizedBox(
                          height: 100,
                          child:
                          widget.data.user.userId == widget.data.dataId?
                          const Center(
                            child: Text(
                              "You have not written any review",
                              overflow: TextOverflow.ellipsis,
                            )
                          ):
                          const Center(
                            child: Text(
                              "This user has no reviews",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
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
                            itemExtent: 200,
                            itemBuilder: (context, index) {
                              return ReviewListTileUser(data: widget.data, review: reviews[index]);
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