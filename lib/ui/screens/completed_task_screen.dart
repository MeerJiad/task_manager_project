import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/widgets/background_screen_widget.dart';
import 'package:task_manager_project/ui/widgets/task_item_widget.dart';
import 'package:task_manager_project/ui/widgets/tm_app_bar_widget.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      appBar: const TMAppBar(),
      child: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        //No padding in the bottom because it shows in the navigationBar
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
