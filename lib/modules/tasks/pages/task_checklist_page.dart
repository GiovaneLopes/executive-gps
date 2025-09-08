import 'package:executive_gps/modules/shared/resources/app_colors.dart';
import 'package:executive_gps/modules/shared/resources/styles.dart';
import 'package:executive_gps/modules/shared/ui/custom_elevated_button.dart';
import 'package:executive_gps/modules/shared/ui/custom_text_form_field.dart';
import 'package:executive_gps/modules/shared/utils/input_validators.dart';
import 'package:executive_gps/modules/tasks/blocs/task_employee/task_employee_bloc.dart';
import 'package:executive_gps/modules/tasks/task_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskChecklistPage extends StatefulWidget {
  const TaskChecklistPage({super.key});

  @override
  State<TaskChecklistPage> createState() => _TaskChecklistPageState();
}

class _TaskChecklistPageState extends State<TaskChecklistPage> {
  final bloc = Modular.get<TaskEmployeeBloc>();
  final kmController = TextEditingController();
  final observationsController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool injectionLight = false;
  bool validated = false;

  void validate() async {
    setState(() {
      validated = true;
    });
    if (formKey.currentState?.validate() == true &&
        bloc.state.answers.signature != null &&
        bloc.state.isChecklistCompleted) {
      bloc.checklistFinished(
        injectionLight,
        kmController.text,
        observationsController.text,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    kmController.text = bloc.state.answers.km ?? '';
    injectionLight = bloc.state.answers.injectionLight;
    observationsController.text = bloc.state.answers.observation ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checklist'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primary,
          ),
          onPressed: Modular.to.pop,
        ),
      ),
      persistentFooterButtons: [
        CustomElevatedButton(
          onPressed: validate,
          label: 'Próximo',
        )
      ],
      body: BlocBuilder<TaskEmployeeBloc, TaskEmployeeState>(
          bloc: bloc,
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...state.answers.checklist.entries.map(
                        (entry) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Visibility(
                                      visible: validated && entry.value == null,
                                      child: Row(
                                        children: [
                                          Icon(
                                            FeatherIcons.alertCircle,
                                            size: 16.w,
                                            color: Colors.red,
                                          ),
                                          SizedBox(width: 4.w)
                                        ],
                                      ),
                                    ),
                                    Text(
                                      entry.key,
                                      style: Styles.bodySmall,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                Container(
                                  height: 33.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.primary,
                                    ),
                                    borderRadius: BorderRadius.circular(6.w),
                                  ),
                                  child: Row(
                                    children: List.generate(
                                        state.checklistAnswers.length, (item) {
                                      return Flexible(
                                        child: GestureDetector(
                                          onTap: () => setState(
                                            () => bloc.checklistUpdated(
                                              entry.key,
                                              state.checklistAnswers[item],
                                            ),
                                          ),
                                          child: Container(
                                            height: 33.h,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: entry.value ==
                                                      state.checklistAnswers[
                                                          item]
                                                  ? AppColors.primary
                                                  : null,
                                              border: Border(
                                                right: BorderSide(
                                                  color: AppColors.primary,
                                                  width: item ==
                                                          state.checklistAnswers
                                                                  .length -
                                                              1
                                                      ? 0
                                                      : 1,
                                                ),
                                              ),
                                            ),
                                            child: Text(
                                              state.checklistAnswers[item]
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                              style: Styles.bodySmall.copyWith(
                                                  color: AppColors.black),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Luz de injeção (ABS/Air Bag)',
                            style: Styles.bodySmall,
                          ),
                          Switch(
                            value: injectionLight,
                            activeColor: AppColors.primary,
                            onChanged: (value) {
                              setState(() {
                                injectionLight = value;
                              });
                            },
                          )
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'Quilometragem',
                        style: Styles.bodySmall,
                      ),
                      SizedBox(height: 12.h),
                      CustomTextFormField.light(
                        keyboardType: TextInputType.number,
                        validator: InputValidators.validateEmpty,
                        controller: kmController,
                      ),
                      SizedBox(height: 12.h),
                      InkWell(
                        onTap: TaskRoutes.signature.navigate,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.h, horizontal: 8.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.w),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                state.answers.signature == null
                                    ? FeatherIcons.alertCircle
                                    : FeatherIcons.checkCircle,
                                color: state.answers.signature == null
                                    ? Colors.red
                                    : Colors.green,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Assinatura',
                                style: Styles.bodySmall,
                              ),
                              const Spacer(),
                              const Icon(
                                FeatherIcons.chevronRight,
                                color: AppColors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'Observações',
                        style: Styles.bodySmall,
                      ),
                      SizedBox(height: 12.h),
                      CustomTextFormField.light(
                        maxLines: 3,
                        controller: observationsController,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
