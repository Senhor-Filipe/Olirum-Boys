import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
      color: Colors.indigo,
      child: Column(
        children: [
          Text(
            'This project was made by students of Tecnology Institute of Maua - Brazil',
            style: TextStyle(
              color: Colors.blueGrey.shade300,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Site designed by: Hoshizora Amatsu',
            style: TextStyle(
                color: Colors.blueGrey.shade300
            ),
          )
        ],
      ),
    );
  }
}