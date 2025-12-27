import 'package:flutter/material.dart';
import 'package:task_manager_project/data/models/task_list_model_by_status.dart';
import 'package:task_manager_project/data/services/network_caller.dart';
import 'package:task_manager_project/ui/controllers/auth_controllers.dart';
import 'package:task_manager_project/ui/utils/snack_bar.dart';
import 'package:task_manager_project/ui/widgets/background_screen_widget.dart';
import 'package:task_manager_project/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager_project/ui/widgets/task_item_widget.dart';

import '../utils/api_urls.dart';
import '../widgets/tm_app_bar_widget.dart';

class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
  bool _getCanceledTaskListInProgress = false;
  TaskListModelByStatus? canceledTaskListModel;

  @override
  void initState() {
    super.initState();
    _getCanceledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      appBar: const TMAppBar(),
      child: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        child: RefreshIndicator(
          onRefresh: () {
            return _getCanceledTaskList(isRefreshing: true);
          },
          child: Visibility(
            visible: _getCanceledTaskListInProgress == false,
            replacement: const CenteredCircularProgressIndicator(),
            child: _buildTaskListView(),
          ),
        ),
      ),
    );
  }

  ListView _buildTaskListView() {
    return ListView.builder(
      itemCount: canceledTaskListModel?.taskModelList?.length ?? 0,
      itemBuilder: (context, index) {
        return TaskItemWidget(
          taskModel: canceledTaskListModel!.taskModelList![index],
          onTaskDelete: () {
            _getCanceledTaskList();
          },
        );
      },
    );
  }

  Future<void> _getCanceledTaskList({bool isRefreshing = false}) async {
    if (!isRefreshing) {
      setState(() {
        _getCanceledTaskListInProgress = true;
      });
    }
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: ApiUrls.taskListByStatusUrl(status: 'Canceled'),
    );
    if (response.isSuccess) {
      canceledTaskListModel =
          TaskListModelByStatus.fromJson(response.responseBody);
      _getCanceledTaskListInProgress = false;
      if (mounted) {
        setState(
            () {}); //here,we are doing setState if the screen is alive,so it's updating 'canceledTaskListModel' & making '_getCanceledTaskListInProgress = false'(if it was false then stays false and if it was true then makes false)
      }
    } else {
      snackBar(context: context, text: response.errorMessage);
    }
  }
}
