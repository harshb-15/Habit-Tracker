import 'package:flutter/material.dart';

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

class EditPage extends StatelessWidget {
  String name, question, id;
  Color c;

  EditPage({
    Key? key,
    required this.name,
    required this.question,
    required this.id,
    required this.c,
  }) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController questionController = TextEditingController();
  int cnt = 0;

  @override
  Widget build(BuildContext context) {
    final data2 = Provider.of<HabitData>(context, listen: false);
    final data = Provider.of<CreateHabitData>(context, listen: false);
    if (cnt == 0) {
      nameController = TextEditingController(text: name);
      questionController = TextEditingController(text: question);
      data.setName(name);
      data.setQuestion(question);
      data.setColor(c);
      cnt++;
    }
    // print("Build called");

    // final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    // Habit temp = data2.items[data2.items.indexWhere((Habit element) => element.id==args["id"])];

    // nameController.text = data.name;
    // questionController.text = data.question;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xff212121),
      appBar: AppBar(
        title: const Text("Edit Habit"),
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
                data2.editDatabase(id, data.clr, data.name, data.question);
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
