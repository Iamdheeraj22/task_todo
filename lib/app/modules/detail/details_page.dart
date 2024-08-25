import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:task_todo/app/core/utils/extensions.dart';
import 'package:task_todo/app/modules/detail/widgets/doing_todo_list_view.dart';
import 'package:task_todo/app/modules/detail/widgets/done_todo_list_view.dart';
import 'package:task_todo/app/modules/home/home_controller.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage({super.key});
  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    var task = homeController.task.value!;
    var color = HexColor.fromHex(task.color);
    var doingTodos = homeController.doingTodos;
    var doneTodos = homeController.doneTodos;
    return Scaffold(
      body: Form(
        key: homeController.formKey,
        child: ListView(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(3.0.wp),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                      homeController.updateTodos();
                      homeController.changeTask(null);
                      homeController.taskTypeController.clear();
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 3.0.wp,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.0.wp),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    IconData(task.icon, fontFamily: 'MaterialIcons'),
                    color: color,
                    size: 6.0.wp,
                  ),
                  SizedBox(
                    width: 3.0.wp,
                  ),
                  Center(
                    child: Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 16.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => Padding(
                padding: EdgeInsets.only(
                  left: 16.0.wp,
                  right: 16.0.wp,
                ),
                child: Row(
                  children: [
                    Text(
                      '${doneTodos.length + doingTodos.length} Tasks',
                      style: TextStyle(
                        fontSize: 14.0.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 3.0.wp,
                    ),
                    Expanded(
                      child: StepProgressIndicator(
                        totalSteps: (doingTodos.length + doneTodos.length) == 0
                            ? 1
                            : (doingTodos.length + doneTodos.length),
                        currentStep: doneTodos.length,
                        size: 10,
                        padding: 0,
                        selectedGradientColor: LinearGradient(
                          colors: [color.withOpacity(0.5), color],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        unselectedGradientColor: LinearGradient(
                          colors: [Colors.grey[300]!, Colors.grey[300]!],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 1.0.hp,
            ),
            TextFormField(
              controller: homeController.taskTypeController,
              autofocus: true,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey[400]!,
                  ),
                ),
                prefix: Icon(
                  Icons.check_box_outline_blank,
                  color: Colors.grey[400]!,
                  size: 20,
                ),
                suffixIcon: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    if (homeController.formKey.currentState!.validate()) {
                      var success = homeController
                          .addTodo(homeController.taskTypeController.text);
                      if (success) {
                        EasyLoading.showSuccess('Todo is added successfully');
                      } else {
                        EasyLoading.showError('Todo already exists');
                      }
                      homeController.taskTypeController.clear();
                    }
                  },
                  icon: const Icon(
                    Icons.done,
                  ),
                ),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Please enter a todo item';
                }
                return null;
              },
            ),
            SizedBox(
              height: 2.0.hp,
            ),
            DoingTodoListView(),
            DoneTodoListView(),
          ],
        ),
      ),
    );
  }
}
