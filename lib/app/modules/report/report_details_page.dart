import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:task_todo/app/core/utils/extensions.dart';
import 'package:task_todo/app/modules/home/home_controller.dart';

class ReportDetailsPage extends StatelessWidget {
  ReportDetailsPage({super.key});
  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () {
            var createdTasks = controller.getTotalTask();
            var completedTasks = controller.getTotalDoneTask();
            var liveTasks = createdTasks - completedTasks;
            var percentage = (completedTasks / createdTasks) * 100;
            return Padding(
              padding: EdgeInsets.all(4.0.wp),
              child: ListView(
                children: [
                  Text(
                    'My Report',
                    style: TextStyle(
                      fontSize: 24.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 3.0.hp,
                  ),
                  Text(
                    DateFormat.yMMMMd().format(DateTime.now()).toString(),
                    style: TextStyle(
                      fontSize: 16.0.sp,
                      color: Colors.grey,
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 2.0.hp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReportStatus(
                        color: Colors.green,
                        title: 'Live Tasks',
                        number: liveTasks,
                      ),
                      ReportStatus(
                        color: Colors.orange,
                        title: 'Completed Tasks',
                        number: completedTasks,
                      ),
                      ReportStatus(
                        color: Colors.blue,
                        title: 'Created Tasks',
                        number: createdTasks,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.0.hp,
                  ),
                  UnconstrainedBox(
                    child: SizedBox(
                      height: 70.0.wp,
                      width: 70.0.wp,
                      child: CircularStepProgressIndicator(
                        totalSteps: createdTasks == 0 ? 1 : createdTasks,
                        currentStep: completedTasks,
                        stepSize: 20,
                        selectedColor: Colors.green,
                        unselectedColor: Colors.grey[200],
                        padding: 0,
                        height: 150,
                        width: 150,
                        selectedStepSize: 22,
                        roundedCap: (_, __) => true,
                        removeRoundedCapExtraAngle: true,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${createdTasks == 0 ? 0 : percentage} %',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0.sp),
                            ),
                            Text(
                              'Efficiency',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0.sp,
                                  color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ReportStatus extends StatelessWidget {
  const ReportStatus({
    super.key,
    required this.color,
    required this.title,
    required this.number,
  });
  final Color color;
  final String title;
  final int number;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 3.0.wp,
          width: 3.0.wp,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: color,
              width: 0.5.wp,
            ),
          ),
        ),
        SizedBox(
          width: 2.0.wp,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$number',
              style: TextStyle(
                fontSize: 16.0.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 2.0.wp,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12.0.sp,
                color: Colors.grey,
              ),
            ),
          ],
        )
      ],
    );
  }
}
