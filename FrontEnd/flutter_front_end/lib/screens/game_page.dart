import 'package:flutter/material.dart';
import 'package:flutter_front_end/widgets/game_page/game_grid_view.dart';
import 'package:flutter_front_end/widgets/game_page/game_selected.dart';
import 'package:flutter_front_end/widgets/game_page/search_header.dart';
import 'package:flutter_front_end/widgets/responsive.dart';
import 'package:flutter_front_end/widgets/shared/footer.dart';
import 'package:flutter_front_end/widgets/shared/top_bar_contents.dart';
import 'package:flutter_front_end/widgets/shared/top_bar_drawer.dart';

class GamePage extends StatefulWidget {
  final int data;

  const GamePage({
    Key? key,
    required this.data
  }) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final ScrollController _scrollController = ScrollController();

  _scrollListener() {
    setState(() {});
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        appBar: ResponsiveWidget.isSmallScreen(context)
        // Layout for mobile
            ? AppBar(
          backgroundColor: Colors.indigo,
          title: const Text(
            'Golden Console',
            style: TextStyle(
                color: Colors.amber
            ),
          ),
        )

        // Layout for Web
            : PreferredSize(
          preferredSize: Size(screenSize.width, 1000),
          child: const TopBarContents(),
        ),

        // Calls drawer widget
        drawer: const TopBarDrawer(),

        // Body of the page
        body: SingleChildScrollView(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          child: SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: widget.data == 0 ?
              Column(
                children: [
                  SearchHeader(),
                  GameGridView(),
                  const Footer(),
                ],
              ) :
              Column(
                children: [
                  GameSelected(gameId: widget.data),
                  const Footer()
                ],
              )
          ),
        )
    );
  }
}