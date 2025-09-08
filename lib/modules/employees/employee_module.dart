import 'package:executive_gps/modules/employees/employee_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:executive_gps/modules/auth/auth_module.dart';
import 'package:executive_gps/modules/employees/pages/add_employee.dart';
import 'package:executive_gps/modules/employees/blocs/employee_bloc.dart';
import 'package:executive_gps/modules/employees/pages/image_details_page.dart';
import 'package:executive_gps/libs/modules/address/datasources/address_datasource.dart';
import 'package:executive_gps/libs/modules/address/repositories/address_repository.dart';
import 'package:executive_gps/libs/modules/employees/datasources/employee_datasource.dart';
import 'package:executive_gps/libs/modules/employees/repositories/employee_repository.dart';

class EmployeeModule extends Module {
  @override
  void exportedBinds(i) {
    i.addLazySingleton<AddressDatasource>(AddressDatasourceImpl.new);
    i.addLazySingleton<AddressRepository>(AddressRepositoryImpl.new);
    i.addLazySingleton<EmployeeDatasource>(EmployeeDatasourceImpl.new);
    i.addLazySingleton<EmployeeRepository>(EmployeeRepositoryImpl.new);
    i.addSingleton(EmployeeBloc.new);
  }

  @override
  List<Module> get imports => [
        AuthModule(),
      ];

  @override
  void routes(r) {
    r.child(EmployeeRoutes.add.name, child: (_) => const AddEmployeePage());
    r.child(EmployeeRoutes.imageDetails.name,
        child: (_) => const ImageDetailsPage());
  }
}
