import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:executive_gps/modules/tasks/blocs/task_employee/task_employee_bloc.dart';

class TaskEmployeeDetailsPage extends StatelessWidget {
  const TaskEmployeeDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = Modular.get<TaskEmployeeBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Employee Details'),
      ),
      body: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            return const Center(
              child: Text('Task Employee Details Page Content'),
            );
          }),
    );
  }
}
