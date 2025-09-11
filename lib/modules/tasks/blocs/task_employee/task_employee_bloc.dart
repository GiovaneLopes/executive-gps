import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:executive_gps/libs/modules/tasks/models/task_answers_model.dart';
import 'package:executive_gps/libs/modules/tasks/models/task_image_model.dart';
import 'package:executive_gps/libs/modules/tasks/models/task_image_type.dart';
import 'package:executive_gps/libs/modules/tasks/repositories/task_repository.dart';
import 'package:executive_gps/modules/shared/utils/app_route.dart';
import 'package:executive_gps/modules/tasks/task_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:executive_gps/libs/modules/tasks/models/task_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

part './task_employee_state.dart';

enum TaskEmployeeStatus {
  initial,
  loading,
  success,
  error,
}

class TaskEmployeeBloc extends Cubit<TaskEmployeeState> {
  final TaskRepository repository;
  TaskEmployeeBloc(this.repository) : super(const TaskEmployeeState());

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

  void init(TaskModel? task) async {
    clear();
    final answers = await repository.getAnswers(task?.id ?? '');
    emit(
      state.copyWith(
        selectedTask: task,
        route: TaskRoutes.details,
        answers: answers ?? TaskAnswersModel(checklist: checklist),
        images: answers?.images,
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
    const fileName = 'signature.png';
    final filePath = '${tempDir.path}/$fileName';

    final file = File(filePath);
    await file.writeAsBytes(path ?? Uint8List(0));
    emit(state.copyWith(
      images: [
        ...state.answers.images
            .where((image) => image.type != TaskImageType.signature),
        TaskImageModel(
          type: TaskImageType.signature,
          name: fileName,
          file: XFile(
            file.path,
            name: fileName,
            mimeType: 'image/png',
          ),
        ),
      ],
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

  void updateImages(TaskImageModel? image) {
    emit(
      state.copyWith(
        images: image != null
            ? [
                ...state.images.where((img) => img.type != image.type),
                image,
              ]
            : state.images,
      ),
    );
  }

  void sendAnswers() async {
    emit(state.copyWith(status: TaskEmployeeStatus.loading));
    try {
      await repository.saveTaskAnswers(
        state.selectedTask?.id ?? '',
        state.answers.copyWith(images: state.images),
      );
      emit(state.copyWith(status: TaskEmployeeStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TaskEmployeeStatus.error));
    }
  }

  void summaryRequested() {
    emit(state.copyWith(route: TaskRoutes.summary));
  }

  void clear() {
    emit(const TaskEmployeeState());
  }
}
