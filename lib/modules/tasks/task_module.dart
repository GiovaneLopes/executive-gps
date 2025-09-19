import 'package:executive_gps/modules/tasks/pages/task_checklist_page.dart';
import 'package:executive_gps/modules/tasks/pages/task_photos_page.dart';
import 'package:executive_gps/modules/tasks/pages/task_signature_page.dart';
import 'package:executive_gps/modules/tasks/pages/task_summary_page.dart';
import 'package:executive_gps/modules/tasks/task_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:executive_gps/modules/tasks/pages/add_task.dart';
import 'package:executive_gps/modules/customers/customer_module.dart';
import 'package:executive_gps/modules/employees/employee_module.dart';
import 'package:executive_gps/modules/tasks/blocs/task/task_bloc.dart';
import 'package:executive_gps/modules/tasks/pages/task_details_page.dart';
import 'package:executive_gps/libs/modules/tasks/datasources/task_datasource.dart';
import 'package:executive_gps/libs/modules/tasks/repositories/task_repository.dart';
import 'package:executive_gps/libs/modules/address/datasources/address_datasource.dart';
import 'package:executive_gps/modules/tasks/blocs/task_employee/task_employee_bloc.dart';
import 'package:executive_gps/libs/modules/address/repositories/address_repository.dart';

class TaskModule extends Module {
  @override
  void exportedBinds(i) {
    i.addLazySingleton<AddressDatasource>(AddressDatasourceImpl.new);
    i.addLazySingleton<AddressRepository>(AddressRepositoryImpl.new);
    i.addLazySingleton<TaskDatasource>(TaskDatasourceImpl.new);
    i.addLazySingleton<TaskRepository>(TaskRepositoryImpl.new);
    i.addSingleton(TaskBloc.new);
    i.addSingleton(TaskEmployeeBloc.new);
  }

  @override
  List<Module> get imports => [
        CustomerModule(),
        EmployeeModule(),
      ];

  @override
  void routes(r) {
    r.child(TaskRoutes.add.name, child: (_) => const AddTaskPage());
    r.child(TaskRoutes.details.name, child: (_) => const TaskDetailsPage());
    r.child(TaskRoutes.checklist.name, child: (_) => const TaskChecklistPage());
    r.child(TaskRoutes.signature.name, child: (_) => const TaskSignaturePage());
    r.child(TaskRoutes.photos.name, child: (_) => const TaskPhotosPage());
    r.child(TaskRoutes.summary.name, child: (_) => const TaskSummaryPage());
  }
}
