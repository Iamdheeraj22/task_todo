import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_todo/app/data/models/task.dart';
import 'package:task_todo/app/data/services/storage/repository.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;
  HomeController({required this.taskRepository});

  final formKey = GlobalKey<FormState>();
  final chipIndex = 0.obs;
  final tasks = <Task>[].obs;
  final deleting = false.obs;
  final taskTypeController = TextEditingController();
  final task = Rx<Task?>(null);
  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) {
      taskRepository.writeTasks(tasks);
    });
  }

  @override
  void onClose() {
    taskTypeController.dispose();
    super.onClose();
  }

  void changeChipIndex(int index) {
    chipIndex.value = index;
  }

  void changeDeletingStatus(bool v) {
    deleting.value = v;
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    }
    tasks.add(task);
    return true;
  }

  void deleteTask(Task task) {
    tasks.remove(task);
  }

  void changeTask(Task? t) {
    task.value = t;
  }

  updateTask(Task task, String title) {
    var todos = task.todos ?? [];
    if (containTodo(todos, title)) {
      return false;
    }
    var todo = {'title': title, 'done': false};
    todos.add(todo);
    var newTask = task.copyWith(todos: todos);
    int oldIndex = tasks.indexOf(task);
    tasks[oldIndex] = newTask;
    return true;
  }

  bool containTodo(List todos, String newTask) {
    return todos.any((element) => element['title'] == newTask);
  }
}
