import 'package:flutter/material.dart';

class MyDate {
  int day, month, year;
  String weekDay;
  String id = "";

  MyDate({
    required this.day,
    required this.month,
    required this.year,
    required this.weekDay,
  }) {
    id = day.toString() + (month<=9 ? "0$month":month.toString()) + year.toString();
  }

  @override
  bool operator ==(Object other) =>
      other is MyDate &&
      other.runtimeType == runtimeType &&
      day == other.day &&
      month == other.month &&
      year == other.year;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return "Day: $day, Month: $month, Year: $year, Id: $id";
  }
}
