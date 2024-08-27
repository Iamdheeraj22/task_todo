import 'dart:convert';

import 'package:get/get.dart';
import 'package:task_todo/app/core/keys.dart';
import 'package:task_todo/app/data/models/task.dart';
import 'package:task_todo/app/data/services/storage/storage_service.dart';

class TaskProvider {
  final StorageService _storageService = Get.find<StorageService>();

  //read tasks from storage
  List<Task> readTasks() {
    var tasks = <Task>[];
    jsonDecode(_storageService.read('tasks').toString()).forEach((task) {
      tasks.add(Task.fromJson(task));
    });
    return tasks;
  }

  void writeTasks(List<Task> tasks) {
    _storageService.write(
      Keys.taskKey,
      jsonEncode(tasks),
    );
  }
}
