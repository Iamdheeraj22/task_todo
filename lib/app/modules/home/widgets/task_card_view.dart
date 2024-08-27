import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:task_todo/app/core/utils/extensions.dart';
import 'package:task_todo/app/data/models/task.dart';
import 'package:task_todo/app/modules/detail/details_page.dart';
import 'package:task_todo/app/modules/home/home_controller.dart';

class TaskCardView extends StatelessWidget {
  TaskCardView({super.key, required this.task});
  final controller = Get.find<HomeController>();
  final Task task;
  @override
  Widget build(BuildContext context) {
    final hexColor = HexColor.fromHex(task.color);
    final squareWidth = Get.width - 12.0.wp;
    return GestureDetector(
      onTap: () {
        controller.changeTask(task);
        controller.changeTodos(task.todos ?? []);
        Get.to(() => DetailsPage());
      },
      child: Container(
        width: squareWidth / 2,
        height: squareWidth / 2,
        margin: EdgeInsets.only(right: 3.0.wp),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              blurRadius: 7,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepProgressIndicator(
              totalSteps: controller.isTodoEmpty(task) ? 1 : task.todos!.length,
              currentStep: controller.isTodoEmpty(task)
                  ? 0
                  : controller.getDoneTodos(task),
              size: 5,
              padding: 0,
              selectedGradientColor: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [hexColor.withOpacity(0.5), hexColor],
              ),
              unselectedGradientColor: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Colors.white],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.wp),
              child: Icon(
                IconData(task.icon, fontFamily: 'MaterialIcons'),
                color: hexColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.wp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0.sp,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 2.0.wp,
                  ),
                  Text(
                    '${task.todos?.length ?? 0} Task',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
