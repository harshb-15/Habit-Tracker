// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:habit_tracker/providers/create_habit_data.dart';
import 'package:provider/provider.dart';

class ColorPick extends StatefulWidget {
  const ColorPick({Key? key}) : super(key: key);

  @override
  State<ColorPick> createState() => _ColorPickState();
}

class _ColorPickState extends State<ColorPick> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<CreateHabitData>(context,listen: false);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              scrollable: true,
              content: ColorPicker(
                pickerColor: data.clr,
                onColorChanged: (Color color) {
                  data.setColor(color);
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {});
                  },
                  child: const Text("Ok"),
                )
              ],
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          // border: Border.all(),
          color: data.clr,
        ),
        width: 25,
        height: 25,
        // decoration: ,
        // width: double.infinity,
        // height: double.infinity,
        // color: data.clr,
      ),
    );
  }
}
