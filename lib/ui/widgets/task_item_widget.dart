import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_manager_project/ui/utils/snack_bar.dart';
import 'package:task_manager_project/ui/widgets/dialog_widget.dart';

import '../utils/app_colors.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        title: const Text('Task title'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 4,
            ),
            const Text('Task description'),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Date : 08/11/2025',
              style: textTheme.labelMedium,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Chip(
                  label: Text(
                    'Status',
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
                    dialogWidget(
                        context: context,
                        dialogTitle: "Are you sure?",
                        contentText: "Once deleted,this cannot be undone",
                        actions: [
                          OutlinedButton(
                              onPressed: () {
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
}
