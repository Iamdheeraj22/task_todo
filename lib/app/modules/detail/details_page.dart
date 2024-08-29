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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: homeController.formKey,
          child: ListView(
            children: [
              Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Flexible(
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                          homeController.updateTodos();
                          homeController.changeTask(null);
                          homeController.taskTypeController.clear();
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 3.0.wp,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: TextStyle(
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Obx(
                        () => Row(
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
                            SizedBox(
                              width: Get.width / 2.5,
                              child: StepProgressIndicator(
                                totalSteps:
                                    (doingTodos.length + doneTodos.length) == 0
                                        ? 1
                                        : (doingTodos.length +
                                            doneTodos.length),
                                currentStep: doneTodos.length,
                                size: 10,
                                padding: 0,
                                selectedGradientColor: LinearGradient(
                                  colors: [color.withOpacity(0.5), color],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                unselectedGradientColor: LinearGradient(
                                  colors: [
                                    Colors.grey[300]!,
                                    Colors.grey[300]!
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Icon(
                    IconData(task.icon, fontFamily: 'MaterialIcons'),
                    color: color,
                    size: 6.0.wp,
                  ),
                  SizedBox(
                    width: 3.0.wp,
                  ),
                ],
              ),
              SizedBox(
                height: 3.0.wp,
              ),
              SizedBox(
                height: 2.0.hp,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: homeController.taskTypeController,
                        autofocus: true,
                        decoration: InputDecoration(
                          suffixIcon: SizedBox(
                            height: 50,
                            width: 50,
                            child: TextButton(
                              onPressed: () {
                                if (homeController.formKey.currentState!
                                    .validate()) {
                                  var success = homeController.addTodo(
                                      homeController.taskTypeController.text);
                                  if (success) {
                                    EasyLoading.showSuccess(
                                        'Todo is added successfully');
                                  } else {
                                    EasyLoading.showError(
                                        'Todo already exists');
                                  }
                                  homeController.taskTypeController.clear();
                                }
                              },
                              child: const SizedBox(
                                child: Icon(
                                  Icons.add_circle_outline_outlined,
                                  size: 35,
                                ),
                              ),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.all(10),
                        ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Please enter a todo item';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.0.hp,
              ),
              Obx(
                () => Column(children: [
                  Container(
                    height: 50,
                    width: Get.width,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      //  color: color,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        TaskTab(
                          title:
                              'In Progress (${homeController.doingTodos.length})',
                          isSelected:
                              homeController.taskTabSelection.value == 1,
                          onTap: () {
                            homeController.changeTaskTabSelection(1);
                          },
                        ),
                        TaskTab(
                          title:
                              'Completed (${homeController.doneTodos.length})',
                          isSelected:
                              homeController.taskTabSelection.value == 2,
                          onTap: () {
                            homeController.changeTaskTabSelection(2);
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.0.hp,
                  ),
                  if (homeController.taskTabSelection.value == 1)
                    DoingTodoListView(),
                  if (homeController.taskTabSelection.value == 2)
                    DoneTodoListView(),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TaskTab extends StatelessWidget {
  const TaskTab({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40,
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: isSelected ? Colors.grey : Colors.white,
            borderRadius: BorderRadius.circular(7),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 14.0.sp,
            ),
          ),
        ),
      ),
    );
  }
}
