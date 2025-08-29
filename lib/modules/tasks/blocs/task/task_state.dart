part of 'task_bloc.dart';

class TaskState extends Equatable {
  final AppRoute? route;
  final EmployeeModel? user;
  final List<TaskModel> tasks;
  final TaskModel? selectedTask;
  final TaskStatus status;
  final bool hasMore;
  final AppError? error;

  const TaskState({
    this.route,
    this.user,
    this.tasks = const [],
    this.selectedTask,
    this.status = TaskStatus.initial,
    this.hasMore = false,
    this.error,
  });

  bool get isAdmin => user?.isAdmin ?? false;

  TaskState copyWith({
    AppRoute? route,
    EmployeeModel? user,
    List<TaskModel>? tasks,
    TaskModel? Function()? selectedTask,
    TaskStatus? status,
    AppError? error,
    bool? hasMore,
  }) {
    return TaskState(
      route: route?..navigate(),
      user: user ?? this.user,
      tasks: tasks ?? this.tasks,
      selectedTask: selectedTask != null ? selectedTask() : this.selectedTask,
      status: status ?? this.status,
      error: error ?? this.error,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => [
        tasks,
        user,
        selectedTask,
        status,
        error,
        hasMore,
      ];
}
