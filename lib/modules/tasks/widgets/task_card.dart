import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:executive_gps/modules/shared/resources/styles.dart';
import 'package:executive_gps/modules/tasks/blocs/task/task_bloc.dart';
import 'package:executive_gps/modules/shared/resources/app_colors.dart';
import 'package:executive_gps/libs/modules/tasks/models/task_step.dart';
import 'package:executive_gps/libs/modules/tasks/models/task_model.dart';
import 'package:executive_gps/modules/customers/widgets/info_action_line.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final bloc = Modular.get<TaskBloc>();
    return InkWell(
      onTap: () => bloc.selectTask(task),
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        FeatherIcons.calendar,
                        color: AppColors.primaryDark,
                        size: 16.w,
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          '${task.dueDate.day.toString().padLeft(2, '0')}/${task.dueDate.month.toString().padLeft(2, '0')}/${task.dueDate.year} - ${task.dueDate.hour.toString().padLeft(2, '0')}h${task.dueDate.minute.toString().padLeft(2, '0')}',
                          style: Styles.bodySmall.copyWith(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 12.w,
                            width: 12.w,
                            margin: EdgeInsets.only(right: 4.w),
                            decoration: BoxDecoration(
                              color: TaskStep.getColor(task.step),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Text(
                            task.step.toString(),
                            style: Styles.bodySmall.copyWith(
                              color: TaskStep.getColor(task.step),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Icon(
                        FeatherIcons.mapPin,
                        color: AppColors.primaryDark,
                        size: 16.w,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        task.customer?.name ?? 'Cliente não informado',
                        style: Styles.bodySmall
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Text(
                        task.customer?.mobile ?? 'Telefone não informado',
                        style: Styles.bodySmall,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Text(
                        task.type.toString(),
                        style: Styles.bodySmall,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Text(
                        'Placa: ${task.vehiclePlate}',
                        style: Styles.bodySmall,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  InfoAction(
                    value: task.customer?.address.toString() ??
                        'Endereço não informado',
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 12.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    FeatherIcons.user,
                    size: 16.w,
                    color: AppColors.primaryDark,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    task.employee?.name ?? 'Funcionário não informado',
                    style:
                        Styles.bodySmall.copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
