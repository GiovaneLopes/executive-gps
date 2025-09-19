part of 'task_bloc.dart';

class TaskState extends Equatable {
  final AppRoute? route;
  final EmployeeModel? user;
  final List<TaskModel> tasks;
  final TaskModel? selectedTask;
  final TaskStatus status;
  final bool hasMore;
  final FilterType? filter;
  final bool viewMode;
  final AppError? error;

  const TaskState({
    this.route,
    this.user,
    this.tasks = const [],
    this.selectedTask,
    this.status = TaskStatus.initial,
    this.hasMore = false,
    this.filter,
    this.error,
    this.viewMode = true,
  });

  bool get isAdmin => user?.isAdmin ?? false;

  List<TaskModel> get orderTasks {
    final List<TaskModel> ordered = List.from(filteredTasks);
    ordered.sort((a, b) {
      return b.dueDate.compareTo(a.dueDate);
    });
    return ordered;
  }

  List<TaskModel> get filteredTasks {
    switch (filter) {
      case FilterType.today:
        return tasks.todayTasks;
      case FilterType.completed:
        return tasks.completedTasks;
      case FilterType.canceled:
        return tasks.canceledTasks;
      case FilterType.scheduled:
        return tasks.scheduledTasks;
      default:
        return tasks;
    }
  }

  TaskState copyWith({
    AppRoute? route,
    EmployeeModel? user,
    List<TaskModel>? tasks,
    TaskModel? Function()? selectedTask,
    TaskStatus? status,
    AppError? error,
    bool? hasMore,
    FilterType? filter,
    bool setFilterToNull = false,
    bool? viewMode,
  }) {
    return TaskState(
      route: route?..navigate(),
      user: user ?? this.user,
      tasks: tasks ?? this.tasks,
      selectedTask: selectedTask != null ? selectedTask() : this.selectedTask,
      status: status ?? this.status,
      error: error ?? this.error,
      hasMore: hasMore ?? this.hasMore,
      filter: setFilterToNull ? null : (filter ?? this.filter),
      viewMode: viewMode ?? this.viewMode,
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
        filter,
        viewMode,
      ];
}
