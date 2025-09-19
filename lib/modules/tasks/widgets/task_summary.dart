import 'dart:io';

import 'package:executive_gps/libs/modules/employees/models/image_model.dart';
import 'package:executive_gps/libs/modules/tasks/models/task_answers_model.dart';
import 'package:executive_gps/libs/modules/tasks/models/task_image_type.dart';
import 'package:executive_gps/modules/customers/widgets/info_line.dart';
import 'package:executive_gps/modules/shared/resources/app_colors.dart';
import 'package:executive_gps/modules/shared/resources/styles.dart';
import 'package:executive_gps/modules/tasks/blocs/task_employee/task_employee_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskSummary extends StatelessWidget {
  final TaskAnswersModel answers;
  const TaskSummary({
    super.key,
    required this.answers,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = Modular.get<TaskEmployeeBloc>();
    return BlocBuilder<TaskEmployeeBloc, TaskEmployeeState>(
        bloc: bloc,
        builder: (context, state) {
          return Column(
            children: [
              ExpansionTile(
                title: Row(
                  children: [
                    Icon(
                      FeatherIcons.checkCircle,
                      color: Colors.green,
                      size: 18.w,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Checklist',
                      style: Styles.body,
                    ),
                  ],
                ),
                children: [
                  ...answers.checklist.entries.map(
                    (entry) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Column(
                          children: [
                            InfoLine(
                              label: entry.key,
                              value: entry.value ?? '',
                            ),
                            const Divider(),
                          ],
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InfoLine(
                          label: 'Quilometragem',
                          value: '${answers.km} km',
                        ),
                        const Divider(),
                        InfoLine(
                          label: 'Luz de injeção (ABS/Air Bag)',
                          value: '${answers.injectionLight ? 'Sim' : 'Não'} ',
                        ),
                        Visibility(
                          visible: answers.observation != null &&
                              answers.observation!.isNotEmpty,
                          child: Column(
                            children: [
                              const Divider(),
                              InfoLine(
                                label: 'Observações',
                                value: answers.observation ?? '',
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        _photoContent('Assinatura do cliente',
                            state.image(TaskImageType.signature)),
                        SizedBox(height: 12.h)
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(),
              ExpansionTile(
                title: Row(
                  children: [
                    Icon(
                      FeatherIcons.image,
                      color: Colors.green,
                      size: 18.w,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Fotos',
                      style: Styles.body,
                    ),
                  ],
                ),
                children: [
                  Wrap(
                    runSpacing: 16.w,
                    spacing: 16.w,
                    children: [
                      _photoContent(
                        'Local do cliente',
                        state.image(TaskImageType.customerPlace),
                      ),
                      _photoContent(
                        'Id do equipamento',
                        state.image(TaskImageType.equipmentId),
                      ),
                      _photoContent(
                        'Chassi do veículo',
                        state.image(TaskImageType.chassi),
                      ),
                      _photoContent(
                        'Frontal veículo',
                        state.image(TaskImageType.vehicleFront),
                      ),
                      _photoContent(
                        'Fiação',
                        state.image(TaskImageType.wiring),
                      ),
                      _photoContent(
                        'Adicional (opcional)',
                        state.image(TaskImageType.additional),
                      ),
                      _photoContent(
                        'Adicional (opcional)',
                        state.image(TaskImageType.additional),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h)
                ],
              ),
            ],
          );
        });
  }

  Widget _photoContent(String title, ImageModel? image) {
    return Visibility(
      visible: image?.url != null || image?.file?.path != null,
      child: Column(
        children: [
          Text(
            title,
            style: Styles.bodySmall,
          ),
          SizedBox(height: 12.h),
          InkWell(
            onTap: () =>
                Modular.to.pushNamed('/image-details', arguments: image),
            child: Container(
              width: 125.w,
              height: 125.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.grey, width: 1.w),
                image: image?.url != null
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(image?.url ?? ''),
                      )
                    : DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(File(image?.file?.path ?? '')),
                      ),
              ),
              child: const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
