import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/widgets/background_screen_widget.dart';
import '../widgets/task_item_widget.dart';
import '../widgets/task_status_summary_card_widget.dart';
import '../widgets/tm_app_bar_widget.dart';
import 'add_new_task_screen.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddNewTaskScreen.name);
        },
        child: const Icon(Icons.add),
      ),
      appBar: const TMAppBar(),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
          child: Column(
            children: [_buildTaskSummaryByStatus(), _buildTaskListView()],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskListView() {
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      primary: false,
      //We are declaring that column's behavior is main here,then no problem will occur for scrollView
      itemBuilder: (context, index) {
        return const TaskItemWidget();
      },
    );
  }
}

Widget _buildTaskSummaryByStatus() {
  return const SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        TaskStatusSummaryCardWidget(
          taskCount: '09',
          taskTitle: 'New Task',
        ),
        TaskStatusSummaryCardWidget(
          taskCount: '09',
          taskTitle: 'Completed',
        ),
        TaskStatusSummaryCardWidget(
          taskCount: '09',
          taskTitle: 'Canceled',
        ),
        TaskStatusSummaryCardWidget(
          taskCount: '09',
          taskTitle: 'Progress',
        ),
      ],
    ),
  );
}
