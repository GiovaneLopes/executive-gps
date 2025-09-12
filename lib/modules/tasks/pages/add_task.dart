import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:executive_gps/modules/home/home_routes.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:executive_gps/modules/shared/ui/custom_dialog.dart';
import 'package:executive_gps/modules/shared/resources/styles.dart';
import 'package:executive_gps/modules/shared/ui/snackbar_widget.dart';
import 'package:executive_gps/modules/tasks/blocs/task/task_bloc.dart';
import 'package:executive_gps/libs/modules/tasks/models/task_type.dart';
import 'package:executive_gps/modules/shared/resources/app_colors.dart';
import 'package:executive_gps/libs/modules/tasks/models/task_step.dart';
import 'package:executive_gps/libs/modules/tasks/models/task_model.dart';
import 'package:executive_gps/modules/shared/utils/input_validators.dart';
import 'package:executive_gps/modules/employees/blocs/employee_bloc.dart';
import 'package:executive_gps/modules/customers/blocs/customer_bloc.dart';
import 'package:executive_gps/modules/shared/ui/custom_text_form_field.dart';
import 'package:executive_gps/modules/shared/ui/custom_elevated_button.dart';
import 'package:executive_gps/libs/modules/employees/models/employee_model.dart';
import 'package:executive_gps/libs/modules/customers/models/customer_model.dart';
import 'package:executive_gps/modules/shared/ui/custom_dropdown_button_form_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final bloc = Modular.get<TaskBloc>();
  final formKey = GlobalKey<FormState>();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final vehiclePlateController = TextEditingController();
  final observationController = TextEditingController();
  String? customerId;
  String? employeeId;
  TaskType? taskType;
  DateTime? dueDate;
  TaskStep step = TaskStep.scheduled;

  @override
  void initState() {
    super.initState();
    if (bloc.state.selectedTask != null) {
      final selectedTask = bloc.state.selectedTask!;
      customerId = selectedTask.customerId;
      employeeId = selectedTask.employeeId;
      taskType = selectedTask.type;
      step = selectedTask.step;
      dueDate = selectedTask.dueDate;
      dateController.text =
          '${selectedTask.dueDate.day}/${selectedTask.dueDate.month}/${selectedTask.dueDate.year}';
      timeController.text =
          '${selectedTask.dueDate.hour.toString().padLeft(2, '0')}:${selectedTask.dueDate.minute.toString().padLeft(2, '0')}';
      vehiclePlateController.text = selectedTask.vehiclePlate;
      observationController.text = selectedTask.observation ?? '';
    }
  }

  void validateForm() {
    if (formKey.currentState!.validate()) {
      final task = TaskModel(
        id: bloc.state.selectedTask?.id,
        step: step,
        type: taskType ?? TaskType.installation,
        dueDate: dueDate ?? DateTime.now(),
        customerId: customerId ?? '',
        employeeId: employeeId ?? '',
        vehiclePlate: vehiclePlateController.text,
        observation: observationController.text,
      );
      if (bloc.state.selectedTask != null) {
        bloc.updateTask(task);
      } else {
        bloc.addTask(task);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          bloc.state.selectedTask == null
              ? 'Nova atividade'
              : 'Editar atividade',
          style: Styles.bodyMedium,
        ),
        actions: [
          Visibility(
            visible: bloc.state.selectedTask != null,
            child: IconButton(
              icon: const Icon(FeatherIcons.trash2, color: Colors.red),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CustomDialog(
                      title: 'Excluir atividade',
                      content: Text(
                        'Você tem certeza que deseja excluir este atividade?',
                        style: Styles.bodySmall,
                      ),
                      onTap: (confirm) {
                        if (confirm) {
                          bloc.deleteTask();
                          Modular.to.popUntil((route) =>
                              route.settings.name == HomeRoutes.home.module);
                        } else {
                          Modular.to.pop();
                        }
                      },
                    );
                  },
                );
              },
            ),
          )
        ],
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primary,
          ),
          onPressed: Modular.to.pop,
        ),
      ),
      persistentFooterButtons: [
        BlocConsumer<TaskBloc, TaskState>(
          bloc: bloc,
          listener: (context, state) {
            if (state.status == TaskStatus.error) {
              SnackbarWidget.mostrar(
                context,
                title: 'Erro',
                message: state.error?.message,
                type: SnackbarWidgetType.error,
              );
            }
          },
          builder: (context, state) {
            return CustomElevatedButton(
              onPressed: validateForm,
              loading: state.status == TaskStatus.loading,
              label: 'Salvar',
            );
          },
        ),
      ],
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: BlocConsumer<TaskBloc, TaskState>(
            bloc: bloc,
            listener: (context, state) {
              if (state.status == TaskStatus.success) {
                Modular.to.popUntil(
                    (route) => route.settings.name == HomeRoutes.home.module);
              }
            },
            builder: (context, state) {
              return Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cliente',
                      style: Styles.bodyMedium,
                    ),
                    SizedBox(height: 12.h),
                    CustomDropdownButtonFormField<CustomerModel>(
                      initialValue: state.selectedTask?.customer,
                      isDense: false,
                      dropdownItems: Modular.get<CustomerBloc>()
                          .state
                          .customers
                          .map((customer) {
                        return DropdownMenuItem<CustomerModel>(
                          value: customer,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                customer.name,
                                style: Styles.bodySmall,
                              ),
                              Text(
                                '${customer.address.logradouro}, ${customer.address.numero} - ${customer.address.bairro}, ${customer.address.localidade} - ${customer.address.uf}',
                                style: Styles.bodySmall
                                    .copyWith(color: AppColors.grey),
                              ),
                              SizedBox(height: 4.h),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (customer) => customerId = customer?.id,
                    ),
                    SizedBox(height: 14.h),
                    Text(
                      'Colaborador',
                      style: Styles.bodyMedium,
                    ),
                    SizedBox(height: 12.h),
                    CustomDropdownButtonFormField<EmployeeModel>(
                      initialValue: state.selectedTask?.employee,
                      items: Modular.get<EmployeeBloc>().state.employees,
                      onChanged: (employee) => employeeId = employee?.id,
                    ),
                    Text(
                      'Status da atividade',
                      style: Styles.bodyMedium,
                    ),
                    SizedBox(height: 12.h),
                    CustomDropdownButtonFormField<TaskStep>(
                      initialValue: step,
                      dropdownItems: TaskStep.creationTask.map((step) {
                        return DropdownMenuItem<TaskStep>(
                          value: step,
                          child: Text(step.toString()),
                        );
                      }).toList(),
                      onChanged: (value) => step = value ?? TaskStep.scheduled,
                    ),
                    SizedBox(height: 14.h),
                    Text(
                      'Tipo de atividade',
                      style: Styles.bodyMedium,
                    ),
                    SizedBox(height: 12.h),
                    CustomDropdownButtonFormField(
                      initialValue: taskType,
                      items: TaskType.allValues,
                      onChanged: (type) => taskType = type,
                    ),
                    SizedBox(height: 14.h),
                    Text(
                      'Data da visita',
                      style: Styles.bodyMedium,
                    ),
                    SizedBox(height: 12.h),
                    TextFormField(
                      readOnly: true,
                      validator: InputValidators.validateEmpty,
                      controller: dateController,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        dateController.text = pickedDate != null
                            ? '${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}'
                            : '';
                        if (pickedDate != null) {
                          dueDate = DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            dueDate?.hour ?? 0,
                            dueDate?.minute ?? 0,
                          );
                        }
                      },
                      decoration: InputDecoration(
                        hintText: dueDate != null
                            ? '${dueDate!.day}/${dueDate!.month}/${dueDate!.year}'
                            : 'Selecione a data',
                        hintStyle: Styles.bodySmall,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 14.h,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(
                            color: AppColors.grey,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(
                            color: AppColors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 14.h),
                    Text(
                      'Hora da visita',
                      style: Styles.bodyMedium,
                    ),
                    SizedBox(height: 12.h),
                    TextFormField(
                      readOnly: true,
                      validator: InputValidators.validateEmpty,
                      controller: timeController,
                      onTap: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        timeController.text = pickedTime != null
                            ? '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}'
                            : '';
                        if (pickedTime != null) {
                          dueDate = DateTime(
                            dueDate?.year ?? DateTime.now().year,
                            dueDate?.month ?? DateTime.now().month,
                            dueDate?.day ?? DateTime.now().day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );
                        }
                      },
                      decoration: InputDecoration(
                        hintText: dueDate != null
                            ? '${dueDate!.day}/${dueDate!.month}/${dueDate!.year}'
                            : 'Selecione a data',
                        hintStyle: Styles.bodySmall,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 14.h,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(
                            color: AppColors.grey,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(
                            color: AppColors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 14.h),
                    Text(
                      'Placa',
                      style: Styles.bodyMedium,
                    ),
                    SizedBox(height: 12.h),
                    CustomTextFormField.light(
                      labelText: 'Placa do veículo',
                      controller: vehiclePlateController,
                      validator: InputValidators.validateEmpty,
                    ),
                    SizedBox(height: 14.h),
                    Text(
                      'Observações',
                      style: Styles.bodyMedium,
                    ),
                    SizedBox(height: 12.h),
                    CustomTextFormField.light(
                      labelText: 'Observações',
                      controller: observationController,
                      maxLines: 3,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
