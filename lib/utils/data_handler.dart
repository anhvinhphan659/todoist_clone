import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoist_clone/models/task.dart';

class DataHandler {
  static const String databaseName = "todoist.db";
  static late final Database database;
  static Future<void> handleDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    database = await openDatabase(join(await getDatabasesPath(), databaseName),
        onCreate: (db, version) async {
      db.execute(
          'CREATE TABLE task(id INTEGER PRIMARY KEY AUTOINCREMENT, taskname TEXT,description TEXT, taskdatetime TEXT)');

      print('Initialize succesfully');
    }, version: 3);
    // await database.delete('dog');
    // await deleteDatabase(join(await getDatabasesPath(), databaseName));
    // await insertTask(Task(taskDateTime: DateTime.now()));
    // print(await getTasks());
  }

  static Future<int> insertTask(Task task) async {
    if (database == null) return -1;
    return await database.insert(
      'task',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateTask(Task task) async {
    if (database == null) return;
    if (task.idTask == null) {
      task.idTask = 0;
    }
    await database
        .update('task', task.toMap(), where: 'id=?', whereArgs: [task.idTask]);
  }

  static Future<List<Task>> getTasks() async {
    if (database == null) return [];
    final List<Map<String, dynamic>> maps = await database.query('task');
    return List.generate(maps.length, (index) {
      print(maps[index]);
      return Task(
        idTask: maps[index]['id'],
        taskName: maps[index]['taskname'] ?? "",
        description: maps[index]['description'] ?? "",
        taskDateTime: DateTime.tryParse(
                (maps[index]['taskdatetime'] ?? DateTime.now()).toString())
            ?.toLocal(),
      );
    });
  }

  static Future<void> deleteTask(Task task) async {
    if (database == null) return;
    await database.delete('task', where: 'id=?', whereArgs: [task.idTask]);
  }
}
