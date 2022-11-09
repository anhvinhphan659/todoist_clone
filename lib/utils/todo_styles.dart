import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToDoStyles {
  //decoration
  static BoxDecoration commonDecoration = const BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    ),
  );

  //Text style
  static TextStyle titleHeader = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
  );

  static TextStyle paraText = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.normal,
    fontSize: 13,
  );

  static TextStyle taskTitle = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontSize: 18.0,
  );
  static TextStyle taskDescription = TextStyle(
    color: Colors.grey.shade500,
    fontWeight: FontWeight.normal,
    fontSize: 16.0,
  );
  static TextStyle taskDateTime = TextStyle(
    color: Colors.grey.shade500,
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
  );
}
