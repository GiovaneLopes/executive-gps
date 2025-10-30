import 'package:executive_gps/modules/customers/widgets/info_line.dart';
import 'package:executive_gps/modules/shared/utils/contact_helper.dart';
import 'package:executive_gps/modules/shared/utils/string_extension.dart';
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

class TaskExpansionTile extends StatelessWidget {
  final TaskModel task;
  const TaskExpansionTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final bloc = Modular.get<TaskBloc>();
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: ExpansionTile(
        collapsedBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        tilePadding: EdgeInsets.all(12.w),
        minTileHeight: 28.h,
        title: SizedBox(
          child: Row(
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
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        task.customer?.name.capitalize() ??
                            'Cliente não informado',
                        maxLines: 1,
                        style: Styles.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 78.w,
                child: Text(
                  task.type.toString(),
                  textAlign: TextAlign.center,
                  style: Styles.bodySmall,
                ),
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${task.dueDate.day.toString().padLeft(2, '0')}/${task.dueDate.month.toString().padLeft(2, '0')}/${(task.dueDate.year % 100).toString().padLeft(2, '0')}',
                    style: Styles.bodySmall.copyWith(fontSize: 11.sp),
                  ),
                  Text(
                    '${task.dueDate.hour.toString().padLeft(2, '0')}:${task.dueDate.minute.toString().padLeft(2, '0')}',
                    style: Styles.bodySmall.copyWith(fontSize: 11.sp),
                  ),
                ],
              ),
            ],
          ),
        ),
        children: [
          InkWell(
            onTap: () => bloc.selectTask(task),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          task.identifier ?? 'Identificador não informado',
                          style: Styles.bodySmall
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  InfoAction.call(
                    value: task.customer?.mobile ?? 'Telefone não informado',
                    onPressed: () =>
                        ContactHelper.call(task.customer?.mobile ?? ''),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Placa: ${task.vehiclePlate}',
                    style: Styles.bodySmall,
                  ),
                  SizedBox(height: 8.h),
                  InfoAction(
                    value: task.customer?.address.toString() ??
                        'Endereço não informado',
                  ),
                  Visibility(
                    visible: task.observation?.isNotEmpty ?? false,
                    child: Padding(
                      padding: EdgeInsets.only(top: 12.h),
                      child: InfoLine(
                        value: 'Observações: ${task.observation}',
                      ),
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
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
                          style: Styles.bodySmall
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
