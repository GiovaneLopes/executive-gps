part of 'employee_bloc.dart';

class EmployeeState extends Equatable {
  final AppRoute? route;
  final List<EmployeeModel> employees;
  final EmployeeModel? selectedEmployee;
  final bool isAdmin;
  final EmployeeStatus status;
  final AddressModel? address;

  const EmployeeState({
    this.route,
    this.employees = const [],
    this.selectedEmployee,
    this.isAdmin = false,
    this.status = EmployeeStatus.initial,
    this.address,
  });

  EmployeeState copyWith({
    AppRoute? route,
    List<EmployeeModel>? employees,
    EmployeeModel? Function()? selectedEmployee,
    EmployeeStatus? status,
    AddressModel? address,
    bool? isAdmin,
  }) {
    return EmployeeState(
      route: route?..navigate(),
      employees: employees ?? this.employees,
      selectedEmployee:
          selectedEmployee != null ? selectedEmployee() : this.selectedEmployee,
      isAdmin: isAdmin ?? this.isAdmin,
      status: status ?? this.status,
      address: address ?? this.address,
    );
  }

  @override
  List<Object?> get props => [
        employees,
        selectedEmployee,
        status,
        address,
        isAdmin,
      ];
}
