import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoist_clone/models/task.dart';
import 'package:todoist_clone/utils/data_handler.dart';
import 'package:todoist_clone/utils/notification_handler.dart';
import 'package:todoist_clone/utils/todo_styles.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  double textFieldHeight = 100;
  final int currentNumLines = 1;
  final TextEditingController taskTEC = TextEditingController();
  final TextEditingController descriptionTEC = TextEditingController();
  bool isTimeChosen = false;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  bool isAlarmSet = false;
  DateTime? alarmDateTime;

  @override
  Widget build(BuildContext context) {
    final df = DateFormat('dd/MM/yyyy');
    print(df.format(DateTime.now()));
    final double MAX_HEIGHT = MediaQuery.of(context).size.height - 150;
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    // print("Keyboard: " + keyboardHeight.toString());
    return Container(
      padding: const EdgeInsets.all(8.0),
      // constraints: const BoxConstraints(minHeight: 350),
      // color: Colors.amber,
      decoration: ToDoStyles.commonDecoration,
      margin: EdgeInsets.only(bottom: keyboardHeight),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: descriptionTEC,
            decoration: const InputDecoration(
                hintText: 'Task name', border: InputBorder.none),
          ),
          Container(
            // color: Colors.yellow,
            height: 150,
            child: SingleChildScrollView(
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: taskTEC,
                decoration: const InputDecoration(
                  hintText: "Some description",
                  border: InputBorder.none,
                  isCollapsed: true,
                ),
              ),
            ),
          ),
          // Wrap(
          //   children: [
          //     TextButton(
          //         onPressed: () async {
          //           if (isTimeChosen) {
          //             setState(() {
          //               isTimeChosen = false;
          //             });
          //             return;
          //           }
          //           selectedTime = await showTimePicker(
          //               context: context, initialTime: TimeOfDay.now());
          //           if (selectedTime != null) {
          //             // print(tod.toString());
          //             setState(() {
          //               isTimeChosen = true;
          //             });
          //           }
          //         },
          //         child: Text(isTimeChosen ? "Remove time" : 'Add time')),
          //   ],
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  PickedCard(
                    content: selectedTime != null
                        ? selectedTime!.format(context)
                        : "00:00",
                    backgroundColor: Colors.orange.shade200,
                    onTapAction: () async {
                      selectedTime = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                    },
                  ),
                  PickedCard(
                    content: df.format(selectedDate ?? DateTime.now()),
                    backgroundColor: Colors.blue.shade200,
                    onTapAction: () async {
                      selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2100));
                    },
                  ),
                ],
              ),
              // IconButton(
              //     onPressed: () async {
              //       print('Hello world');
              //       var t = await showTimePicker(
              //           context: context, initialTime: TimeOfDay.now());
              //       print(t);
              //       var d = await showDatePicker(
              //           context: context,
              //           initialDate: DateTime.now(),
              //           firstDate: DateTime(1950),
              //           lastDate: DateTime(2100));
              //       print(d);
              //     },
              //     icon: Icon(Icons.alarm))
              // TextButton(
              //     onPressed: () {
              //       NotificationHandler.registerScheduledNotification(
              //           title: 'Test notification',
              //           body: 'Hello hello',
              //           scheduledTime:
              //               DateTime.now().add(const Duration(seconds: 10)));
              //     },
              //     child: Text('Set alarm'))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      print('Hello world');
                      var t = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());

                      var d = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2100));
                      if (t == null && d == null) {
                        print('Time and day not selected');
                      } else {
                        t = t ?? const TimeOfDay(hour: 0, minute: 0);
                        d = d ?? DateTime.now();
                        alarmDateTime =
                            DateTime(d.year, d.month, d.day, t.hour, t.minute);
                      }
                      setState(() {
                        isAlarmSet = true;
                        print(alarmDateTime);
                      });
                    },
                    icon: isAlarmSet
                        ? Icon(
                            Icons.alarm_on,
                            color: Colors.green,
                          )
                        : Icon(
                            Icons.alarm,
                          ),
                  ),
                  Text(alarmDateTime != null
                      ? DateFormat('dd/MM/yyyy kk:mm').format(alarmDateTime!)
                      : ""),
                ],
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      isAlarmSet = !isAlarmSet;
                    });
                  },
                  child: Text(isAlarmSet ? 'Remove Notification' : 'Set Alarm'))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () async {
                  print('Pop context');
                  DateTime taskDT = DateTime.now();
                  selectedDate = selectedDate ?? DateTime.now();
                  selectedTime =
                      selectedTime ?? const TimeOfDay(hour: 0, minute: 0);
                  selectedDate = DateTime(
                      selectedDate!.year,
                      selectedDate!.month,
                      selectedDate!.day,
                      selectedTime!.hour,
                      selectedTime!.minute);
                  var task = Task(
                      taskName: taskTEC.text,
                      description: descriptionTEC.text,
                      taskDateTime: selectedDate);
                  int id = await DataHandler.insertTask(task);

                  print("New taskId: " + id.toString());
                  task.idTask = id;
                  //set up notification
                  if (isAlarmSet) {
                    alarmDateTime =
                        selectedDate!.subtract(Duration(minutes: 10));
                    await NotificationHandler.registerScheduledNotification(
                        title: task.taskName,
                        body: task.description,
                        scheduledTime: alarmDateTime!);
                  }
                  Navigator.of(context).pop(task);
                },
                icon: Container(
                  padding: const EdgeInsets.only(
                      left: 6.0, top: 4.0, right: 4.0, bottom: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.red.shade500,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class PickedCard extends StatelessWidget {
  final Color backgroundColor;
  final String content;
  final Function? onTapAction;
  const PickedCard(
      {required this.content,
      this.backgroundColor = Colors.white,
      this.onTapAction,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (onTapAction != null) {
          await onTapAction!.call();
        }
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(right: 4.0),
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(4.0)),
        child: Text(content),
      ),
    );
  }
}
