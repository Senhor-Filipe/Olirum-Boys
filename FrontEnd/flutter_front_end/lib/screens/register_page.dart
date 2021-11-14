import 'package:flutter/material.dart';
import 'package:flutter_front_end/models/screen_arguments.dart';
import 'package:flutter_front_end/widgets/login_register_page/register.dart';
import 'package:flutter_front_end/widgets/responsive.dart';
import 'package:flutter_front_end/widgets/shared/footer.dart';
import 'package:flutter_front_end/widgets/shared/top_bar_contents.dart';
import 'package:flutter_front_end/widgets/shared/top_bar_drawer.dart';

class RegisterPage extends StatefulWidget {
  final ScreenArguments data;

  const RegisterPage({
    Key? key,
    required this.data
  }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
            user: widget.data.user,
            logged: widget.data.logged
        ),
      ),

      // Calls drawer widget
      drawer: TopBarDrawer(
          user: widget.data.user,
          logged: widget.data.logged
      ),

      // Body of the page
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const ClampingScrollPhysics(),
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: const [
                Register(),
                Footer(),
              ],
            )
        ),
      ),
    );
  }
}