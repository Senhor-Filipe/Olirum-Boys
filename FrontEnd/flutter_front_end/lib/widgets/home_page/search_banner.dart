import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_front_end/models/screen_arguments.dart';
import 'package:flutter_front_end/widgets/responsive.dart';

class SearchBanner extends StatelessWidget {
  final ScreenArguments data;
  
  const SearchBanner({
    Key? key,
    required this.data
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 400,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            alignment: FractionalOffset.topCenter,
            image: AssetImage("assets/images/site_image/banner.jpg")
          )
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Welcome to our review site!",
                        style: TextStyle(
                          fontSize: 30
                        )
                      ),
                      SizedBox(height: 30),
                      Text("This site was developed by Computer Engineering Students of Maua Technology Institute"),
                      SizedBox(height: 10),
                      Text(
                        "In this site, you may check other's review on a game and upload, update and delete your own review as long as you're logged",
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Click on the icon below to search for a game to review",
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  )
                )
              ),
            ),
            Container(
              color: Colors.indigo,
              padding: const EdgeInsets.all(20),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(
                      '/game',
                      arguments: data
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      ResponsiveWidget.isSmallScreen(context)?
                          "Search":
                          "Click this field to search a new game to review"
                    ),
                    const SizedBox(width: 20),
                    const Icon(Icons.search_sharp)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20)
          ],
        )
      ),
    );
  }

}