import 'package:flutter/material.dart';

class TaskStatusSummaryCardWidget extends StatelessWidget {
  const TaskStatusSummaryCardWidget({
    super.key,
    required this.taskTitle,
    required this.taskCount,
  });

  final String taskTitle;
  final String taskCount;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 70,
      width: 100,
      child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(taskCount, style: textTheme.titleMedium),
              Text(
                taskTitle,
                style: textTheme.bodyMedium?.copyWith(fontSize: 12),
              ),
            ],
          )),
    );
  }
}
