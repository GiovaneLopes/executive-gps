import 'package:executive_gps/libs/modules/employees/models/employee_model.dart';
import 'package:executive_gps/libs/modules/user/datasources/user_remote_datasource.dart';

abstract class UserRepository {
  Future<EmployeeModel?> signIn(String email, String password);
  Future<EmployeeModel?> getCurrentUser();
  Future<void> recoverPassword(String email);
  Future<void> logout();
}

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource _remoteDatasource;
  UserRepositoryImpl(this._remoteDatasource);

  @override
  Future<EmployeeModel?> signIn(String email, String password) async {
    return await _remoteDatasource.signIn(email, password);
  }

  @override
  Future<EmployeeModel?> getCurrentUser() async {
    return await _remoteDatasource.getCurrentUser();
  }

  @override
  Future<void> recoverPassword(String email) async {
    return await _remoteDatasource.recoverPassword(email);
  }

  @override
  Future<void> logout() async {
    return await _remoteDatasource.logout();
  }
}
