import 'package:flutter/material.dart';
import 'package:flutter_front_end/models/game.dart';
import 'package:flutter_front_end/models/review.dart';
import 'package:flutter_front_end/models/screen_arguments.dart';

// TODO implement review post

class ReviewUpload extends StatefulWidget {
  final ScreenArguments data;

  const ReviewUpload({
    Key? key,
    required this.data
  }) : super(key: key);

  @override
  _ReviewUploadState createState() => _ReviewUploadState();
}

class _ReviewUploadState extends State<ReviewUpload> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  List<Game>? games;
  List<int> scoreInt = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  String _currentSelectedValue = '';
  int _currentScore = 0;

  @override
  Widget build(BuildContext context) {
    Review review = Review(
        reviewId: 0,
        user: widget.data.user,
        game: null,
        reviewBody: "",
        score: 0
    );
    var screenSize = MediaQuery.of(context).size;

    return SizedBox(
        width: screenSize.width*0.6,
        height: screenSize.height*0.8,

        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                Container(
                  height: 30,
                  padding: EdgeInsets.all(constraints.maxWidth*0.1),
                  child: FutureBuilder<List<Game>>(
                    future: fetchGameList(),
                    builder: (context, AsyncSnapshot<List<Game>> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.hasError) {
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
                          games = snapshot.data;
                          return FormField<String>(
                            builder: (FormFieldState<String> state) {
                              return InputDecorator(
                                decoration: const InputDecoration(
                                  hintText: 'Select your game',
                                ),
                                isEmpty: _currentSelectedValue == '',
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _currentSelectedValue,
                                    isDense: true,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _currentSelectedValue = newValue!;
                                        state.didChange(newValue);
                                      });
                                    },
                                    items: games!.map((Game value) {
                                      return DropdownMenuItem<String>(
                                        value: value.gameName,
                                        child: Text(value.gameName),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      }
                      return const SizedBox(
                        height: 300,
                        child: Center(
                          child: Text(
                            "No game has been found on the database!",
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.text,
                  onSaved: (input) => review.reviewBody = input!.toString(),
                  decoration: const InputDecoration(
                    hintText: "Write your review here",
                  ),
                  maxLines: 50,
                ),
                const SizedBox(height: 10),
                FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: const InputDecoration(
                        hintText: 'Score',
                      ),
                      isEmpty: _currentScore == 0,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          value: _currentScore,
                          isDense: true,
                          onChanged: (int? newValue) {
                            setState(() {
                              _currentScore = newValue!;
                            });
                          },
                          items: scoreInt.map((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    //TODO upload http request
                  },
                  child: const Center(
                    child: Text(
                        "Upload"
                    ),
                  ),
                )
              ],
            );
          },
        )
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}