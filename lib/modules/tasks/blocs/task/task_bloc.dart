import 'dart:async';
import 'package:executive_gps/libs/modules/tasks/models/task_step.dart';
import 'package:executive_gps/modules/tasks/blocs/task_employee/task_employee_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:executive_gps/modules/tasks/task_routes.dart';
import 'package:executive_gps/libs/exceptions/app_error.dart';
import 'package:executive_gps/modules/auth/blocs/auth_bloc.dart';
import 'package:executive_gps/modules/shared/utils/app_route.dart';
import 'package:executive_gps/libs/modules/tasks/models/task_model.dart';
import 'package:executive_gps/modules/customers/blocs/customer_bloc.dart';
import 'package:executive_gps/modules/employees/blocs/employee_bloc.dart';
import 'package:executive_gps/libs/modules/employees/models/employee_model.dart';
import 'package:executive_gps/libs/modules/customers/models/customer_model.dart';
import 'package:executive_gps/libs/modules/tasks/repositories/task_repository.dart';

part 'task_state.dart';

enum TaskStatus {
  initial,
  loading,
  loaded,
  success,
  error,
}

class TaskBloc extends Cubit<TaskState> implements Disposable {
  final TaskRepository taskRepository;
  final CustomerBloc customerBloc;
  final EmployeeBloc employeeBloc;
  final TaskEmployeeBloc taskEmployeeBloc;
  final AuthBloc authBloc;

  late StreamSubscription<CustomerState> _blocCustomerSubscription;
  late StreamSubscription<EmployeeState> _blocEmployeeSubscription;
  late StreamSubscription<AuthState> _blocAuthSubscription;
  TaskBloc(
    this.taskRepository,
    this.customerBloc,
    this.employeeBloc,
    this.taskEmployeeBloc,
    this.authBloc,
  ) : super(const TaskState()) {
    _blocCustomerSubscription = customerBloc.stream.listen((customerState) {
      if (customerState.status == CustomerStatus.loaded &&
          employeeBloc.state.status == EmployeeStatus.loaded &&
          authBloc.state.status == AuthStatus.authenticated) {
        _checkLoad();
      }
    });
    _blocEmployeeSubscription = employeeBloc.stream.listen((employeeState) {
      if (employeeState.status == EmployeeStatus.loaded &&
          customerBloc.state.status == CustomerStatus.loaded &&
          authBloc.state.status == AuthStatus.authenticated) {
        _checkLoad();
      }
    });
    _blocAuthSubscription = authBloc.stream.listen((authState) {
      if (authState.status == AuthStatus.unauthenticated) {
        emit(const TaskState());
        taskRepository.clearTasks();
      }
      if (customerBloc.state.status == CustomerStatus.loaded &&
          employeeBloc.state.status == EmployeeStatus.loaded &&
          authState.status == AuthStatus.authenticated) {
        _checkLoad();
      }
    });
  }

  void _checkLoad() {
    if (state.status != TaskStatus.loading) {
      emit(state.copyWith(user: authBloc.state.user));
      getTasks();
    }
  }

  void getTasks() async {
    try {
      emit(state.copyWith(status: TaskStatus.loading));
      final employeeId = state.isAdmin ? null : state.user?.id;
      final tasks = await taskRepository.getTasks(employeeId);
      final realTasks = await Future.wait(tasks.map((task) async {
        final customer = customerBloc.state.customers
            .where((customer) => customer.id == task.customerId)
            .cast<CustomerModel?>()
            .firstWhere((customer) => customer != null, orElse: () => null);

        final employee = employeeBloc.state.employees
            .where((employee) => employee.id == task.employeeId)
            .cast<EmployeeModel?>()
            .firstWhere((employee) => employee != null, orElse: () => null);
        return task.copyWith(customer: customer, employee: employee);
      }).toList());
      emit(
        state.copyWith(
          tasks: realTasks.isEmpty ? state.tasks : realTasks,
          hasMore: tasks.length > state.tasks.length,
          status: TaskStatus.loaded,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: TaskStatus.error,
        error: e as AppError,
      ));
    }
  }

  void addTask(TaskModel task) async {
    try {
      emit(state.copyWith(status: TaskStatus.loading));
      await taskRepository.addTask(task);
      emit(
        state.copyWith(
          status: TaskStatus.success,
          selectedTask: () => task,
        ),
      );
      getTasks();
    } catch (e) {
      debugPrint('### Error adding task: $e');
      emit(state.copyWith(
        status: TaskStatus.error,
        error: e as AppError,
      ));
    }
  }

  void updateTask(TaskModel task) async {
    try {
      emit(state.copyWith(status: TaskStatus.loading));
      await taskRepository.updateTask(task);
      emit(
        state.copyWith(
          status: TaskStatus.success,
          selectedTask: () => task,
        ),
      );
      getTasks();
    } catch (e) {
      debugPrint('### Error adding task: $e');
      emit(state.copyWith(
        status: TaskStatus.error,
        error: e as AppError,
      ));
    }
  }

  void selectTask(TaskModel? task) {
    emit(TaskState(
      tasks: state.tasks,
      user: state.user,
    ));
    if (state.isAdmin && task?.step != TaskStep.completed) {
      emit(
        state.copyWith(
          selectedTask: task != null ? () => task : () => null,
          route: TaskRoutes.add,
        ),
      );
    } else {
      taskEmployeeBloc.init(task);
    }
  }

  void deleteTask() async {
    if (state.selectedTask == null) return;
    try {
      emit(state.copyWith(status: TaskStatus.loading));
      await taskRepository.deleteTask(state.selectedTask!.id ?? '');
      emit(state.copyWith(status: TaskStatus.success));
      await taskRepository.clearTasks();
      getTasks();
    } catch (e) {
      debugPrint('### Error deleting task: $e');
      emit(state.copyWith(
        status: TaskStatus.error,
        error: e as AppError,
      ));
    }
  }

  @override
  void dispose() {
    _blocCustomerSubscription.cancel();
    _blocEmployeeSubscription.cancel();
    _blocAuthSubscription.cancel();
    super.close();
  }
}
