import 'package:flutter/material.dart';
import 'package:todoist_clone/screens/home_screen.dart';
import 'package:todoist_clone/utils/data_handler.dart';

void main() async {
  await DataHandler.handleDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoList',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      home: const HomeScreen(),
    );
  }
}
