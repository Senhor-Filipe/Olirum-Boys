import 'package:flutter/material.dart';
import 'dart:html' as html;

import 'package:flutter_front_end/models/screen_arguments.dart';
import 'package:flutter_front_end/models/user.dart';

class TopBarDrawer extends StatefulWidget {
  final User user;
  final bool logged;

  const TopBarDrawer({
    Key? key,
    required this.user,
    required this.logged,
  }) : super(key: key);

  @override
  State<TopBarDrawer> createState() => _TopBarDrawerState();
}

class _TopBarDrawerState extends State<TopBarDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.indigo.shade700,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            // Sets items to top-left
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
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
                child: const Text(
                  'Games',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),

              const SizedBox(height: 10),

              InkWell(
                onTap: () {
                  html.window.open("https://github.com/Senhor-Filipe/Olirum-Boys/", "_blank");
                },
                child: const Text(
                  'Source Code',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),

              const SizedBox(height: 5),

              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: Colors.blueGrey.shade400,
                  thickness: 2,
                ),
              ),

              const SizedBox(height: 5),

              InkWell(
                onTap: () {
                  widget.logged?
                  Navigator.of(context).pushNamed(
                      '/user',
                      arguments: ScreenArguments(
                          widget.user,
                          widget.logged,
                          0
                      )
                  ):
                  Navigator.of(context).pushNamed(
                    '/register',
                  );
                },

                child: widget.logged?
                  Text(
                    'Welcome ${widget.user.username}',
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ):
                  const Text(
                    'Sign up',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
              ),

              const SizedBox(height: 10),

              InkWell(
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
                      '/register'
                  );
                },
                child: widget.logged?
                const Text(
                  'Log out',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ):
                const Text(
                  'Log in',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}