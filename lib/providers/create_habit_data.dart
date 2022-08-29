import 'package:flutter/material.dart';

class CreateHabitData with ChangeNotifier {
  String _name = "", _question = "";
  Color _clr = Colors.blue;

  String get name {
    return _name;
  }

  String get question {
    return _question;
  }

  Color get clr {
    return _clr;
  }

  void setName(String nm) {
    _name = nm;
    // notifyListeners();
  }

  void clearData() {
    _name = "";
    _question = "";
    _clr = Colors.blue;
  }

  void setQuestion(String qs) {
    _question = qs;
    // notifyListeners();
  }

  void setColor(Color c) {
    _clr = c;
    notifyListeners();
  }
}
