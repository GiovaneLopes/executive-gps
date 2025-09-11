import 'dart:io';

import 'package:executive_gps/libs/modules/tasks/models/task_image_type.dart';
import 'package:executive_gps/modules/shared/resources/app_colors.dart';
import 'package:executive_gps/modules/shared/ui/custom_elevated_button.dart';
import 'package:executive_gps/modules/tasks/blocs/task_employee/task_employee_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:signature/signature.dart';

class TaskSignaturePage extends StatefulWidget {
  const TaskSignaturePage({super.key});

  @override
  State<TaskSignaturePage> createState() => _TaskSignaturePageState();
}

class _TaskSignaturePageState extends State<TaskSignaturePage> {
  final bloc = Modular.get<TaskEmployeeBloc>();
  final SignatureController controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: AppColors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Assinatura'),
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
      floatingActionButton: Visibility(
        visible: bloc.state.image(TaskImageType.signature) != null,
        child: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {
            controller.clear();
            bloc.saveSignature(null);
            setState(() {});
          },
          child: const Icon(
            FeatherIcons.trash,
            color: Colors.white,
          ),
        ),
      ),
      persistentFooterButtons: bloc.state.image(TaskImageType.signature) == null
          ? [
              CustomElevatedButton(
                onPressed: () async {
                  var bytes = await controller.toPngBytes();
                  bloc.saveSignature(bytes);
                  Modular.to.pop();
                },
                label: 'Salvar',
              )
            ]
          : null,
      body: bloc.state.image(TaskImageType.signature) != null
          ? Center(
              child: Image.file(
                  File(bloc.state.image(TaskImageType.signature)!.file!.path)),
            )
          : Signature(
              controller: controller,
              backgroundColor: Colors.white,
            ),
    );
  }
}
