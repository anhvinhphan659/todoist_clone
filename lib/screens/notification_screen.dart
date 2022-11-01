import 'package:flutter/material.dart';
import 'package:todoist_clone/utils/todo_styles.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ToDoStyles.commonDecoration,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Text('ALL'),
                ),
                Tab(
                  icon: Text('UNREAD'),
                ),
              ],
            ), // TabBar

            backgroundColor: Colors.yellow,
          ),
          body: const TabBarView(
            children: [
              Text('ALL'),
              Text('UNREAD'),
            ],
          ),
        ),
      ),
    );
  }
}
