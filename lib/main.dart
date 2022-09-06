// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:habit_tracker/pages/create_habit.dart';
import 'package:habit_tracker/pages/edit_page.dart';
import 'package:habit_tracker/pages/loginPage.dart';
import 'package:habit_tracker/pages/register_page.dart';
import 'package:habit_tracker/providers/create_habit_data.dart';
import 'package:habit_tracker/providers/habit_data.dart';
import 'package:habit_tracker/widgets/show_habits.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:splashscreen/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
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
        theme: ThemeData(
          textTheme: TextTheme(
            subtitle1: TextStyle(
              color: Colors.white,
            ),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xff101010),
            iconTheme: IconThemeData(
              color: Color(0xffF0F0F0),
            ),
            actionsIconTheme: IconThemeData(
              color: Color(0xffF0F0F0),
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        title: '',
        // initialRoute: '/splashScreen',
        home: Splash1(),
        routes: {
          // '/edit': (context) => EditPage(),
          '/reg': (context) => RegisterPage(),
          '/login': (context) => LoginPage(),
          '/splashScreen': (context) => Splash1(),
          '/home': (context) => MyHomePage(title: 'Habits'),
          CreateHabit().routeName: (context) => CreateHabit(),
        },
      ),
    );
  }
}

int cnt = 0;

class Splash1 extends StatelessWidget {
  Splash1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<HabitData>(context);
    cnt++;
    if (cnt == 1) {
      data.getDatabase();
    }
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: MyHomePage(
        title: 'Habit Tracker',
      ),
      photoSize: 100.0,
      title: Text(
        "Loop Habit Tracker",
        textScaleFactor: 2,
        style: TextStyle(
          color: Color(0xffF0F0F0),
        ),
      ),
      image: Image.asset('assets/images/logo.png'),
      backgroundColor: Color(0xff4C4C4C),
      loaderColor: Color(0xffF0F0F0),
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
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 1), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff212121),
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
