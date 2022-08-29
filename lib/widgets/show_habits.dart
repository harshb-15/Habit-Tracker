// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:habit_tracker/models/date_model.dart';
import 'package:habit_tracker/models/habit_model.dart';
import 'package:habit_tracker/providers/habit_data.dart';
import 'package:habit_tracker/widgets/boxes.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ShowHabits extends StatelessWidget {
  const ShowHabits({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Build called");
    // ********** Provider Data **********
    final data = Provider.of<HabitData>(context);
    final List<Habit> habitList = data.items;
    // ********** Setting up Times **********
    final nowTime = DateTime.now();
    final nowDate = MyDate(
      day: nowTime.day,
      month: nowTime.month,
      year: nowTime.year,
      weekDay: DateFormat('EEEE').format(nowTime),
    );
    Map<MyDate, String> dateMap = {};
    for (int i = 0; i < 5; i++) {
      DateTime tempNowTime = nowTime.subtract(Duration(days: i * 1));
      MyDate tempMyDate = MyDate(
        day: tempNowTime.day,
        month: tempNowTime.month,
        year: tempNowTime.year,
        weekDay: DateFormat('EEEE').format(tempNowTime),
      );
      dateMap[tempMyDate] =
          "${tempMyDate.weekDay.substring(0, 3).toUpperCase()}\n${tempMyDate.day}";
    }
    List<Widget> showDateAndDay() {
      return dateMap.values
          .map(
            (String str) => Boxes(chid: str),
          )
          .toList();
    }

    Widget writeChecks(Habit hbt) {
      print("WriteChecks called");
      Map<int, bool> temp = {};
      List<MyDate> dateList = dateMap.keys.toList();
      for (int i = 0; i < 5; i++) {
        if (hbt.checks.containsKey(dateList[i])) {
          temp[i] = (hbt.checks[dateList[i]])!;
        } else {
          data.setChecks(hbt.id, dateList[i], false);
          temp[i] = (false);
        }
      }
      List<int> temp2 = temp.keys.toList();
      return Row(
          children: temp2
              .map(
                (int val) => GestureDetector(
                  onLongPress: () {
                    print("Clicked");
                    data.changeChecks(hbt.id, dateList[val], !temp[val]!);
                  },
                  child: Boxes(chid: temp[val] == true ? "✓" : "✗"),
                ),
              )
              .toList());
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: showDateAndDay(),
          ),
          ...habitList
              .map(
                (Habit hbt) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      hbt.name,
                      style: TextStyle(
                        color: hbt.clr,
                      ),
                    ),
                    writeChecks(hbt),
                  ],
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
