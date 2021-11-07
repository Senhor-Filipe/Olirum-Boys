import 'package:flutter/material.dart';

class BannerText extends StatelessWidget {
  final String text;

  const BannerText({Key? key,
    required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.02,
          horizontal: MediaQuery.of(context).size.width * 0.2
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.green,
          fontSize: 35,
        ),
      ),
    );
  }
}