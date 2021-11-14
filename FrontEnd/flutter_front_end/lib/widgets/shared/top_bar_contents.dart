import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:flutter_front_end/models/screen_arguments.dart';
import 'package:flutter_front_end/models/user.dart';

class TopBarContents extends StatefulWidget {
  final User user;
  final bool logged;

  const TopBarContents({
    Key? key,
    required this.user,
    required this.logged
  }) : super(key: key);

  @override
  _TopBarContentsState createState() => _TopBarContentsState();
}

class _TopBarContentsState extends State<TopBarContents> {
  // List containing onHover state. Each for every onHover item
  final List _isHovering = [
    false,
    false,
    false,
    false,
    false,
  ];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return PreferredSize(
      // Sets the preferred size of screen for this Widget
      preferredSize: Size(screenSize.width, 1000),

      // Contains the items and characteristics of the Top Bar
      child: Container(
        // Defines the color of the Top Bar
        color: Colors.indigo,

        // Padding to distance the items from the edge
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),

          // Sets a row to include the items of the top bar
          child: Row(
            // Sets items to be in the center of the crossed axis (Row - Y-axis | Column - X-axis)
            crossAxisAlignment: CrossAxisAlignment.center,

            // Sets the items of the row
            children: [
              // First item
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    '/',
                    arguments: ScreenArguments(
                        widget.user,
                        widget.logged,
                        0
                    )
                  );
                },

                // Class body
                child: const Text(
                  'Golden Console',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 2,
                  ),
                ),
              ),

              // Expanded - Flexible width, filling all the space between the item before and after it
              Expanded(
                // Sets a row to include the items of the Expanded class
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Divides the previous Row children with the next
                    SizedBox(width: screenSize.width / 10),

                    // InkWell for item "Games"
                    InkWell(
                      // Sets onHover for InkWell to change color
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[0] = true
                              : _isHovering[0] = false;
                        });
                      },

                      // onTap to redirect to Games screen
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            '/game',
                            arguments: ScreenArguments(
                                widget.user,
                                widget.logged,
                                0
                            )
                        );
                      },

                      // Sets a column to include the items of the InkWell class
                      child: Column(
                        // Minimize the amount of the free space the Column has inside the Padding
                        mainAxisSize: MainAxisSize.min,

                        // Sets the items of the columns
                        children: [
                          // Sets first column, first item
                          Text(
                            'Games',
                            style: TextStyle(
                              color: _isHovering[0]
                                  ? Colors.blue.shade200 // If the mouse is hovering
                                  : Colors.white,        // If the mouse is not hovering
                            ),
                          ),

                          // Separates the item above and below
                          const SizedBox(height: 5),

                          // Sets when a item is visible or not
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: _isHovering[0],

                            // Sets a line to appear if the onHover is true
                            child: Container(
                              height: 2,
                              width: 20,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),

                    // Divides the previous Row children with the next
                    SizedBox(width: screenSize.width / 20),

                    // InkWell for item "Genres
                    InkWell(
                      // Sets onHover for InkWell to change color
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[1] = true
                              : _isHovering[1] = false;
                        });
                      },

                      // onTap to redirect to Games screen
                      onTap: () {
                        html.window.open("https://github.com/Senhor-Filipe/Olirum-Boys/", "_blank");
                      },

                      // Sets a column to include the items of the InkWell class
                      child: Column(
                        // Minimize the amount of the free space the Column has inside the Padding
                        mainAxisSize: MainAxisSize.min,

                        // Sets the items of the columns
                        children: [
                          // Sets second column, first item
                          Text(
                            'Source Code',
                            style: TextStyle(
                              color: _isHovering[1]
                                  ? Colors.blue.shade200 // If the mouse is hovering
                                  : Colors.white,        // If the mouse is not hovering
                            ),
                          ),

                          // Separates the item above and below
                          const SizedBox(height: 5),

                          // Sets when a item is visible or not
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: _isHovering[1],

                            // Sets a line to appear if the onHover is true
                            child: Container(
                              height: 2,
                              width: 20,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // InkWell for sign up button
              InkWell(
                onHover: (value) {
                  setState(() {
                    value ? _isHovering[2] = true : _isHovering[2] = false;
                  });
                },

                // onTap to redirect to SignUp screen
                onTap: () {
                  widget.logged?
                  Navigator.of(context).pushNamed(
                    '/user',
                    arguments: ScreenArguments(
                        widget.user,
                        widget.logged,
                        widget.user.userId
                    )
                  ):
                  Navigator.of(context).pushNamed(
                    '/register',
                      arguments: ScreenArguments(
                          widget.user,
                          widget.logged,
                          widget.user.userId
                      )
                  );
                },

                // Sets Text and color for InkWell
                child: widget.logged?
                  Text(
                    'Welcome ${widget.user.username}',
                    style: TextStyle(
                      color: _isHovering[2]
                          ? Colors.white
                          : Colors.white70,
                    ),
                  ):
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      color: _isHovering[2]
                          ? Colors.white
                          : Colors.white70,
                    ),
                  ),
              ),

              // Divides the previous row children with the next
              SizedBox(width: screenSize.width / 100),

              Container(
                height: 30,
                width: 2,
                color: Colors.blueGrey,
              ),

              // Divides the previous row children with the next
              SizedBox(width: screenSize.width / 100),

              // InkWell for login button
              InkWell(
                onHover: (value) {
                  setState(() {
                    value ? _isHovering[3] = true : _isHovering[3] = false;
                  });
                },

                // onTap to redirect to login screen
                onTap: () {
                  widget.logged?
                  Navigator.of(context).pushNamed(
                      '/',
                      arguments: ScreenArguments(
                          User(userId: 0, username: "NO_DATA", pwd: "NO_DATA"),
                          false,
                          0
                      )
                  ):
                  Navigator.of(context).pushNamed(
                      '/login',
                      arguments: ScreenArguments(
                          widget.user,
                          widget.logged,
                          widget.user.userId
                      )
                  );
                },

                // Sets Text and color for InkWell
                child: widget.logged?
                  Text(
                    'Log out',
                    style: TextStyle(
                      color: _isHovering[3] ? Colors.white : Colors.white70,
                    ),
                  ):
                  Text(
                    'Log in',
                    style: TextStyle(
                      color: _isHovering[3] ? Colors.white : Colors.white70,
                    ),
                  ),
              ),

              widget.logged?
                Row(
                  children: [
                    // Divides the previous row children with the next
                    SizedBox(width: screenSize.width / 100),

                    Container(
                      height: 30,
                      width: 2,
                      color: Colors.blueGrey,
                    ),

                    // Divides the previous row children with the next
                    SizedBox(width: screenSize.width / 100),
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          value ? _isHovering[4] = true : _isHovering[4] = false;
                        });
                      },

                      // onTap to redirect to login screen
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          '/upload',
                          arguments: ScreenArguments(
                              widget.user,
                              widget.logged,
                              widget.user.userId
                          )
                        );
                      },

                      // Sets Text and color for InkWell
                      child: Text(
                        'Upload review',
                        style: TextStyle(
                          color: _isHovering[4] ? Colors.white : Colors.white70,
                        ),
                      ),
                    )
                  ]
                ): const Text(""),
            ],
          ),
        ),
      ),
    );
  }
}