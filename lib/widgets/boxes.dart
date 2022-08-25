import 'package:flutter/material.dart';

class Boxes extends StatelessWidget {
  String chid;
  Boxes({Key? key, required this.chid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      margin: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 10,
      ),
      child: Text(
        chid,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 12,
        ),
      ),
    );
  }
}
