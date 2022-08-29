import 'package:flutter/material.dart';
import 'package:habit_tracker/models/habit_model.dart';
import 'package:habit_tracker/providers/habit_data.dart';
import 'package:habit_tracker/widgets/color_picker.dart';
import 'package:provider/provider.dart';

import '../providers/create_habit_data.dart';

class CreateHabit extends StatelessWidget {
  const CreateHabit({Key? key}) : super(key: key);
  final String routeName = '/createHabit';

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<CreateHabitData>(context, listen: false);
    final data2 = Provider.of<HabitData>(context);
    TextEditingController nameController = TextEditingController();
    TextEditingController questionController = TextEditingController();
    Color defColor = Colors.blue;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Habit"),
        actions: [
          Padding(
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
                    id: data2.getNumberOfHabits + 1,
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
      body: Column(
        children: [
          Row(
            children: [
              const Text("Name"),
              Expanded(
                child: TextField(
                  controller: nameController,
                  onChanged: (String str) {
                    data.setName(str);
                  },
                ),
              ),
              const ColorPick(),
            ],
          ),
          Row(
            children: [
              const Text("Question"),
              Expanded(
                child: TextField(
                  controller: questionController,
                  onChanged: (String str) {
                    data.setQuestion(str);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
