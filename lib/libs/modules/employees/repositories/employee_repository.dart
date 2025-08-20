import 'package:executive_gps/libs/modules/employees/models/employee_model.dart';
import 'package:executive_gps/libs/modules/employees/datasources/employee_datasource.dart';

abstract class EmployeeRepository {
  Future<List<EmployeeModel>> getEmployees();
  Future<void> addEmployee(EmployeeModel employee);
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
  Future<void> addEmployee(EmployeeModel employee) {
    return datasource.addEmployee(employee);
  }

  @override
  Future<void> deleteEmployee(String employeeId) {
    return datasource.deleteEmployee(employeeId);
  }
}
