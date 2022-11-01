import 'package:flutter/material.dart';
import 'package:todoist_clone/utils/todo_styles.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ToDoStyles.commonDecoration,
      child: Column(
        children: [
          TextField(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent Search'),
              Text('Clear'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent visited'),
              Text('Clear'),
            ],
          ),
          Expanded(
            child: ListView(
              children: [Text('Iconnnnsnsananasnan')],
            ),
          )
        ],
      ),
    );
  }
}
