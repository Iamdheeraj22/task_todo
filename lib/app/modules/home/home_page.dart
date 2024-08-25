import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:task_todo/app/core/utils/extensions.dart';
import 'package:task_todo/app/data/models/task.dart';
import 'package:task_todo/app/modules/home/home_controller.dart';
import 'package:task_todo/app/modules/home/widgets/add_card_view.dart';
import 'package:task_todo/app/modules/home/widgets/add_todo_dialog.dart';
import 'package:task_todo/app/modules/home/widgets/task_card_view.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(4.0.wp),
          children: [
            Text(
              'My List',
              style: TextStyle(
                fontSize: 24.0.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 3.0.hp,
            ),
            Obx(
              () => GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                mainAxisSpacing: 2.0.hp,
                children: [
                  ...controller.tasks
                      .map((e) => LongPressDraggable(
                          data: e,
                          onDragStarted: () {
                            controller.changeDeletingStatus(true);
                          },
                          onDraggableCanceled: (_, __) {
                            controller.changeDeletingStatus(false);
                          },
                          onDragEnd: (_) {
                            controller.changeDeletingStatus(false);
                          },
                          feedback: Opacity(
                            opacity: 0.8,
                            child: TaskCardView(task: e),
                          ),
                          child: TaskCardView(task: e)))
                      .toList(),
                  AddCardView(),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: DragTarget<Task>(
        builder: (_, __, ___) => Obx(
          () => FloatingActionButton(
            backgroundColor:
                controller.deleting.value ? Colors.red : Colors.blue,
            onPressed: () {
              if (controller.tasks.isNotEmpty) {
                Get.to(() => AddDialog(), transition: Transition.downToUp);
              } else {
                EasyLoading.showInfo('Please create a task first');
              }
            },
            child: Icon(
              controller.deleting.value ? Icons.delete : Icons.add,
              color: Colors.white,
            ),
          ),
        ),
        onAcceptWithDetails: (v) {
          controller.deleteTask(v.data);
          EasyLoading.showSuccess('Delete Success');
        },
      ),
    );
  }
}
