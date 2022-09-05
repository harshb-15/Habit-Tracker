// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:habit_tracker/constants.dart';
import 'package:habit_tracker/models/habit_model.dart';
import 'package:habit_tracker/providers/habit_data.dart';
import 'package:habit_tracker/widgets/boxes.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ShowHabits extends StatefulWidget {
  ShowHabits({Key? key}) : super(key: key);
  List<Widget> items = [];

  @override
  State<ShowHabits> createState() => _ShowHabitsState();
}

class _ShowHabitsState extends State<ShowHabits> {
  @override
  Widget build(BuildContext context) {
    // ********** Provider Data **********
    final data = Provider.of<HabitData>(
      context,
    );
    //
    final nowTime = DateTime.now();
    Map<String, String> dateMap = {};

    for (int i = 0; i < 5; i++) {
      DateTime tempNowTime = nowTime.subtract(Duration(days: i * 1));
      String tempMyDate = (tempNowTime.day <= 9
              ? "0${tempNowTime.day}"
              : tempNowTime.day.toString()) +
          (tempNowTime.month <= 9
              ? "0${tempNowTime.month}"
              : tempNowTime.month.toString()) +
          tempNowTime.year.toString();
      dateMap[tempMyDate] =
          "${DateFormat('EEEE').format(tempNowTime).substring(0, 3).toUpperCase()}\n${getDate(tempMyDate)}";
    }

    List<Habit> habitList = data.items;
    List<Widget> showDateAndDay() {
      return dateMap.values
          .map(
            (String str) => Boxes(
              chid: Text(
                str,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xff747474),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
          .toList();
    }

    Widget writeChecks(Habit hbt) {
      Map<int, bool> temp = {};
      List<String> dateList = dateMap.keys.toList();
      for (int i = 0; i < 5; i++) {
        if (hbt.checks.containsKey(dateList[i])) {
          temp[i] = (hbt.checks[dateList[i]])!;
        } else {
          // print(dateList[i]);
          data.addChecks(hbt.id, dateList[i]);
          temp[i] = false;
        }
      }
      List<int> temp2 = temp.keys.toList();
      return Row(
          children: temp2
              .map(
                (int val) => GestureDetector(
                  onTap: () {
                    data.invertChecks(hbt.id, dateList[val], temp[val]!);
                  },
                  child: Boxes(
                    chid: Icon(
                      temp[val] == true ? Icons.check : Icons.close,
                      color: hbt.clr,
                      size: 17,
                    ),
                  ),
                ),
              )
              .toList());
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: showDateAndDay(),
            ),
          ),
          ...habitList
              .map(
                (Habit hbt) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 2,
                  ),
                  color: const Color(0xff303030),
                  margin: const EdgeInsets.only(
                    bottom: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          const snackBar = SnackBar(
                            content: Text("Press-and-hold to delete"),
                            duration: Duration(
                              seconds: 2,
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        onLongPress: () {
                          data.deleteDatabase(hbt.id);
                        },
                        child: Text(
                          hbt.name,
                          style: TextStyle(
                            color: hbt.clr,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      writeChecks(hbt),
                    ],
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
