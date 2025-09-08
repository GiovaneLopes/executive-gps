import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:executive_gps/libs/modules/employees/models/image_model.dart';
import 'package:executive_gps/libs/modules/tasks/models/task_answers_model.dart';
import 'package:executive_gps/modules/shared/utils/app_route.dart';
import 'package:executive_gps/modules/tasks/task_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:executive_gps/libs/modules/tasks/models/task_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

part './task_employee_state.dart';

class TaskEmployeeBloc extends Cubit<TaskEmployeeState> {
  TaskEmployeeBloc() : super(const TaskEmployeeState());

  Map<String, String?> checklist = {
    'Faróis': null,
    'Lanternas em geral': null,
    'Luz de freio Brake light': null,
    'Luz de ré': null,
    'Funcionamento dos vidros': null,
    'Limpador de para-brisas': null,
    'Luz de cortesia': null,
    'Condições do painel': null,
    'Retrovisor': null,
    'Pisca alertas': null,
    'Setas': null,
    'Buzina': null,
    'Estado da bateria': null,
    'Alarme': null,
    'Ar condicionado': null,
    'Rádio multimídia': null,
    'Trava elétrica': null,
    'Bloqueador': null,
    'Rebaixado': null,
    'Blindado': null,
  };

  void init(TaskModel? task) {
    emit(
      state.copyWith(
        selectedTask: task,
        route: TaskRoutes.details,
        answers: task?.answers ?? TaskAnswersModel(checklist: checklist),
      ),
    );
  }

  void checklistUpdated(String key, String value) {
    checklist[key] = value;
    emit(state.copyWith(
      answers: state.answers.copyWith(
        checklist: checklist,
      ),
    ));
  }

  void saveSignature(Uint8List? path) async {
    final tempDir = await getTemporaryDirectory();
    final fileName = '${DateTime.now()}.png';
    final filePath = '${tempDir.path}/$fileName';

    final file = File(filePath);

    await file.writeAsBytes(path ?? Uint8List(0));
    emit(state.copyWith(
      answers: state.answers.copyWith(
        signature: () => path == null
            ? null
            : ImageModel(
                file: XFile(
                  file.path,
                  name: fileName,
                  mimeType: 'image/png',
                ),
              ),
      ),
    ));
  }

  void checklistFinished(
    bool injectionLight,
    String km,
    String? observations,
  ) {
    emit(state.copyWith(
      answers: state.answers.copyWith(
        injectionLight: injectionLight,
        km: km,
        observation: observations,
      ),
      route: TaskRoutes.photos,
    ));
  }
}
