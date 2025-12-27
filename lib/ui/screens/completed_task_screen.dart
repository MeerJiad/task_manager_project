import 'package:flutter/material.dart';
import 'package:task_manager_project/data/models/task_list_model_by_status.dart';
import 'package:task_manager_project/data/services/network_caller.dart';
import 'package:task_manager_project/ui/controllers/auth_controllers.dart';
import 'package:task_manager_project/ui/utils/snack_bar.dart';
import 'package:task_manager_project/ui/widgets/background_screen_widget.dart';
import 'package:task_manager_project/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager_project/ui/widgets/task_item_widget.dart';
import 'package:task_manager_project/ui/widgets/tm_app_bar_widget.dart';

import '../utils/api_urls.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _getCompletedTaskInProgress = false;
  TaskListModelByStatus? completedTaskListModel;

  @override
  void initState() {
    super.initState();
    _getCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      appBar: const TMAppBar(),
      child: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        //No padding in the bottom because it shows in the navigationBar
        child: RefreshIndicator(
          onRefresh: () {
            return _getCompletedTaskList(isRefreshing: true);
          },
          child: Visibility(
            visible: _getCompletedTaskInProgress == false,
            replacement: const CenteredCircularProgressIndicator(),
            child: _buildTaskListView(),
          ),
        ),
      ),
    );
  }

  ListView _buildTaskListView() {
    return ListView.builder(
      itemCount: completedTaskListModel?.taskModelList?.length ?? 0,
      itemBuilder: (context, index) {
        return TaskItemWidget(
          onTaskDelete: () {
            _getCompletedTaskList();
          },
          taskModel: completedTaskListModel!.taskModelList![index],
        );
      },
    );
  }

  Future<void> _getCompletedTaskList({bool isRefreshing = false}) async {
    if (!isRefreshing) {
      setState(() {
        _getCompletedTaskInProgress = true;
      });
    }
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: ApiUrls.taskListByStatusUrl(status: 'Completed'),
    );
    if (response.isSuccess) {
      completedTaskListModel =
          TaskListModelByStatus.fromJson(response.responseBody);
      _getCompletedTaskInProgress = false;
      if (mounted) {
        setState(() {});
      }
    } else {
      snackBar(context: context, text: response.errorMessage);
    }
  }
}
