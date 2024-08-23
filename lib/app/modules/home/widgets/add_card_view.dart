import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:task_todo/app/core/utils/extensions.dart';
import 'package:task_todo/app/core/values/colors.dart';
import 'package:task_todo/app/core/values/icons_data.dart';
import 'package:task_todo/app/data/models/task.dart';
import 'package:task_todo/app/modules/home/home_controller.dart';

class AddCardView extends StatelessWidget {
  AddCardView({super.key});
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final icons = IconsData().getIcons();
    var squareWidth = Get.width - 12.0.wp;
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.only(right: 3.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
            titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
            radius: 5,
            title: 'Task Type',
            content: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.taskTypeController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Title',
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 5.0.wp,
                    ),
                    child: Wrap(
                      spacing: 2.0.wp,
                      children: icons.map((ic) {
                        final index = icons.indexOf(ic);
                        return Obx(
                          () {
                            return ChoiceChip(
                              selectedColor: Colors.grey[200]!,
                              pressElevation: 0,
                              backgroundColor: Colors.white,
                              label: ic,
                              selected: controller.chipIndex.value == index,
                              onSelected: (selected) {
                                controller.chipIndex.value =
                                    selected ? index : 0;
                              },
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        int icon =
                            icons[controller.chipIndex.value].icon!.codePoint;
                        String color =
                            icons[controller.chipIndex.value].color!.toHex();
                        var task = Task(
                          title: controller.taskTypeController.text,
                          icon: icon,
                          color: color,
                        );
                        Get.back();
                        controller.addTask(task)
                            ? EasyLoading.showSuccess('Create Success')
                            : EasyLoading.showError('Create Failed');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0.wp)),
                      minimumSize: const Size(150, 40),
                    ),
                    child: const Text(
                      'Confirm',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
          controller.taskTypeController.clear();
          controller.changeChipIndex(0);
        },
        child: DottedBorder(
          color: Colors.grey[400]!,
          dashPattern: const [8, 4],
          child: Center(
            child: Icon(
              Icons.add,
              size: 10.0.wp,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
