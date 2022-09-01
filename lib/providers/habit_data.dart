import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/models/habit_model.dart';

class HabitData with ChangeNotifier {
  // HabitData() {
  //   print("Ho");
  //   getDatabase();
  // }

  final db = FirebaseFirestore.instance;
  final List<Habit> _items = [
    // Habit(
    //   id: 1,
    //   name: "Exercise",
    //   question: "Did You Exercise today?",
    //   clr: Colors.orangeAccent,
    //   checks: {
    //     "31082022": true,
    //   },
    // ),
  ];

  int get getNumberOfHabits {
    return _items.length;
  }

  List<Habit> get items {
    return [..._items];
  }

  void addChecks(int identifier, String dt) {
    for (var i = 0; i < _items.length; i++) {
      if (_items[i].id == identifier) {
        _items[i].checks[dt] = false;
        break;
      }
    }
    updateDatabase(identifier, dt, false);
    // notifyListeners();
  }

  void invertChecks(int identifier, String dt, bool value) {
    // print("Long Pressed called");
    for (var i = 0; i < _items.length; i++) {
      if (_items[i].id == identifier) {
        // print("Found");
        bool temp = !value;
        _items[i].checks[dt] = temp;
        // print("Changed");
        break;
      } else {
        // print("Not found!");
      }
    }
    updateDatabase(identifier, dt, !value);
    notifyListeners();
  }

  void addHabit(Habit hbt) {
    _items.add(hbt);
    addDatabase(hbt);
    notifyListeners();
  }

  void addDatabase(Habit hbt) {
    // Map<String, bool> mapToAdd = {};
    // hbt.checks.forEach((key, value) {
    //   mapToAdd[key.id] = value;
    // });
    Map<String, dynamic> habit = {
      "id": hbt.id,
      "name": hbt.name,
      "question": hbt.question,
      "clr": hbt.clr.value,
      "checks": hbt.checks,
    };
    db.collection('habits').add(habit);
  }

  Future<void> getDatabase() async {
    // print("getDatabase Called!");
    var snapShot = await db.collection('habits').get();
    final listOfHabits = snapShot.docs.map((doc) => doc.data()).toList();
    for (var hbt in listOfHabits) {
      String question = hbt['question'], name = hbt['name'];
      int id = hbt['id'];
      Color clr = Color(hbt['clr']);
      // Map<String, bool> tempMap = Map<String, bool>.from(hbt['checks']);
      Map<String, bool> checks = Map<String, bool>.from(hbt['checks']);
      // print(tempMap['28082022']);
      // tempMap.forEach((k, v) {
      //   // print(int.parse(k.substring(0,2)).runtimeType);
      //   int d = int.parse(k.substring(0, 2)),
      //       m = int.parse(k.substring(2, 4)),
      //       y = int.parse(k.substring(4, 6));
      //   // print(m);
      //   MyDate tempDate = MyDate(
      //     day: d,
      //     month: m,
      //     year: y,
      //     weekDay: DateFormat('EEEE').format(DateTime(y, m, d)),
      //   );
      //   checks[tempDate] = v;
      // });
      Habit temp = Habit(
          id: id, name: name, question: question, clr: clr, checks: checks);
      _items.add(temp);
    }
    // print(_items[0].checks);
    // for(var idk in _items){
    //   print(idk.checks)
    // }
  }

  Future<void> updateDatabase(int identifier, String dt, bool value) async {
    // print("Update called");
    db.collection('habits').where('id', isEqualTo: identifier).get().then(
      (event) {
        event.docs.forEach((DocumentSnapshot documentSnapshot) async {
          String id = documentSnapshot.id;
          await db.collection('habits').doc(id).update({
            "checks.$dt": value,
          });
        });
      },
    );
    // print(_items[0].checks);
  }
}
