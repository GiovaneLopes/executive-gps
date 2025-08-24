import 'package:executive_gps/libs/modules/employees/models/image_model.dart';
import 'package:executive_gps/libs/modules/employees/models/employee_model.dart';
import 'package:executive_gps/libs/modules/employees/datasources/employee_datasource.dart';

abstract class EmployeeRepository {
  Future<List<EmployeeModel>> getEmployees();
  Future<void> addEmployee(
      EmployeeModel employee, String password, List<ImageModel>? images);
  Future<void> updateEmployee(
    EmployeeModel employee,
    List<ImageModel>? images,
    List<ImageModel>? deletedImages,
  );
  Future<void> deleteEmployee(String employeeId);
}

class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeDatasource datasource;
  EmployeeRepositoryImpl(this.datasource);

  @override
  Future<List<EmployeeModel>> getEmployees() {
    return datasource.getEmployees();
  }

  @override
  Future<void> addEmployee(
      EmployeeModel employee, String password, List<ImageModel>? images) {
    return datasource.addEmployee(employee, password, images);
  }

  @override
  Future<void> updateEmployee(
    EmployeeModel employee,
    List<ImageModel>? images,
    List<ImageModel>? deletedImages,
  ) {
    return datasource.updateEmployee(employee, images, deletedImages);
  }

  @override
  Future<void> deleteEmployee(String employeeId) {
    return datasource.deleteEmployee(employeeId);
  }
}
