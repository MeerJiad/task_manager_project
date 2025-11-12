import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../utils/app_colors.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        tileColor: Colors.transparent,
        title: const Text('Task title'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Task description'),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Date : 08/11/2025',
              style: textTheme.labelMedium
                  ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
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
                  onPressed: () {},
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
