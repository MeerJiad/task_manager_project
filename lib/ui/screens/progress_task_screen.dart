import 'package:flutter/material.dart';
import 'package:task_manager_project/data/models/task_list_model_by_status.dart';
import 'package:task_manager_project/ui/widgets/background_screen_widget.dart';
import 'package:task_manager_project/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager_project/ui/widgets/task_item_widget.dart';
import 'package:task_manager_project/ui/widgets/tm_app_bar_widget.dart';
import '../../data/services/network_caller.dart';
import '../utils/api_urls.dart';
import '../utils/snack_bar.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool _getProgressTaskListInProgress = false;
  TaskListModelByStatus? inProgressTaskListModel;

  @override
  void initState() {
    super.initState();
    _getInProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      appBar: const TMAppBar(),
      child: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        child: RefreshIndicator(
          onRefresh: () => _getInProgressTaskList(isRefreshing: true),
          child: Visibility(
              visible: _getProgressTaskListInProgress == false,
              replacement: const CenteredCircularProgressIndicator(),
              child: _buildTaskListView()),
        ),
      ),
    );
  }

  ListView _buildTaskListView() {
    return ListView.builder(
      itemCount: inProgressTaskListModel?.taskModelList?.length ?? 0,
      itemBuilder: (context, index) {
        return TaskItemWidget(
          onTaskDelete: () {
            _getInProgressTaskList();
          },
          taskModel: inProgressTaskListModel!.taskModelList![index],
        );
      },
    );
  }

  Future<void> _getInProgressTaskList({bool isRefreshing = false}) async {
    if (!isRefreshing) {
      setState(() {
        _getProgressTaskListInProgress = true;
      });
    }
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: ApiUrls.taskListByStatusUrl(status: 'In Progress'),
    );
    if (response.isSuccess) {
      inProgressTaskListModel =
          TaskListModelByStatus.fromJson(response.responseBody);
      _getProgressTaskListInProgress = false;
      setState(() {});
    } else {
      snackBar(context: context, text: response.errorMessage);
    }
  }
}
