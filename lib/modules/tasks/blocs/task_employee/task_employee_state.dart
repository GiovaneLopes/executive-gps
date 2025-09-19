part of './task_employee_bloc.dart';

class TaskEmployeeState extends Equatable {
  final AppRoute? route;
  final TaskEmployeeStatus status;
  final TaskModel? selectedTask;
  final TaskAnswersModel answers;
  final List<TaskImageModel> images;
  final AppError? error;

  const TaskEmployeeState({
    this.route,
    this.status = TaskEmployeeStatus.initial,
    this.selectedTask,
    this.answers = const TaskAnswersModel(),
    this.images = const [],
    this.error,
  });

  TaskEmployeeState copyWith({
    AppRoute? route,
    TaskEmployeeStatus? status,
    TaskModel? selectedTask,
    TaskAnswersModel? answers,
    List<TaskImageModel>? images,
    AppError? error,
  }) {
    return TaskEmployeeState(
      route: route?..navigate(),
      status: status ?? this.status,
      selectedTask: selectedTask ?? this.selectedTask,
      answers: answers ?? this.answers,
      images: images ?? this.images,
      error: error ?? this.error,
    );
  }

  List<String> get checklistAnswers => [
        'Bom',
        'Regular',
        'Ruim',
        'Não possui',
      ];

  bool get isChecklistCompleted =>
      answers.checklist.values.every((element) => element != null);
  @override
  List<Object?> get props => [
        route,
        selectedTask,
        answers,
        status,
        images,
        error,
      ];

  TaskImageModel? image(TaskImageType type) => images.isEmpty
      ? null
      : images.firstWhereOrNull((image) => image.type == type);
}
