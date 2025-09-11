import 'package:executive_gps/libs/modules/employees/models/image_model.dart';
import 'package:executive_gps/libs/modules/tasks/models/task_image_model.dart';
import 'package:executive_gps/libs/modules/tasks/models/task_image_type.dart';
import 'package:executive_gps/modules/shared/resources/app_colors.dart';
import 'package:executive_gps/modules/shared/resources/styles.dart';
import 'package:executive_gps/modules/shared/ui/custom_elevated_button.dart';
import 'package:executive_gps/modules/tasks/blocs/task_employee/task_employee_bloc.dart';
import 'package:executive_gps/modules/tasks/widgets/new_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskPhotosPage extends StatefulWidget {
  const TaskPhotosPage({super.key});

  @override
  State<TaskPhotosPage> createState() => _TaskPhotosPageState();
}

class _TaskPhotosPageState extends State<TaskPhotosPage> {
  final bloc = Modular.get<TaskEmployeeBloc>();
  bool validated = false;

  void validate() {
    setState(() {
      validated = true;
    });

    if (bloc.state.image(TaskImageType.customerPlace) != null &&
        bloc.state.image(TaskImageType.equipmentId) != null &&
        bloc.state.image(TaskImageType.chassi) != null &&
        bloc.state.image(TaskImageType.vehicleFront) != null &&
        bloc.state.image(TaskImageType.wiring) != null) {
      bloc.summaryRequested();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fotos'),
        centerTitle: true,
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
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.w),
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.start,
                spacing: 12.w,
                runSpacing: 12.h,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Visibility(
                                  visible: validated &&
                                      state
                                              .image(
                                                  TaskImageType.customerPlace)
                                              ?.file ==
                                          null,
                                  child: const Icon(FeatherIcons.alertCircle,
                                      color: Colors.redAccent),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Local do cliente',
                                  style: Styles.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          NewPhoto(
                            image: state.image(TaskImageType.customerPlace),
                            onImageSelected: (image) {
                              bloc.updateImages(
                                image != null
                                    ? TaskImageModel(
                                        type: TaskImageType.customerPlace,
                                        file: image.file,
                                        name: 'customer_place.png',
                                      )
                                    : null,
                              );
                            },
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Visibility(
                                  visible: validated &&
                                      state
                                              .image(
                                                  TaskImageType.customerPlace)
                                              ?.file ==
                                          null,
                                  child: const Icon(
                                    FeatherIcons.alertCircle,
                                    color: Colors.red,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Id do equipamento',
                                  style: Styles.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          NewPhoto(
                            image: state.image(TaskImageType.equipmentId),
                            onImageSelected: (ImageModel? image) {
                              bloc.updateImages(
                                image != null
                                    ? TaskImageModel(
                                        type: TaskImageType.equipmentId,
                                        file: image.file,
                                        name: 'equipment_id.png',
                                      )
                                    : null,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Visibility(
                                  visible: validated &&
                                      state.image(TaskImageType.chassi)?.file ==
                                          null,
                                  child: const Icon(
                                    FeatherIcons.alertCircle,
                                    color: Colors.red,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Chassi do veículo',
                                  style: Styles.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          NewPhoto(
                            image: state.image(TaskImageType.chassi),
                            onImageSelected: (image) {
                              bloc.updateImages(
                                image != null
                                    ? TaskImageModel(
                                        type: TaskImageType.chassi,
                                        file: image.file,
                                        name: 'chassi.png',
                                      )
                                    : null,
                              );
                            },
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Visibility(
                                  visible: validated &&
                                      state
                                              .image(TaskImageType.vehicleFront)
                                              ?.file ==
                                          null,
                                  child: const Icon(
                                    FeatherIcons.alertCircle,
                                    color: Colors.red,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Frontal veículo',
                                  style: Styles.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          NewPhoto(
                            image: state.image(TaskImageType.vehicleFront),
                            onImageSelected: (image) {
                              bloc.updateImages(
                                image != null
                                    ? TaskImageModel(
                                        type: TaskImageType.vehicleFront,
                                        file: image.file,
                                        name: 'vehicle_front.png',
                                      )
                                    : null,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Visibility(
                                  visible: validated &&
                                      state.image(TaskImageType.wiring)?.file ==
                                          null,
                                  child: const Icon(
                                    FeatherIcons.alertCircle,
                                    color: Colors.red,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Fiação',
                                  style: Styles.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          NewPhoto(
                            image: state.image(TaskImageType.wiring),
                            onImageSelected: (image) {
                              bloc.updateImages(
                                image != null
                                    ? TaskImageModel(
                                        type: TaskImageType.wiring,
                                        file: image.file,
                                        name: 'wiring.png',
                                      )
                                    : null,
                              );
                            },
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: Text(
                              'Adicional (opcional)',
                              style: Styles.bodySmall,
                            ),
                          ),
                          NewPhoto(
                            image: state.image(TaskImageType.additional),
                            onImageSelected: (image) {
                              bloc.updateImages(
                                image != null
                                    ? TaskImageModel(
                                        type: TaskImageType.additional,
                                        file: image.file,
                                        name: 'additional.png',
                                      )
                                    : null,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
