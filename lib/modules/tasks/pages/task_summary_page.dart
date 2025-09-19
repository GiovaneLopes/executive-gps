import 'package:executive_gps/modules/customers/widgets/info_line.dart';
import 'package:executive_gps/modules/shared/resources/app_colors.dart';
import 'package:executive_gps/modules/shared/ui/custom_elevated_button.dart';
import 'package:executive_gps/modules/tasks/blocs/task_employee/task_employee_bloc.dart';
import 'package:executive_gps/modules/tasks/widgets/task_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signature/signature.dart';

class TaskSummaryPage extends StatefulWidget {
  const TaskSummaryPage({super.key});

  @override
  State<TaskSummaryPage> createState() => _TaskSummaryPageState();
}

class _TaskSummaryPageState extends State<TaskSummaryPage> {
  final bloc = Modular.get<TaskEmployeeBloc>();
  final SignatureController controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: AppColors.white,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Resumo'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primary,
          ),
          onPressed: Modular.to.pop,
        ),
      ),
      persistentFooterButtons: [
        BlocBuilder<TaskEmployeeBloc, TaskEmployeeState>(
          bloc: bloc,
          builder: (context, state) {
            return CustomElevatedButton(
              loading: state.status == TaskEmployeeStatus.loading,
              enabled: state.status != TaskEmployeeStatus.loading,
              onPressed: bloc.sendAnswers,
              label: 'Finalizar',
            );
          },
        )
      ],
      body: BlocConsumer<TaskEmployeeBloc, TaskEmployeeState>(
          bloc: bloc,
          listener: (context, state) {
            if (state.status == TaskEmployeeStatus.success) {
              Modular.to.popUntil(ModalRoute.withName('/home'));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Column(
                      children: [
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
                        InfoLine(
                          value:
                              '${state.selectedTask?.customer?.address.logradouro}, ${state.selectedTask?.customer?.address.numero} - ${state.selectedTask?.customer?.address.bairro}, ${state.selectedTask?.customer?.address.localidade} - ${state.selectedTask?.customer?.address.uf}',
                        ),
                        InfoLine(
                          label: 'Telefone',
                          value: state.selectedTask?.customer?.mobile ?? '',
                        ),
                        Visibility(
                          visible:
                              state.selectedTask?.observation?.isNotEmpty ??
                                  false,
                          child: InfoLine(
                            value:
                                'Observações: ${state.selectedTask?.observation}',
                          ),
                        ),
                      ],
                    ),
                  ),
                  TaskSummary(answers: state.answers),
                  SizedBox(height: 12.h),
                ],
              ),
            );
          }),
    );
  }
}
