import 'package:flutter/material.dart';
import 'package:flutter_front_end/models/game.dart';
import 'package:flutter_front_end/models/screen_arguments.dart';

class SearchHeader extends StatefulWidget {
  final ScreenArguments data;

  const SearchHeader({
    Key? key,
    required this.data
  }) : super(key: key);

  @override
  _SearchHeaderState createState() => _SearchHeaderState();
}

class _SearchHeaderState extends State<SearchHeader> {
  final TextEditingController _filter = TextEditingController();
  List<Game> newDataList = [];
  List<Game> mainDataList = [];
  var listTileColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Container(
      color: Colors.black,
      width: screenSize.width,
      child: Center(
        child: SizedBox(
          width: screenSize.width*0.6,
          height: screenSize.height*0.5,
          child: FutureBuilder<List<Game>> (
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
                  mainDataList = snapshot.data!;
                  return Column(
                    children: [
                      const SizedBox(height: 100),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Focus(
                          onFocusChange: (bool value) async {
                            await Future.delayed(const Duration(milliseconds: 150));
                            if (!value) {
                              setState(() {
                                newDataList = [];
                              });
                            }
                          },
                          child: TextField(
                            autocorrect: false,
                            controller: _filter,
                            decoration: const InputDecoration(
                                hintText: "Search here..."
                            ),
                            onChanged: (String value) {
                              setState(() {
                                newDataList = mainDataList
                                    .where((game) => game.gameName.toLowerCase().contains(value.toLowerCase()))
                                    .toList();
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8.0),
                          children: newDataList.map((data) {
                            return ListTile(
                                title: Text(
                                  data.gameName,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    '/game',
                                    arguments: ScreenArguments(
                                      widget.data.user,
                                      widget.data.logged,
                                      data.gameId
                                    )
                                  );
                                },
                              );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 100)
                    ],
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
            }
          )
        ),
      ),
    );
  }
}