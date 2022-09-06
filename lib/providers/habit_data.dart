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
  final List<Habit> _items = [];

  int get getNumberOfHabits {
    return _items.length;
  }

  List<Habit> get items {
    return [..._items];
  }

  void addChecks(String identifier, String dt) {
    for (var i = 0; i < _items.length; i++) {
      if (_items[i].id == identifier) {
        _items[i].checks[dt] = false;
        break;
      }
    }
    updateDatabase(identifier, dt, false);
  }

  void invertChecks(String identifier, String dt, bool value) {
    for (var i = 0; i < _items.length; i++) {
      if (_items[i].id == identifier) {
        bool temp = !value;
        _items[i].checks[dt] = temp;
        break;
      } else {
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
    var snapShot = await db.collection('habits').get();
    final listOfHabits = snapShot.docs.map((doc) => doc.data()).toList();
    for (var hbt in listOfHabits) {
      String question = hbt['question'], name = hbt['name'];
      String id = hbt['id'];
      Color clr = Color(hbt['clr']);
      Map<String, bool> checks = Map<String, bool>.from(hbt['checks']);
      Habit temp = Habit(
          id: id, name: name, question: question, clr: clr, checks: checks);
      _items.add(temp);
    }
  }

  Future<void> updateDatabase(String identifier, String dt, bool value) async {
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
  }
  Future<void> editDatabase(String identifier, Color c, String nm, String ques) async {
    db.collection('habits').where('id', isEqualTo: identifier).get().then(
          (event) {
        event.docs.forEach((DocumentSnapshot documentSnapshot) async {
          String id = documentSnapshot.id;
          await db.collection('habits').doc(id).update({
            "name": nm,
            "question": ques,
            "clr": c.value,
          });
        });
      },
    );
    _items[_items.indexWhere((Habit element) => element.id==identifier)].name = nm;
    _items[_items.indexWhere((Habit element) => element.id==identifier)].clr = c;
    _items[_items.indexWhere((Habit element) => element.id==identifier)].question = ques;
    notifyListeners();
  }
  Future<void> deleteDatabase(String identifier) async {
    db.collection('habits').where('id', isEqualTo: identifier).get().then(
          (event) {
        event.docs.forEach((DocumentSnapshot documentSnapshot) async {
          String id = documentSnapshot.id;
          await db.collection('habits').doc(id).delete();
        });
      },
    );
    _items.removeWhere((Habit element) => element.id == identifier);
    notifyListeners();
  }

}
