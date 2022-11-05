import 'package:flutter/material.dart';
import 'package:todoist_clone/utils/todo_styles.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool isExpand = false;
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
                        child: Text(
                          name.substring(0, 1).toUpperCase(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: ToDoStyles.titleHeader,
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey)),
                              padding: EdgeInsets.all(2.0),
                              margin: EdgeInsets.only(right: 4.0),
                              child: const Icon(
                                Icons.trending_up,
                                color: Colors.grey,
                                size: 13,
                              ),
                            ),
                            Text(
                              '0/5',
                              style: ToDoStyles.paraText
                                  .copyWith(color: Colors.grey),
                            )
                          ],
                        )
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
            leading: const Icon(
              Icons.move_to_inbox,
              color: Colors.blue,
            ),
            title: Text(
              'All',
              style: ToDoStyles.paraText,
            ),
            trailing: Text('5'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.calendar_month,
              color: Colors.green,
            ),
            title: Text(
              'Today',
              style: ToDoStyles.paraText,
            ),
            trailing: Text('5'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.calculate,
              color: Colors.purple,
            ),
            title: Text(
              'Upcoming',
              style: ToDoStyles.paraText,
            ),
            trailing: Text(''),
            onTap: () {},
          ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.category,
          //     color: Colors.orange,
          //   ),
          //   title: Text(
          //     'Filters & Labels',
          //     style: ToDoStyles.paraText,
          //   ),
          //   trailing: Text(''),
          //   onTap: () {},
          // ),
          // ExpansionTile(
          //   title: Text(
          //     'Projects',
          //     style: ToDoStyles.titleHeader,
          //   ),
          //   trailing: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       Icon(isExpand
          //           ? Icons.keyboard_arrow_up
          //           : Icons.keyboard_arrow_down),
          //       Icon(Icons.add)
          //     ],
          //   ),
          //   initiallyExpanded: isExpand,
          //   onExpansionChanged: (value) {
          //     print(value);
          //     print(isExpand);
          //     setState(() {
          //       isExpand = !isExpand;
          //     });
          //   },
          //   children: [
          //     ListTile(
          //       leading: Icon(Icons.circle),
          //       title: Text('Personal'),
          //       trailing: Text('7'),
          //       onTap: () {},
          //     ),
          //   ],
          // ),
          // ListTile(
          //   leading: const Icon(Icons.settings_outlined),
          //   title: Text(
          //     'Manage Projects',
          //     style: ToDoStyles.paraText,
          //   ),
          //   trailing: const Text(''),
          //   onTap: () {},
          // ),
        ],
      ),
    );
  }
}
