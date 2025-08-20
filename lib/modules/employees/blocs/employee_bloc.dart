import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:executive_gps/modules/shared/utils/app_route.dart';
import 'package:executive_gps/modules/employees/employee_routes.dart';
import 'package:executive_gps/libs/modules/address/models/address_model.dart';
import 'package:executive_gps/libs/modules/employees/models/employee_model.dart';
import 'package:executive_gps/libs/modules/address/repositories/address_repository.dart';
import 'package:executive_gps/libs/modules/employees/repositories/employee_repository.dart';

part 'employee_state.dart';

enum EmployeeStatus {
  initial,
  loading,
  addressLoading,
  addressLoaded,
  success,
  error,
}

class EmployeeBloc extends Cubit<EmployeeState> {
  final AddressRepository addressRepository;
  final EmployeeRepository employeeRepository;
  EmployeeBloc(this.addressRepository, this.employeeRepository)
      : super(const EmployeeState()) {
    getEmployees();
  }

  void getEmployees() async {
    try {
      emit(state.copyWith(status: EmployeeStatus.loading));
      final employees = await employeeRepository.getEmployees();
      emit(
          state.copyWith(employees: employees, status: EmployeeStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EmployeeStatus.error));
    }
  }

  void searchAddress(String cep) async {
    try {
      emit(state.copyWith(status: EmployeeStatus.addressLoading));
      final address = await addressRepository.getAddressByCep(cep);
      emit(state.copyWith(
          address: address, status: EmployeeStatus.addressLoaded));
    } catch (e) {
      emit(state.copyWith(status: EmployeeStatus.error));
    }
  }

  void addEmployee(EmployeeModel employee) async {
    try {
      emit(state.copyWith(status: EmployeeStatus.loading));
      await employeeRepository.addEmployee(employee);
      emit(state.copyWith(status: EmployeeStatus.success));
      getEmployees();
    } catch (e) {
      debugPrint('### Error adding employee: $e');
      emit(state.copyWith(status: EmployeeStatus.error));
    }
  }

  void selectEmployee(EmployeeModel? employee) {
    emit(
      state.copyWith(
        selectedEmployee: employee != null ? () => employee : () => null,
        isAdmin: employee?.isAdmin ?? false,
        route: EmployeeRoutes.add,
      ),
    );
  }

  void updateAdmin() {
    emit(
      state.copyWith(
        status: EmployeeStatus.initial,
        isAdmin: !state.isAdmin,
      ),
    );
  }

  void deleteEmployee() async {
    if (state.selectedEmployee == null) return;
    try {
      emit(state.copyWith(status: EmployeeStatus.loading));
      await employeeRepository.deleteEmployee(state.selectedEmployee!.id ?? '');
      emit(state.copyWith(status: EmployeeStatus.success));
      getEmployees();
    } catch (e) {
      debugPrint('### Error deleting employee: $e');
      emit(state.copyWith(status: EmployeeStatus.error));
    }
  }
}
