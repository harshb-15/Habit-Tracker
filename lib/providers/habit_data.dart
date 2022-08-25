import 'package:flutter/material.dart';
import 'package:habit_tracker/models/date_model.dart';
import 'package:habit_tracker/models/habit_model.dart';

class HabitData with ChangeNotifier {
  final List<Habit> _items = [
    Habit(
      id: 1,
      name: "Exercise",
      question: "Did You Exercise today?",
      clr: Colors.blue,
      checks: {
        MyDate(
          day: 24,
          month: 8,
          year: 2022,
          weekDay: "Wednesday",
        ): true,
      },
    ),
  ];

  List<Habit> get items {
    return [..._items];
  }

  void setChecks(int identifier, MyDate dt, bool value) {
    for (var i = 0; i < items.length; i++) {
      if (items[i].id == identifier) {
        items[i].checks[dt] = value;
        break;
      }
    }
  }
  void changeChecks(int identifier, MyDate dt, bool value) {
    for (var i = 0; i < items.length; i++) {
      if (items[i].id == identifier) {
        items[i].checks[dt] = value;
        break;
      }
    }
    print("data changed to $value");
    notifyListeners();
  }
}
