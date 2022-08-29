// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:habit_tracker/pages/create_habit.dart';
import 'package:habit_tracker/providers/create_habit_data.dart';
import 'package:habit_tracker/providers/habit_data.dart';
import 'package:habit_tracker/widgets/show_habits.dart';
import 'package:provider/provider.dart';

void main() {
  // Provider.debugCheckInvalidValueType = null;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HabitData>(
          create: (_) => HabitData(),
        ),
        ChangeNotifierProvider<CreateHabitData>(
          create: (_) => CreateHabitData(),
        ),
      ],
      child: MaterialApp(
        title: '',
        initialRoute: '/',
        routes: {
          '/': (context) => MyHomePage(title: 'Habits'),
          CreateHabit().routeName: (context) => CreateHabit(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(CreateHabit().routeName);
            },
            icon: Icon(Icons.add),
          ),
        ],
        title: Text(widget.title),
      ),
      body: ShowHabits(),
    );
  }
}
