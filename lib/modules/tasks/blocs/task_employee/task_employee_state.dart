part of './task_employee_bloc.dart';

class TaskEmployeeState extends Equatable {
  final AppRoute? route;
  final TaskModel? selectedTask;
  final TaskAnswersModel answers;

  const TaskEmployeeState({
    this.route,
    this.selectedTask,
    this.answers = const TaskAnswersModel(),
  });

  TaskEmployeeState copyWith({
    AppRoute? route,
    TaskModel? selectedTask,
    TaskAnswersModel? answers,
  }) {
    return TaskEmployeeState(
      route: route?..navigate(),
      selectedTask: selectedTask ?? this.selectedTask,
      answers: answers ?? this.answers,
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
      ];
}
