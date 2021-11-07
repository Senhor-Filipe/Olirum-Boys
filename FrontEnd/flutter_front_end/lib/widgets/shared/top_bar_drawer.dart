import 'package:flutter/material.dart';
import 'dart:html' as html;

class TopBarDrawer extends StatelessWidget {
  const TopBarDrawer({
    Key? key
  }) : super(key: key);


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
                  Navigator.of(context).pushNamed(
                    '/register',
                  );
                },
                child: const Text(
                  'Sign up',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    '/register',
                  );
                },
                child: const Text(
                  'Login',
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