import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_todo/app/core/utils/extensions.dart';
import 'package:task_todo/app/modules/home/home_controller.dart';

class DoneTodoListView extends StatelessWidget {
  DoneTodoListView({super.key});
  final ctrl = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ctrl.doneTodos.isEmpty
          ? const Center(
              child: Text('No one task is completed'),
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
              child: ListView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: [
                  Text(
                    'Completed(${ctrl.doneTodos.length})',
                    style: TextStyle(
                      fontSize: 14.0.sp,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  ...ctrl.doneTodos
                      .map((e) => Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 3.0.wp, horizontal: 6.0.wp),
                            child: Row(
                              children: [
                                const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Icon(Icons.done),
                                ),
                                SizedBox(
                                  width: 3.0.wp,
                                ),
                                Text(
                                  e['title'],
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ))
                      .toList()
                ],
              ),
            ),
    );
  }
}
