import 'package:flutter/material.dart';
import 'package:todoist_clone/screens/home_screen.dart';
import 'package:todoist_clone/utils/data_handler.dart';
import 'package:todoist_clone/utils/notification_handler.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  await DataHandler.handleDatabase();
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'TodoList',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
