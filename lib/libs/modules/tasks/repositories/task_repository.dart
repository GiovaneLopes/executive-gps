import 'package:executive_gps/libs/modules/tasks/models/task_model.dart';
import 'package:executive_gps/libs/modules/tasks/datasources/task_datasource.dart';

abstract class TaskRepository {
  Future<List<TaskModel>> getTasks(String? employeeId);
  Future<void> addTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(String taskId);
  Future<void> clearTasks();
}

class TaskRepositoryImpl implements TaskRepository {
  final TaskDatasource datasource;
  TaskRepositoryImpl(this.datasource);

  @override
  Future<List<TaskModel>> getTasks(String? employeeId) {
    return datasource.getTasks(employeeId);
  }

  @override
  Future<void> addTask(TaskModel task) {
    return datasource.addTask(task);
  }

  @override
  Future<void> updateTask(TaskModel task) {
    return datasource.updateTask(task);
  }

  @override
  Future<void> deleteTask(String taskId) {
    return datasource.deleteTask(taskId);
  }

  @override
  Future<void> clearTasks() {
    return datasource.clearTasks();
  }
}
