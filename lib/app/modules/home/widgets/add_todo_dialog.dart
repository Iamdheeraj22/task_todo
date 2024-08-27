import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:task_todo/app/core/utils/extensions.dart';
import 'package:task_todo/app/core/values/colors.dart';
import 'package:task_todo/app/modules/home/home_controller.dart';

class AddDialog extends StatelessWidget {
  AddDialog({super.key});
  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: controller.formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                      controller.taskTypeController.clear();
                      controller.changeTask(null);
                    },
                    icon: const Icon(
                      Icons.close,
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                        overlayColor: WidgetStateProperty.all(
                      Colors.transparent,
                    )),
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        if (controller.task.value == null) {
                          EasyLoading.showError('Please select task type');
                        } else {
                          var success = controller.updateTask(
                            controller.task.value!,
                            controller.taskTypeController.text,
                          );
                          if (success) {
                            EasyLoading.showSuccess('Todo item added success');
                            Get.back();
                            controller.changeTask(null);
                          } else {
                            EasyLoading.showError('Todo item already exists');
                          }
                          controller.taskTypeController.clear();
                        }
                      }
                    },
                    child: Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 14.0.sp,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: Text(
                'New Task',
                style: TextStyle(
                  fontSize: 20.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: TextFormField(
                controller: controller.taskTypeController,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]!))),
                autofocus: true,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Please enter a todo item';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 5.0.wp, left: 5.0.wp, right: 5.0.wp, bottom: 2.0.wp),
              child: Text(
                'Add to',
                style: TextStyle(fontSize: 14.0.sp, color: Colors.grey),
              ),
            ),
            ...controller.tasks
                .map((e) => Obx(
                      () => InkWell(
                        onTap: () {
                          controller.changeTask(e);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 3.0.wp, horizontal: 5.0.wp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    IconData(e.icon,
                                        fontFamily: 'MaterialIcons'),
                                    color: HexColor.fromHex(e.color),
                                  ),
                                  SizedBox(
                                    width: 3.0.wp,
                                  ),
                                  Text(
                                    e.title,
                                    style: TextStyle(
                                        fontSize: 12.0.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              if (controller.task.value == e)
                                const Icon(
                                  Icons.check,
                                  color: blue,
                                )
                            ],
                          ),
                        ),
                      ),
                    ))
                .toList()
          ],
        ),
      ),
    );
  }
}
