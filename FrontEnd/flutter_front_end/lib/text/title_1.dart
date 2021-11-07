import 'package:flutter/material.dart';

class Title1 extends StatelessWidget {
  final String text;

  const Title1({Key? key,
    required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width,
    );
  }
}