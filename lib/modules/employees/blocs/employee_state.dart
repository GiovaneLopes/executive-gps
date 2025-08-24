part of 'employee_bloc.dart';

class EmployeeState extends Equatable {
  final AppRoute? route;
  final List<EmployeeModel> employees;
  final EmployeeModel? selectedEmployee;
  final ImageModel? selectedImage;
  final List<ImageModel> images;
  final List<ImageModel> deletedImages;
  final bool isAdmin;
  final String? authenticatedUserId;
  final EmployeeStatus status;
  final AddressModel? address;

  const EmployeeState({
    this.route,
    this.employees = const [],
    this.selectedEmployee,
    this.selectedImage,
    this.images = const [],
    this.deletedImages = const [],
    this.isAdmin = false,
    this.authenticatedUserId,
    this.status = EmployeeStatus.initial,
    this.address,
  });

  EmployeeModel? get authenticatedUser =>
      employees.firstWhere((emp) => emp.id == authenticatedUserId);

  EmployeeState copyWith({
    AppRoute? route,
    List<EmployeeModel>? employees,
    EmployeeModel? Function()? selectedEmployee,
    ImageModel? selectedImage,
    List<ImageModel>? images,
    List<ImageModel>? deletedImages,
    String? authenticatedUserId,
    bool? isAdmin,
    EmployeeStatus? status,
    AddressModel? address,
  }) {
    return EmployeeState(
      route: route?..navigate(),
      employees: employees ?? this.employees,
      selectedEmployee:
          selectedEmployee != null ? selectedEmployee() : this.selectedEmployee,
      selectedImage: selectedImage ?? this.selectedImage,
      images: images ?? this.images,
      deletedImages: deletedImages ?? this.deletedImages,
      authenticatedUserId: authenticatedUserId ?? this.authenticatedUserId,
      isAdmin: isAdmin ?? this.isAdmin,
      status: status ?? this.status,
      address: address ?? this.address,
    );
  }

  @override
  List<Object?> get props => [
        employees,
        selectedEmployee,
        selectedImage,
        images,
        deletedImages,
        authenticatedUserId,
        isAdmin,
        status,
        address,
      ];
}
