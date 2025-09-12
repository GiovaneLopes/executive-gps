import 'package:executive_gps/libs/modules/tasks/models/task_step.dart';
import 'package:executive_gps/modules/customers/widgets/info_action_line.dart';
import 'package:executive_gps/modules/customers/widgets/info_line.dart';
import 'package:executive_gps/modules/shared/resources/app_colors.dart';
import 'package:executive_gps/modules/shared/resources/styles.dart';
import 'package:executive_gps/modules/shared/ui/custom_elevated_button.dart';
import 'package:executive_gps/modules/shared/ui/snackbar_widget.dart';
import 'package:executive_gps/modules/shared/utils/contact_helper.dart';
import 'package:executive_gps/modules/tasks/task_routes.dart';
import 'package:executive_gps/modules/tasks/widgets/task_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:executive_gps/modules/tasks/blocs/task_employee/task_employee_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskDetailsPage extends StatelessWidget {
  const TaskDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = Modular.get<TaskEmployeeBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${bloc.state.selectedTask?.identifier}'),
            IconButton(
              onPressed: () {
                Clipboard.setData(
                  ClipboardData(
                      text: bloc.state.selectedTask?.identifier ?? ''),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          '${bloc.state.selectedTask?.identifier ?? ''} copiado com sucesso!')),
                );
              },
              icon: const Icon(
                FeatherIcons.copy,
                color: AppColors.primaryDark,
              ),
            ),
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primary,
          ),
          onPressed: () => Modular.to.pop(),
        ),
      ),
      persistentFooterButtons:
          bloc.state.selectedTask?.step == TaskStep.scheduled
              ? [
                  CustomElevatedButton(
                    onPressed: TaskRoutes.checklist.navigate,
                    label: 'Iniciar',
                  ),
                ]
              : null,
      body: BlocConsumer<TaskEmployeeBloc, TaskEmployeeState>(
        bloc: bloc,
        listener: (context, state) {
          if (state.status == TaskEmployeeStatus.error) {
            SnackbarWidget.mostrar(
              context,
              title: 'Erro',
              message: state.error?.message,
              type: SnackbarWidgetType.error,
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 12.w,
                            width: 12.w,
                            margin: EdgeInsets.only(right: 4.w),
                            decoration: BoxDecoration(
                              color:
                                  TaskStep.getColor(state.selectedTask?.step),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Text(
                            state.selectedTask?.step.toString() ?? '',
                            style: Styles.bodySmall.copyWith(
                              color:
                                  TaskStep.getColor(state.selectedTask?.step),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      InfoLine(
                        label: state.selectedTask?.customer?.name ?? '',
                        value:
                            '${state.selectedTask?.dueDate.day.toString().padLeft(2, '0')}/${state.selectedTask?.dueDate.month.toString().padLeft(2, '0')}/${state.selectedTask?.dueDate.year} - ${state.selectedTask?.dueDate.hour.toString().padLeft(2, '0')}h${state.selectedTask?.dueDate.minute.toString().padLeft(2, '0')}',
                      ),
                      SizedBox(height: 16.h),
                      InfoLine(
                        label: 'Placa',
                        value: state.selectedTask?.vehiclePlate ?? '',
                      ),
                      SizedBox(height: 16.h),
                      InfoLine(
                        label: 'Tipo',
                        value: state.selectedTask?.type.toString() ?? '',
                      ),
                      SizedBox(height: 16.h),
                      InfoAction(
                        value:
                            '${state.selectedTask?.customer?.address.logradouro}, ${state.selectedTask?.customer?.address.numero} - ${state.selectedTask?.customer?.address.bairro}, ${state.selectedTask?.customer?.address.localidade} - ${state.selectedTask?.customer?.address.uf}',
                      ),
                      InfoAction(
                        label: 'Telefone',
                        value: state.selectedTask?.customer?.mobile ?? '',
                      ),
                      Visibility(
                        visible: state.selectedTask?.observation?.isNotEmpty ??
                            false,
                        child: InfoLine(
                          value:
                              'Observações: ${state.selectedTask?.observation}',
                        ),
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.white,
                                foregroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.w),
                                  side: const BorderSide(
                                    color: AppColors.primary,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                              ),
                              onPressed: () => ContactHelper.call(
                                  state.selectedTask?.customer?.mobile ?? ''),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FeatherIcons.phoneCall,
                                    size: 16.w,
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Text(
                                    'Ligar',
                                    style: Styles.body,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.white,
                                foregroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.w),
                                  side: const BorderSide(
                                    color: AppColors.primary,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                              ),
                              onPressed: () => ContactHelper.whatsapp(
                                state.selectedTask?.customer?.mobile ?? '',
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FeatherIcons.messageCircle,
                                    size: 16.w,
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Text(
                                    'Whatsapp',
                                    style: Styles.body,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: state.selectedTask?.step == TaskStep.completed,
                  child: TaskSummary(answers: state.answers),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
