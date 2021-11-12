import 'package:flutter/material.dart';
import 'package:flutter_front_end/models/game.dart';
import 'package:flutter_front_end/models/screen_arguments.dart';
import 'package:flutter_front_end/widgets/cards/game_card.dart';
import 'package:flutter_front_end/widgets/responsive.dart';

class GameGridView extends StatefulWidget {
  final ScreenArguments data;

  const GameGridView({
    Key? key,
    required this.data
  }) : super(key: key);

  @override
  _GameGridViewState createState() => _GameGridViewState();
}

class _GameGridViewState extends State<GameGridView> {
  List<Game> games = [];
  
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width*0.8,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 0),
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
              games = snapshot.data!;
              var gridHeight =
                ResponsiveWidget.isSmallScreen(context)?(games.length%2 == 0)?(games.length/2)*200:(games.length/2)*200 + 200:
                ResponsiveWidget.isMediumScreen(context)?(games.length%3 == 0)?(games.length/3)*200:(games.length/3)*200 + 200:
                (games.length%5 == 0)?(games.length/5)*200:(games.length/5)*200 + 200;
              return SizedBox(
                height: gridHeight,
                child: GridView.builder(
                  itemCount: games.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: ResponsiveWidget.isSmallScreen(context)? 2:
                                    ResponsiveWidget.isMediumScreen(context)? 3: 5,
                    childAspectRatio: ResponsiveWidget.isSmallScreen(context)? 2/4: ResponsiveWidget.isMediumScreen(context)? 3/4: 5/4,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15
                  ),
                  itemBuilder: (context, int index) {
                    return GridTile(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              '/game',
                              arguments: ScreenArguments(
                                  widget.data.user,
                                  widget.data.logged,
                                  games[index].gameId
                              )
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/game_cover/${games[index].cover}')
                            )
                          ),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return SizedBox(
                                width: constraints.maxWidth,
                                height: constraints.maxHeight,
                                child: Column(
                                  children: [
                                    SizedBox(height: constraints.maxHeight*0.4),
                                    Container(
                                      height: constraints.maxHeight*0.2,
                                      color: Colors.black.withOpacity(0.8),
                                      child: Center(
                                        child: Text(
                                          games[index].gameName,
                                          overflow: TextOverflow.ellipsis
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: constraints.maxHeight*0.4)
                                  ],
                                ),
                              );
                            },
                          )
                        ),
                      ),
                    );
                  },
                ),
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
      )
    );
  }

  gameGridTile() {}
}