import 'package:flutter/material.dart';

class Habit {
  String name, question;
  Color clr;
  Map<String, bool> checks;
  String id;
  Habit({
    required this.id,
    required this.name,
    required this.question,
    required this.clr,
    required this.checks,
  });

}
