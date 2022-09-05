// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/models/habit_model.dart';
import 'package:habit_tracker/providers/habit_data.dart';
import 'package:habit_tracker/widgets/color_picker.dart';
import 'package:habit_tracker/widgets/createDataBox.dart';
import 'package:provider/provider.dart';

import '../providers/create_habit_data.dart';

class CreateHabit extends StatelessWidget {
  CreateHabit({Key? key}) : super(key: key);
  final String routeName = '/createHabit';
  var uuid = Uuid();
  TextEditingController nameController = TextEditingController();
  TextEditingController questionController = TextEditingController();
  final db = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    final data = Provider.of<CreateHabitData>(context, listen: false);
    final data2 = Provider.of<HabitData>(context, listen: false);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xff212121),
      appBar: AppBar(
        title: const Text("Create Habit"),
        actions: [
          Container(
            padding: const EdgeInsets.all(10),
            child: TextButton(
              style: TextButton.styleFrom(
                // fixedSize: const Size(20, 30),
                side: const BorderSide(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: () {
                data2.addHabit(
                  Habit(
                    id: uuid.v1(),
                    name: data.name,
                    question: data.question,
                    clr: data.clr,
                    checks: {},
                  ),
                );
                data.clearData();
                Navigator.of(context).pop();
              },
              child: const Text(
                "SAVE",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CreateDataBox(
                  txt: "Name",
                  child: SizedBox(
                    height: 25,
                    width: width * 0.65,
                    child: TextField(
                      cursorColor: data.clr,
                      decoration: (InputDecoration(
                        isDense: true,
                        hintText: "e.g. Exercise",
                        hintStyle: TextStyle(
                          color: Colors.white54,
                        ),
                        border: InputBorder.none,
                        isCollapsed: true,
                      )),
                      controller: nameController,
                      onChanged: (String str) {
                        data.setName(str);
                      },
                    ),
                  ),
                ),
                CreateDataBox(
                  txt: "Color",
                  child: ColorPick(),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            CreateDataBox(
              txt: "Question",
              child: SizedBox(
                height: 25,
                width: width,
                child: TextField(
                  cursorColor: data.clr,
                  decoration: (InputDecoration(
                    isDense: true,
                    hintText: "e.g. Did you exercise today?",
                    hintStyle: TextStyle(
                      color: Colors.white54,
                    ),
                    border: InputBorder.none,
                    // isCollapsed: true,
                  )),
                  controller: questionController,
                  onChanged: (String str) {
                    data.setQuestion(str);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
