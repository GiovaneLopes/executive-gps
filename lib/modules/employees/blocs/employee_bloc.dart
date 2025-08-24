import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:executive_gps/modules/auth/blocs/auth_bloc.dart';
import 'package:executive_gps/modules/shared/utils/app_route.dart';
import 'package:executive_gps/modules/employees/employee_routes.dart';
import 'package:executive_gps/libs/modules/employees/models/image_model.dart';
import 'package:executive_gps/libs/modules/address/models/address_model.dart';
import 'package:executive_gps/libs/modules/employees/models/employee_model.dart';
import 'package:executive_gps/libs/modules/address/repositories/address_repository.dart';
import 'package:executive_gps/libs/modules/employees/repositories/employee_repository.dart';

part 'employee_state.dart';

enum EmployeeStatus {
  initial,
  loading,
  loaded,
  success,
  error,
  addressLoading,
  addressLoaded,
}

class EmployeeBloc extends Cubit<EmployeeState> {
  final AddressRepository addressRepository;
  final EmployeeRepository employeeRepository;
  final AuthBloc authBloc;
  EmployeeBloc(
    this.addressRepository,
    this.employeeRepository,
    this.authBloc,
  ) : super(const EmployeeState()) {
    init();
  }

  void init() {
    emit(state.copyWith(authenticatedUserId: authBloc.state.user?.id));
    getEmployees();
  }

  void getEmployees() async {
    try {
      emit(state.copyWith(status: EmployeeStatus.loading));
      final employees = await employeeRepository.getEmployees();
      emit(state.copyWith(employees: employees, status: EmployeeStatus.loaded));
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
      final cpfDigits = employee.cpf.replaceAll(RegExp(r'\D'), '');
      final first4Digits = int.parse(cpfDigits.substring(0, 4));
      await employeeRepository.addEmployee(
        employee,
        'gps@$first4Digits',
        state.images,
      );
      emit(
        state.copyWith(
          status: EmployeeStatus.success,
          selectedEmployee: () => null,
          images: [],
        ),
      );
      getEmployees();
    } catch (e) {
      debugPrint('### Error adding employee: $e');
      emit(state.copyWith(status: EmployeeStatus.error));
    }
  }

  void updateEmployee(EmployeeModel employee) async {
    try {
      emit(state.copyWith(status: EmployeeStatus.loading));
      await employeeRepository.updateEmployee(
        employee.copyWith(
            images: employee.images
                .where((img) => state.deletedImages
                    .every((delImg) => delImg.url != img.url))
                .toList()),
        state.images.where((img) => img.file != null).toList(),
        state.deletedImages,
      );
      emit(
        state.copyWith(
          status: EmployeeStatus.success,
          selectedEmployee: () => null,
          images: [],
        ),
      );
      authBloc.getUser();
      getEmployees();
    } catch (e) {
      debugPrint('### Error adding employee: $e');
      emit(state.copyWith(status: EmployeeStatus.error));
    }
  }

  void selectEmployee(EmployeeModel? employee) {
    emit(EmployeeState(employees: state.employees));
    final images = <ImageModel>[
      ...employee?.images
              .map((image) => ImageModel(
                    name: image.name,
                    url: image.url,
                    file: image.file,
                  ))
              .toList() ??
          []
    ];
    emit(
      state.copyWith(
        selectedEmployee: employee != null ? () => employee : () => null,
        isAdmin: employee?.isAdmin ?? false,
        images: images,
        deletedImages: <ImageModel>[],
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

  void addImage(XFile image) {
    final images = List<ImageModel>.from(state.images);
    images.add(ImageModel(file: image));
    emit(state.copyWith(
      images: images,
      status: EmployeeStatus.initial,
    ));
  }

  void selectImage(ImageModel? image) {
    emit(state.copyWith(
      selectedImage: image,
      route: EmployeeRoutes.imageDetails,
      status: EmployeeStatus.initial,
    ));
  }

  void deleteImage(ImageModel image) {
    if (image.url != null) {
      emit(
        state.copyWith(
          deletedImages: [...state.deletedImages, image],
          images: state.images.where((img) => img.url != image.url).toList(),
        ),
      );
    } else {
      emit(
        state.copyWith(
          images: state.images.where((img) => img != image).toList(),
        ),
      );
    }
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
