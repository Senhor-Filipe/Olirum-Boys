import 'package:flutter/material.dart';
import 'package:flutter_front_end/models/screen_arguments.dart';
import 'package:flutter_front_end/widgets/home_page/featured_games.dart';
import 'package:flutter_front_end/widgets/home_page/recent_reviews.dart';
import 'package:flutter_front_end/widgets/home_page/search_banner.dart';
import 'package:flutter_front_end/widgets/responsive.dart';
import 'package:flutter_front_end/widgets/shared/footer.dart';
import 'package:flutter_front_end/widgets/shared/top_bar_contents.dart';
import 'package:flutter_front_end/widgets/shared/top_bar_drawer.dart';

class HomePage extends StatefulWidget {
  final ScreenArguments data;

  const HomePage({
    Key? key,
    required this.data
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      // Verifies the screen size of the device to load correct layout
      appBar: ResponsiveWidget.isSmallScreen(context)
        // Layout for mobile
        ? AppBar(
          backgroundColor: Colors.indigo  ,
          title: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                  '/',
                  arguments: widget.data
              );
            },

            child: const Text(
              'Golden Console',
              style: TextStyle(
                color: Colors.amber
              )
            ),
          ),
        )

        // Layout for Web
        : PreferredSize(
          preferredSize: Size(screenSize.width, 1000),
          child: TopBarContents(
            userId: widget.data.userId,
            username: widget.data.username,
            logged: widget.data.logged
          ),
        ),

      // Calls drawer widget
      drawer: TopBarDrawer(
        userId: widget.data.userId,
        username: widget.data.username,
        logged: widget.data.logged
      ),

      // Body of the page
      body: SingleChildScrollView(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SearchBanner(data: widget.data,),
                FeaturedGames(data: widget.data),
                RecentReviews(data: widget.data),
                const Footer(),
              ],
            ),
          )
      ),
    );
  }
}