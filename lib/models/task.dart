class Task {
  int? idTask;
  String taskName;
  String description;
  DateTime? taskDateTime;
  Task(
      {this.idTask,
      this.taskName = "",
      this.description = "",
      this.taskDateTime});
  Map<String, dynamic> toMap() {
    return {
      "id": idTask,
      "taskname": taskName,
      "description": description,
      "taskdatetime": taskDateTime != null ? taskDateTime.toString() : ""
    };
  }

  @override
  String toString() {
    return "Task{idTask:$idTask, description:$description, taskDateTime:$taskDateTime}";
  }
}
