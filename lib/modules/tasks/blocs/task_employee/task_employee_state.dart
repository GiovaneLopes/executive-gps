part of './task_employee_bloc.dart';

class TaskEmployeeState extends Equatable {
  final List<TaskModel> tasks;
  final TaskModel? selectedTask;

  const TaskEmployeeState({
    this.tasks = const <TaskModel>[],
    this.selectedTask,
  });

  TaskEmployeeState copyWith({
    List<TaskModel>? tasks,
    TaskModel? selectedTask,
  }) {
    return TaskEmployeeState(
      tasks: tasks ?? this.tasks,
      selectedTask: selectedTask ?? this.selectedTask,
    );
  }

  @override
  List<Object?> get props => [
        tasks,
        selectedTask,
      ];
}
