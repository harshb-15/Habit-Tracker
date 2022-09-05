import 'package:flutter/material.dart';

class Boxes extends StatelessWidget {
  Widget chid;
  // Widget child;
  Boxes({Key? key, required this.chid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      margin: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 10,
      ),
      child: chid,
    );
  }
}
