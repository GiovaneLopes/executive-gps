import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:executive_gps/libs/modules/tasks/models/task_model.dart';

part './task_employee_state.dart';

class TaskEmployeeBloc extends Cubit<TaskEmployeeState> {
  TaskEmployeeBloc() : super(const TaskEmployeeState());
}
