import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:todoist_clone/components/task_item.dart';
import 'package:todoist_clone/screens/menu_screen.dart';
import 'package:todoist_clone/screens/new_task_screen.dart';

import 'package:todoist_clone/utils/data_handler.dart';
import 'package:todoist_clone/utils/notification_handler.dart';
import 'package:todoist_clone/utils/todo_styles.dart';

import '../models/task.dart';

class HomeScreen extends StatefulWidget {
  final int mode;
  // ignore: constant_identifier_names
  static const int ALL_TASK_MODE = 0;
  // ignore: constant_identifier_names
  static const int TODAY_TASK_MODE = 1;
  // ignore: constant_identifier_names
  static const int UPCOMING_TASK_MODE = 2;
  const HomeScreen({this.mode = ALL_TASK_MODE, Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    NotificationHandler.init();
  }

  String searchValue = "";
  List<Task> tasks = [];
  var overdues = [];
  var todays = [];
  var upcomings = [];
  bool isTaskgenetated = false;
  TextEditingController txtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // if (isTaskgenetated) {
    //   ("Task home");
    //   print(tasks);
    // }
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0.0,
      //   backgroundColor: Colors.white,
      //   // title: Text(
      //   //   'Today',
      //   //   style: ToDoStyles.titleHeader,
      //   // ),
      //   actions: [
      //     IconButton(
      //         onPressed: () {},
      //         icon: const Icon(
      //           Icons.more_vert,
      //           color: Colors.grey,
      //         ))
      //   ],
      // ),
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
              tasks.clear();
              overdues.clear();
              todays.clear();
              upcomings.clear();
              tasks = snapshot.data!;
              //filter by input
              print("Search value: " + searchValue);
              tasks = filterTask(tasks, searchValue);

              print("Current tasks: " + tasks.toString());
              print(tasks.length);
              //filter tasks
              for (int i = 0; i < tasks.length; i++) {
                switch (tasks[i].getTaskMode()) {
                  case 0:
                    overdues.add(tasks[i]);
                    break;
                  case 1:
                    todays.add(tasks[i]);
                    break;
                  case 2:
                    upcomings.add(tasks[i]);
                    break;
                }
              }
            }
            print("Overdue: " + overdues.toString());
            var overdueWidgets = (widget.mode < 1 && overdues.isNotEmpty)
                ? [
                    const Divider(),
                    DateTitle(titles: ['Overdue']),
                    const Divider(),
                    ...List.generate(
                      overdues.length,
                      (index) => TaskItem(
                        task: overdues[index],
                        onFinished: () {
                          setState(() {
                            overdues.removeAt(index);
                          });
                        },
                      ),
                    ),
                  ]
                : [];
            var todayWidgets = (widget.mode < 2 && todays.isNotEmpty)
                ? [
                    const Divider(),
                    DateTitle(titles: ['Today'], isOverDue: false),
                    const Divider(),
                    ...List.generate(
                      todays.length,
                      (index) => TaskItem(
                        task: todays[index],
                        onFinished: () {
                          setState(() {
                            todays.removeAt(index);
                          });
                        },
                      ),
                    ),
                  ]
                : [];
            var upcomingWidgets =
                ((widget.mode == 2 || widget.mode == 0) && upcomings.isNotEmpty)
                    ? [
                        const Divider(),
                        DateTitle(titles: ['Upcoming'], isOverDue: false),
                        const Divider(),
                        ...List.generate(
                          upcomings.length,
                          (index) => TaskItem(
                            task: upcomings[index],
                            onFinished: () {
                              setState(() {
                                upcomings.removeAt(index);
                              });
                            },
                          ),
                        ),
                      ]
                    : [];

            // print(overdues);
            return Container(
                color: Colors.white,
                // padding: EdgeInsets.all(16.0),cd
                child: ListView(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 4.0, top: 8.0),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              searchValue = txtController.text;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade500),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Icon(Icons.search),
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        // setState(() {
                        //   searchValue = value;
                        // });
                      },
                      controller: txtController,
                    ),
                    ...overdueWidgets,
                    ...todayWidgets,
                    ...upcomingWidgets,
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
                return const NewTaskScreen();
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
              // IconButton(
              //   onPressed: () {
              //     displayBottomModal(context, SearchScreen());
              //   },
              //   iconSize: 27.0,
              //   icon: const Icon(
              //     Icons.search,
              //     color: Colors.white,
              //   ),
              // ),
              // IconButton(
              //   onPressed: () {
              //     // updateTabSelection(3, "Settings");
              //     displayBottomModal(context, NotificationScreen());
              //   },
              //   iconSize: 27.0,
              //   icon: const Icon(
              //     Icons.notifications_none,
              //     color: Colors.white,
              //   ),
              // ),
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

    return ListTile(
      title: Text(
        title,
        style: ToDoStyles.titleHeader,
      ),
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

  List<Task> filterTask(List<Task> source, String value) {
    List<Task> newTasks = [];
    for (int i = 0; i < source.length; i++) {
      Task t = source[i];
      if (t.taskName.contains(value) || t.description.contains(value)) {
        newTasks.add(t);
      }
    }
    return newTasks;
  }

  void displayBottomModal(BuildContext context, Widget screen) {
    showMaterialModalBottomSheet(
        expand: true, context: context, builder: (context) => screen);
  }
}
