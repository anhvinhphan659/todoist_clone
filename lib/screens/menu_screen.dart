import 'package:flutter/material.dart';
import 'package:todoist_clone/utils/todo_styles.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name = 'VINHPHAN659';

    return Container(
      decoration: ToDoStyles.commonDecoration,
      margin: const EdgeInsets.only(top: 25.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 20,
                        child: Text(name.substring(0, 1).toUpperCase()),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name),
                        Text('0/5'),
                      ],
                    )
                  ],
                ),
                Icon(Icons.settings_outlined)
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.inbox),
            title: Text('All'),
            trailing: Text('5'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.calendar_month),
            title: Text('Today'),
            trailing: Text('5'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.calculate),
            title: Text('Upcoming'),
            trailing: Text(''),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Filters & Labels'),
            trailing: Text(''),
            onTap: () {},
          ),
          ExpansionTile(
            title: Text('Projects'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [Icon(Icons.arrow_upward), Icon(Icons.plus_one)],
            ),
            initiallyExpanded: true,
            children: [
              ListTile(
                leading: Icon(Icons.circle),
                title: Text('Personal'),
                trailing: Text('7'),
                onTap: () {},
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Manage Projects'),
            trailing: Text(''),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
