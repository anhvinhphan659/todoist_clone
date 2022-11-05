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
      padding: EdgeInsets.all(16.0),
      decoration: ToDoStyles.commonDecoration,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.done_all,
                    color: Colors.grey,
                  ))
            ],
            leadingWidth: 0,
            title: Text(
              'NOTIFICATIONS',
              style: ToDoStyles.titleHeader,
            ),
            elevation: 0.0,

            bottom: const TabBar(
              labelColor: Colors.red,
              indicatorColor: Colors.red,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(
                  icon: Text('ALL'),
                ),
                Tab(
                  icon: Text('UNREAD (0)'),
                ),
              ],
            ), // TabBar

            backgroundColor: Colors.white,
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
