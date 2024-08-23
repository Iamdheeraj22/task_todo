import 'package:get/get.dart';
import 'package:task_todo/app/data/providers/task/task_provider.dart';
import 'package:task_todo/app/data/services/storage/repository.dart';
import 'package:task_todo/app/modules/home/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        taskRepository: TaskRepository(
          taskProvider: TaskProvider(),
        ),
      ),
    );
  }
}
