import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:todoist_clone/components/task_item.dart';
import 'package:todoist_clone/screens/menu_screen.dart';
import 'package:todoist_clone/screens/new_task_screen.dart';
import 'package:todoist_clone/screens/notification_screen.dart';
import 'package:todoist_clone/screens/search_screen.dart';
import 'package:todoist_clone/utils/data_handler.dart';
import 'package:todoist_clone/utils/todo_styles.dart';

import '../models/task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];
  bool isTaskgenetated = false;
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // DataHandler.getTasks().then((value) {
    //   isTaskgenetated = true;
    //   setState(() {
    //     tasks = value;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    // if (isTaskgenetated) {
    //   ("Task home");
    //   print(tasks);
    // }
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          'Today',
          style: ToDoStyles.titleHeader,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: Colors.grey,
              ))
        ],
      ),
      body: FutureBuilder(
          future: DataHandler.getTasks(),
          builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.active:
                {
                  return const Center(
                    child: Text(''),
                  );
                }
              case ConnectionState.done:
                break;
            }
            if (snapshot.hasData) {
              tasks = snapshot.data!;
              print(tasks);
            }
            return Container(
                color: Colors.white,
                // padding: EdgeInsets.all(16.0),cd
                child: ListView(
                  children: [
                    ...List.generate(
                      tasks.length,
                      (index) => TaskItem(
                        task: tasks[index],
                        onFinished: () {
                          setState(() {
                            tasks.removeAt(index);
                          });
                        },
                      ),
                    ),
                    Divider(),
                    // TaskItem(
                    //   task: Task(taskDateTime: DateTime.now()),
                    // ),
                    DateTitle(titles: ['1 Nov', 'Today']),
                    Divider(),
                  ],
                ));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final res = await showMaterialModalBottomSheet(
              expand: false,
              elevation: 4.0,
              context: context,
              builder: (context) {
                return NewTaskScreen();
              });
          if (res != null) {
            setState(() {
              tasks.add(res as Task);
            });
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
        elevation: 2.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        //color of the BottomAppBar
        color: Colors.red,
        child: Container(
          // color: Colors.red,
          margin: EdgeInsets.only(left: 12.0, right: 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                //update the bottom app bar view each time an item is clicked
                onPressed: () {
                  // updateTabSelection(0, "Home");
                  displayBottomModal(context, MenuScreen());
                },
                iconSize: 27.0,
                icon: const Icon(
                  Icons.menu,
                  //darken the icon if it is selected or else give it a different color
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  // updateTabSelection(1, "Outgoing");
                },
                iconSize: 27.0,
                icon: const SizedBox(),
              ),
              //to leave space in between the bottom app bar items and below the FAB
              const SizedBox(
                width: 50.0,
              ),
              IconButton(
                onPressed: () {
                  displayBottomModal(context, SearchScreen());
                },
                iconSize: 27.0,
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  // updateTabSelection(3, "Settings");
                  displayBottomModal(context, NotificationScreen());
                },
                iconSize: 27.0,
                icon: const Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget DateTitle({
    List<String> titles = const ["Overdue"],
    bool isOverDue = false,
  }) {
    String title = titles[0];
    for (int i = 1; i < titles.length; i++) {
      title += ' • ${titles[i]}';
    }

    isOverDue = titles.length == 1;
    return ListTile(
      title: Text(title),
      trailing: isOverDue
          ? TextButton(
              onPressed: () {},
              child: const Text(
                'Reschedule',
                style: TextStyle(color: Colors.red),
              ))
          : const SizedBox(),
    );
  }

  void displayBottomModal(BuildContext context, Widget screen) {
    showMaterialModalBottomSheet(
        expand: true, context: context, builder: (context) => screen);
  }
}
