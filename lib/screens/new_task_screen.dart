import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoist_clone/models/task.dart';
import 'package:todoist_clone/utils/data_handler.dart';
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
  // bool isDateChosen = false;
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
          Wrap(
            children: [
              TextButton(
                  onPressed: () async {
                    if (isTimeChosen) {
                      setState(() {
                        isTimeChosen = false;
                      });
                      return;
                    }
                    selectedTime = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    if (selectedTime != null) {
                      // print(tod.toString());
                      setState(() {
                        isTimeChosen = true;
                      });
                    }
                  },
                  child: Text(isTimeChosen ? "Remove time" : 'Add time')),
            ],
          ),
          Row(
            children: [
              isTimeChosen
                  ? PickedCard(
                      content: isTimeChosen
                          ? selectedTime!.format(context)
                          : "00:00",
                      backgroundColor: Colors.orange.shade200,
                    )
                  : const SizedBox(),
              PickedCard(
                content: df.format(selectedDate ?? DateTime.now()),
                backgroundColor: Colors.blue.shade200,
                onTapAction: () async {
                  selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2100));

                  print("Dtaae :" + selectedDate.toString());
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.tag),
                  Icon(Icons.flag),
                  Icon(Icons.alarm)
                ],
              ),
              IconButton(
                onPressed: () async {
                  print('Pop context');
                  DateTime taskDT = selectedDate ?? DateTime.now();
                  if (isTimeChosen) {
                    taskDT = DateTime(taskDT.year, taskDT.month, taskDT.day,
                        selectedTime!.hour, selectedDate!.minute, 0, 0, 0);
                  }
                  var task = Task(
                      taskName: taskTEC.text,
                      description: descriptionTEC.text,
                      taskDateTime: taskDT);
                  int id = await DataHandler.insertTask(task);
                  print("New taskId: " + id.toString());
                  task.idTask = id;
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
