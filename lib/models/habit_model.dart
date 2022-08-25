import 'package:flutter/material.dart';
import 'package:habit_tracker/models/date_model.dart';

class Habit {
  String name, question;
  Color clr;
  Map<MyDate, bool> checks;
  int id;

  Habit({
    required this.id,
    required this.name,
    required this.question,
    required this.clr,
    required this.checks,
  });


}
