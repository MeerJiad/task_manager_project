import 'package:flutter/material.dart';
import 'package:task_manager_project/data/models/task_count_by_status_model.dart';
import 'package:task_manager_project/data/models/task_list_model_by_status.dart';
import 'package:task_manager_project/data/services/network_caller.dart';
import 'package:task_manager_project/ui/utils/api_urls.dart';
import 'package:task_manager_project/ui/utils/snack_bar.dart';
import 'package:task_manager_project/ui/widgets/background_screen_widget.dart';
import 'package:task_manager_project/ui/widgets/centered_circular_progress_indicator.dart';
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
  void initState() {
    super.initState();
    _initialization();
  }

  bool _showLoader = false;
  TaskCountByStatusModel?
      taskCountByStatusModel; //Just created the object of 'TaskCountByStatusModel'.We will initialize that in the api call
  TaskListModelByStatus? newTaskListModel;

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
      child: RefreshIndicator(
        onRefresh: () {
          return _initialization(isRefreshing: true);
        },
        child: Visibility(
          visible: _showLoader == false,
          replacement: const CenteredCircularProgressIndicator(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
              child: Column(
                children: [
                  _buildTaskSummaryByStatus(),
                  _buildTaskListView(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskListView() {
    return ListView.builder(
      itemCount: newTaskListModel?.taskModelList?.length ?? 0,
      shrinkWrap: true,
      primary: false,
      //We are declaring that column's behavior is main here,then no problem will occur for scrollView
      itemBuilder: (context, index) {
        return TaskItemWidget(
          taskModel: newTaskListModel!.taskModelList![index],
          onTaskDelete: () {
            _initialization();
          },
        );
      },
    );
  }

  Widget _buildTaskSummaryByStatus() {
    return SizedBox(
      width: double.maxFinite,
      height: 70,
      child: ListView.builder(
          /*shrinkWrap: true,
          primary: false,*/ //gave this,but still it was not working because we have used two listView here and gave same thing,so used a sized box with fixed size,in any situation fixed size will work in these type of problems
          scrollDirection: Axis.horizontal,
          itemCount: taskCountByStatusModel?.taskStatusCountList?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            TaskStatusCountDataModel taskStatusCountDataModel =
                taskCountByStatusModel!.taskStatusCountList![index];
            //here,the index of taskStatusCountList means TaskStatusCountDataModel,because taskStatusCountList contains TaskStatusCountDataModel
            //it will not be null here because if it is null then 'item count' will be zero and 'ListView.builder' will never come to 'itemBuilder' and the 'index' we are giving here,that is item Builder's index
            return TaskStatusSummaryCardWidget(
                taskTitle: taskStatusCountDataModel.id ?? '',
                taskCount: taskStatusCountDataModel.sum.toString());
          }),
    );
  }

  Future<void> _initialization({bool isRefreshing = false}) async {
    if (!isRefreshing) {
      setState(() {
        _showLoader = true;
      });
    }
    /*  await _getTaskCountByStatus();
    await _getNewTaskList();*/
    await Future.wait([              //Same work happening in a good way than we did before we will until these two api calling is done and two api will be called parallaly,so it will consume less time now as before it awaited then first one called after that awaited for second one calling
      _getTaskCountByStatus(),
      _getNewTaskList(),
    ]);
    _showLoader = false;
    if (mounted) {                    //It will only do setState if the screen is alive
      setState(() {});
    }
  }

  Future<void> _getTaskCountByStatus() async {
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: ApiUrls.taskStatusCountUrl,
    );

    if (response.isSuccess) {
      taskCountByStatusModel =
          TaskCountByStatusModel.fromJson(response.responseBody);
      /* setState(
          () {});*/ //We are doing setState here because we are updating the value of 'taskCountByStatusModel' by creating a instance and we need to show that on screen,so we are doing setState here,instead of on the line of ' _getTaskCountByStatusInProgress = false; ' , In this way by this setState,the loader is being disabled and data is being shown
    } else {
      snackBar(context: context, text: response.errorMessage);
    }
  }

  Future<void> _getNewTaskList() async {
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: ApiUrls.taskListByStatusUrl(status: 'New'),
    );

    if (response.isSuccess) {
      newTaskListModel = TaskListModelByStatus.fromJson(response.responseBody);
      /* setState(() {});*/
    } else {
      snackBar(context: context, text: response.errorMessage);
    }
  }
}
