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
    fontSize: 14.0,
  );

  static TextStyle paraText = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.normal,
    fontSize: 13,
  );
}
