import 'package:flutter/material.dart';
import 'package:todoist_clone/utils/todo_styles.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 300),
      color: Colors.amber,
      // decoration: ToDoStyles.commonDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Expanded(child: ListView(children: [])),
          Wrap(
            children: [Text('Text1')],
          ),
          Row(
            children: [Icon(Icons.tag), Icon(Icons.flag), Icon(Icons.alarm)],
          ),
        ],
      ),
    );
  }
}
