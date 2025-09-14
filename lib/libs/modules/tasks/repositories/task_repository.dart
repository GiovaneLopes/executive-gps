import 'package:executive_gps/libs/modules/tasks/models/task_model.dart';
import 'package:executive_gps/libs/modules/tasks/models/task_answers_model.dart';
import 'package:executive_gps/libs/modules/tasks/datasources/task_datasource.dart';

abstract class TaskRepository {
  Future<List<TaskModel>> getTasks(String? employeeId);
  Future<TaskModel> addTask(TaskModel task);
  Future<TaskModel> updateTask(TaskModel task);
  Future<void> saveTaskAnswers(String id, TaskAnswersModel answers);
  Future<void> deleteTask(String taskId);
  Future<void> clearTasks();
  Future<TaskAnswersModel?> getAnswers(String taskId);
}

class TaskRepositoryImpl implements TaskRepository {
  final TaskDatasource datasource;
  TaskRepositoryImpl(this.datasource);

  @override
  Future<List<TaskModel>> getTasks(String? employeeId) {
    return datasource.getTasks(employeeId);
  }

  @override
  Future<TaskModel> addTask(TaskModel task) {
    return datasource.addTask(task);
  }

  @override
  Future<TaskModel> updateTask(TaskModel task) {
    return datasource.updateTask(task);
  }

  @override
  Future<void> saveTaskAnswers(String id, TaskAnswersModel answers) {
    return datasource.saveTaskAnswers(id, answers);
  }

  @override
  Future<void> deleteTask(String taskId) {
    return datasource.deleteTask(taskId);
  }

  @override
  Future<void> clearTasks() {
    return datasource.clearTasks();
  }

  @override
  Future<TaskAnswersModel?> getAnswers(String taskId) {
    return datasource.getAnswers(taskId);
  }
}
