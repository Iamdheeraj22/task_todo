import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_todo/app/core/utils/extensions.dart';
import 'package:task_todo/app/modules/home/home_controller.dart';

class DoingTodoListView extends StatelessWidget {
  DoingTodoListView({super.key});
  final ctrl = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => ctrl.doneTodos.isEmpty && ctrl.doingTodos.isEmpty
        ? Center(
            child: Text(
              'Add Task',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0.sp,
              ),
            ),
          )
        : ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              ...ctrl.doingTodos
                  .map(
                    (e) => Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 3.0.wp, horizontal: 9.0.wp),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: Checkbox(
                              value: e['isDone'] ?? false,
                              onChanged: (v) {
                                ctrl.doneTodo(e['title']);
                              },
                              fillColor: WidgetStateProperty.resolveWith(
                                (states) => Colors.grey[200],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 3.0.wp,
                          ),
                          Text(
                            e['title'],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14.0.sp,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                  .toList()
            ],
          ));
  }
}
