import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/widgets/background_screen_widget.dart';
import 'package:task_manager_project/ui/widgets/task_item_widget.dart';
import 'package:task_manager_project/ui/widgets/tm_app_bar_widget.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      appBar: const TMAppBar(),
          child: Padding(
            padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
            child: _buildTaskListView(),
          ),
    );
  }

  ListView _buildTaskListView() {
    return ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: 10,
            itemBuilder: (context, index) {
              return const TaskItemWidget();
            },
          );
  }
}
