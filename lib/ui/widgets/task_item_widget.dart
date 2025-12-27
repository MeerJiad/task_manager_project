import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_manager_project/data/models/task_model.dart';
import 'package:task_manager_project/data/services/network_caller.dart';
import 'package:task_manager_project/ui/controllers/auth_controllers.dart';
import 'package:task_manager_project/ui/utils/api_urls.dart';
import 'package:task_manager_project/ui/utils/snack_bar.dart';
import 'package:task_manager_project/ui/widgets/dialog_widget.dart';

import '../utils/app_colors.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.taskModel,
    required this.onTaskDelete,
  });

  final TaskModel taskModel;
  final VoidCallback onTaskDelete;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        title: Text(taskModel.title ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 4,
            ),
            Text(taskModel.description ?? ''),
            const SizedBox(
              height: 8,
            ),
            Text(
              "Date: ${taskModel.createdDate ?? ''}",
              style: textTheme.labelMedium,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Chip(
                  label: Text(
                    taskModel.status ?? '',
                  ),
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: AppColors.themeColor,
                  ),
                  visualDensity: VisualDensity.compact,
                ),
                IconButton(
                  onPressed: () {
                    showDialogMethod(
                        context: context,
                        dialogTitle: "Are you sure?",
                        contentText: "Once deleted,this cannot be undone",
                        actions: [
                          OutlinedButton(
                              onPressed: () {
                                _deleteTask();
                                onTaskDelete();
                                Navigator.pop(context);
                                snackBar(
                                    context: context, text: 'Task deleted!!');
                              },
                              child: const Text('Yes')),
                          OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('No')),
                        ]);
                  },
                  icon: const Icon(
                    CupertinoIcons.delete_simple,
                    color: Colors.red,
                  ),
                  visualDensity: VisualDensity.compact,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _deleteTask() async {
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: ApiUrls.deleteTaskUrl(id: taskModel.id!));
  }
}
