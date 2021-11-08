import 'package:flutter/material.dart';
import 'package:flutter_front_end/widgets/text/banner_text.dart';

class SearchBanner extends StatelessWidget {
  const SearchBanner({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        children: const [
          Center(
            child: BannerText(text: "Something Something yay (This is a test)"),
          ),
          Expanded(
            child: Center(
              child: Text("Image or something to greet the users"),
            ),
          ),
          Center(
            child: Text("Place to click and open list for games to search"),
          )
        ],
      ),
    );
  }

}