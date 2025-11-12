import 'package:flutter/material.dart';

class TaskStatusSummaryCardWidget extends StatelessWidget {
  const TaskStatusSummaryCardWidget({
    super.key, required this.taskTitle, required this.taskCount,
  });
final String taskTitle;
final String taskCount;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
          child: Column(
            children: [
              Text(
                taskCount,
                style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Text(
                taskTitle,
                style: textTheme.bodyMedium?.copyWith(fontSize: 12),
              ),
            ],
          ),
        ));
  }
}
