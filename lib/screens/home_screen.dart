import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:todoist_clone/screens/menu_screen.dart';
import 'package:todoist_clone/screens/new_task_screen.dart';
import 'package:todoist_clone/screens/notification_screen.dart';
import 'package:todoist_clone/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: TextButton(
            child: Text('Show model'),
            onPressed: () {
              displayBottomModal(
                  context,
                  Container(
                    // height: 1800,
                    color: Colors.yellow,
                  ));
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showMaterialModalBottomSheet(
              expand: false,
              elevation: 4.0,
              context: context,
              builder: (context) => NewTaskScreen());
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

  void displayBottomModal(BuildContext context, Widget screen) {
    showMaterialModalBottomSheet(
        expand: true, context: context, builder: (context) => screen);
  }
}
