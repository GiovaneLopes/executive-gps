import 'package:executive_gps/libs/modules/tasks/models/task_model.dart';
import 'package:executive_gps/libs/modules/tasks/models/task_step.dart';
import 'package:executive_gps/modules/shared/utils/date_time_extension.dart';

extension TaskListExtension on List<TaskModel> {
  List<TaskModel> get todayList =>
      where((task) => task.dueDate.isToday).toList();

  List<TaskModel> get otherTasks =>
      where((task) => !task.dueDate.isToday).toList();

  List<TaskModel> get todayTasks =>
      where((task) => task.dueDate.isToday).toList();

  List<TaskModel> get completedTasks =>
      where((task) => task.step == TaskStep.completed).toList();
  List<TaskModel> get canceledTasks =>
      where((task) => task.step == TaskStep.canceled).toList();
  List<TaskModel> get scheduledTasks =>
      where((task) => task.step == TaskStep.scheduled).toList();
}
