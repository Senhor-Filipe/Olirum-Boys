import 'package:flutter/material.dart';
import 'package:flutter_front_end/models/review.dart';
import 'package:flutter_front_end/models/screen_arguments.dart';
import 'package:flutter_front_end/widgets/cards/review_card.dart';
import 'package:flutter_front_end/widgets/responsive.dart';
import 'package:flutter_front_end/widgets/text/title_1.dart';


class RecentReviews extends StatefulWidget {
  final ScreenArguments data;

  const RecentReviews({
    Key? key,
    required this.data
  }) : super(key: key);

  @override
  _RecentReviewsState createState() => _RecentReviewsState();
}

class _RecentReviewsState extends State<RecentReviews> {
  List<Review> reviews = [];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SizedBox(
      // Box measurements
        height: 500,
        width: screenSize.width,

        // SizedBox child
        child: Container(
          color: Colors.black12,
          child: Column(

            //Columns Children
            children: <Widget> [

              // Divider
              const SizedBox(height: 10),

              // First child
              const Title1(text: "Recent reviews"),

              // Divider
              const SizedBox(height: 10),

              //Second child
              FutureBuilder<List<Review>>(

                //FutureBuilder main parameters
                future: fetchReviewList(),
                builder: (context, AsyncSnapshot<List<Review>> snapshot) {
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
                      reviews = snapshot.data!;
                      return Expanded(
                        // Expanded child
                        child: Container(

                          // Decorations
                          padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.025,
                            vertical: 50.0
                          ),

                          // Padding Child
                          child: ResponsiveWidget.isSmallScreen(context)?

                            // GridView for small Screen
                            Row(
                              children: [
                                SizedBox(
                                  child: ReviewCard(review: reviews[0], data: widget.data),
                                  width: screenSize.width * 0.95,
                                )
                              ],
                            ):

                            // GridView for medium Screen
                            ResponsiveWidget.isMediumScreen(context)?
                            Row(
                              children: [
                                SizedBox(
                                  child: ReviewCard(review: reviews[0], data: widget.data),
                                  width: screenSize.width * 0.45,
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.05
                                ),
                                SizedBox(
                                  child: ReviewCard(review: reviews[1], data: widget.data),
                                  width: screenSize.width * 0.45,
                                )
                              ],
                            ):

                            // GridView for large screen
                            Row(
                              children: [
                                SizedBox(
                                  child: ReviewCard(review: reviews[0], data: widget.data),
                                  width: screenSize.width * 0.3,
                                ),
                                SizedBox(
                                    width: screenSize.width * 0.025
                                ),
                                SizedBox(
                                  child: ReviewCard(review: reviews[1], data: widget.data),
                                  width: screenSize.width * 0.3,
                                ),
                                SizedBox(
                                    width: screenSize.width * 0.025
                                ),
                                SizedBox(
                                  child: ReviewCard(review: reviews[2], data: widget.data),
                                  width: screenSize.width * 0.3,
                                )
                              ],
                            )
                        )
                      );
                    }
                  }
                  return const Flexible(
                    child: Center(
                      child: Text(
                        "No review has been found on the database!",
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  );
                },
              )
            ],
          ),
        )
    );
  }
}