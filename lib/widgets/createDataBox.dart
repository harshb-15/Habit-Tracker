
import 'package:flutter/material.dart';

class CreateDataBox extends StatelessWidget {
  Widget child;
  String txt;

  CreateDataBox({
    Key? key,
    required this.txt,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: 5,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            border: Border.all(
              width: 2,
              color: Colors.white54,
            ),
          ),
          padding: const EdgeInsets.all(17),
          child: child,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
          ),
          margin: const EdgeInsets.only(
            left: 8,
          ),
          color: const Color(0xff212121),
          child: Text(
            txt,
            style: const TextStyle(
              color: Color(0xffF0F0F0),
              fontSize: 11,
            ),
          ),
        ),
      ],
    );
  }
}
