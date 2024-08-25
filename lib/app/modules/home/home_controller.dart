import 'package:flutter/foundation.dart';
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

  //Done Todos
  final doneTodos = <dynamic>[].obs;

  //UnDone Todos
  final doingTodos = <dynamic>[].obs;

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

  ///Change Todos list in particular task
  void changeTodos(List<dynamic> todos) {
    doingTodos.clear();
    doneTodos.clear();
    for (var todo in todos) {
      if (todo['done']) {
        doneTodos.add(todo);
      } else {
        doingTodos.add(todo);
      }
    }
  }

  ///Add new to-do item in the task
  bool addTodo(String title) {
    var todo = {'title': title, 'done': false};
    if (doingTodos.any((e) => mapEquals<String, dynamic>(todo, e))) {
      return false;
    }
    var doneTodo = {'title': title, 'done': true};
    if (doneTodos.any((e) => mapEquals<String, dynamic>(doneTodo, e))) {
      return false;
    }
    doingTodos.add(todo);
    return true;
  }

  void updateTodos() {
    var newTodos = <Map<String, dynamic>>[];
    newTodos.addAll([
      ...doingTodos,
      ...doneTodos,
    ]);
    var newTask = task.value!.copyWith(todos: newTodos);
    int oldIndex = tasks.indexOf(task.value);
    tasks[oldIndex] = newTask;
    tasks.refresh();
  }

  void doneTodo(String title) {
    var doingTodo = {
      'title': title,
      'done': false,
    };
    var index =
        doingTodos.indexWhere((e) => mapEquals<String, dynamic>(doingTodo, e));
    doingTodos.removeAt(index);
    var doneTodo = {'title': title, 'done': true};
    doneTodos.add(doneTodo);
    doingTodos.refresh();
    doneTodos.refresh();
  }
}
