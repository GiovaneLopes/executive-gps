import 'package:executive_gps/modules/shared/resources/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskFillTile extends StatelessWidget {
  final String title;
  final bool isCompleted;
  final Widget content;
  const TaskFillTile({
    super.key,
    required this.title,
    required this.content,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        children: [
          Icon(
            isCompleted ? FeatherIcons.checkCircle : FeatherIcons.alertCircle,
            color: isCompleted ? Colors.green : Colors.red,
          ),
          SizedBox(width: 8.w),
          Text(
            title,
            style: Styles.bodySmall,
          ),
        ],
      ),
      children: [content],
    );
  }
}
