import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoist_clone/models/task.dart';
import 'package:todoist_clone/utils/data_handler.dart';
import 'package:todoist_clone/utils/todo_styles.dart';

class TaskItem extends StatefulWidget {
  final Task task;
  final Function? onFinished;
  const TaskItem({required this.task, this.onFinished, Key? key})
      : super(key: key);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool checked = false;
  bool visible = true;
  static const Map<String, Color> colors = {
    'overdue': Colors.grey,
    'today': Colors.orange,
    'upcoming': Colors.blue,
  };

  @override
  Widget build(BuildContext context) {
    String type = "today";
    int dateDiff = DateTime.now().compareTo(widget.task.taskDateTime!);
    if (dateDiff > 0) {
      type = 'overdue';
    } else {
      if (DateTime.now().day < widget.task.taskDateTime!.day) {
        type = 'upcoming';
      }
    }
    return AnimatedOpacity(
      duration: Duration(seconds: 2),
      opacity: visible ? 1.0 : 0,
      child: Container(
        child: ListTile(
          leading: Container(
            // color: Colors.orange.shade300,
            width: 15,
            height: 15,
            decoration: BoxDecoration(
                color: colors[type]!.withOpacity(0.1), shape: BoxShape.circle),
            child: Checkbox(
              shape: const CircleBorder(),
              activeColor: colors[type],
              value: checked,
              side: BorderSide(color: colors[type]!, width: 2.0),
              onChanged: (bool? value) async {
                print('Value changed: ' + value!.toString());
                setState(() {
                  checked = value;
                });
                if (value) {
                  await DataHandler.deleteTask(widget.task);
                  print("remove: " + widget.task.toString());

                  setState(() {
                    visible = false;
                  });

                  await Future.delayed(const Duration(seconds: 2));

                  widget.onFinished!.call();
                }
              },
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.task.taskName,
                style: ToDoStyles.taskTitle,
              ),
              Text(
                widget.task.description,
                style: ToDoStyles.taskDescription,
                maxLines: 2,
                overflow: TextOverflow.fade,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat(
                      'kk:mm dd/MM/yyyy',
                    ).format(widget.task.taskDateTime!),
                    style: ToDoStyles.taskDateTime,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
