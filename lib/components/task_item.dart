import 'package:flutter/material.dart';
import 'package:todoist_clone/models/task.dart';
import 'package:todoist_clone/utils/data_handler.dart';

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
  @override
  Widget build(BuildContext context) {
    print("Task item:" + widget.task.toString());
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
                color: Colors.orange.shade100, shape: BoxShape.circle),
            child: Checkbox(
              shape: const CircleBorder(),
              activeColor: Colors.orange,
              value: checked,
              side: BorderSide(color: Colors.orange, width: 2.0),
              onChanged: (bool? value) async {
                print('Value changed: ' + value!.toString());
                setState(() {
                  checked = value!;
                });
                if (value!) {
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
              Text(widget.task.taskName),
              Text(widget.task.description),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.task.taskDateTime.toString()),
                  // Text('aaaaa')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
