import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:executive_gps/modules/shared/utils/app_route.dart';
import 'package:executive_gps/modules/customers/customer_routes.dart';
import 'package:executive_gps/libs/modules/employees/models/image_model.dart';
import 'package:executive_gps/libs/modules/address/models/address_model.dart';
import 'package:executive_gps/libs/modules/customers/models/customer_model.dart';
import 'package:executive_gps/libs/modules/address/repositories/address_repository.dart';
import 'package:executive_gps/libs/modules/customers/repositories/customer_repository.dart';

part 'customer_state.dart';

enum CustomerStatus {
  initial,
  loading,
  loaded,
  success,
  error,
  addressLoading,
  addressLoaded,
}

class CustomerBloc extends Cubit<CustomerState> {
  final AddressRepository addressRepository;
  final CustomerRepository customerRepository;
  CustomerBloc(
    this.addressRepository,
    this.customerRepository,
  ) : super(const CustomerState()) {
    getCustomers();
  }

  void getCustomers() async {
    try {
      emit(state.copyWith(status: CustomerStatus.loading));
      final customers = await customerRepository.getCustomers();
      emit(state.copyWith(customers: customers, status: CustomerStatus.loaded));
    } catch (e) {
      emit(state.copyWith(status: CustomerStatus.error));
    }
  }

  void searchAddress(String cep) async {
    try {
      emit(state.copyWith(status: CustomerStatus.addressLoading));
      final address = await addressRepository.getAddressByCep(cep);
      emit(state.copyWith(
          address: address, status: CustomerStatus.addressLoaded));
    } catch (e) {
      emit(state.copyWith(status: CustomerStatus.error));
    }
  }

  void addCustomer(CustomerModel customer) async {
    try {
      emit(state.copyWith(status: CustomerStatus.loading));
      await customerRepository.addCustomer(
        customer,
        state.images,
      );
      emit(
        state.copyWith(
          status: CustomerStatus.success,
          selectedCustomer: () => null,
          images: [],
        ),
      );
      getCustomers();
    } catch (e) {
      debugPrint('### Error adding customer: $e');
      emit(state.copyWith(status: CustomerStatus.error));
    }
  }

  void updateCustomer(CustomerModel customer) async {
    try {
      emit(state.copyWith(status: CustomerStatus.loading));
      await customerRepository.updateCustomer(
        customer.copyWith(
            images: customer.images
                .where((img) => state.deletedImages
                    .every((delImg) => delImg.url != img.url))
                .toList()),
        state.images.where((img) => img.file != null).toList(),
        state.deletedImages,
      );
      emit(
        state.copyWith(
          status: CustomerStatus.success,
          selectedCustomer: () => null,
          images: [],
        ),
      );
      getCustomers();
    } catch (e) {
      debugPrint('### Error adding customer: $e');
      emit(state.copyWith(status: CustomerStatus.error));
    }
  }

  void selectCustomer(CustomerModel? customer) {
    emit(CustomerState(customers: state.customers));
    final images = <ImageModel>[
      ...customer?.images
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
        selectedCustomer: customer != null ? () => customer : () => null,
        images: images,
        deletedImages: <ImageModel>[],
        route: CustomerRoutes.add,
      ),
    );
  }

  void updateAdmin() {
    emit(
      state.copyWith(status: CustomerStatus.initial),
    );
  }

  void addImage(XFile image) {
    final images = List<ImageModel>.from(state.images);
    images.add(ImageModel(file: image));
    emit(state.copyWith(
      images: images,
      status: CustomerStatus.initial,
    ));
  }

  void selectImage(ImageModel? image) {
    emit(state.copyWith(
      selectedImage: image,
      route: CustomerRoutes.imageDetails,
      status: CustomerStatus.initial,
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

  void deleteCustomer() async {
    if (state.selectedCustomer == null) return;
    try {
      emit(state.copyWith(status: CustomerStatus.loading));
      await customerRepository.deleteCustomer(state.selectedCustomer!.id ?? '');
      emit(state.copyWith(status: CustomerStatus.success));
      getCustomers();
    } catch (e) {
      debugPrint('### Error deleting customer: $e');
      emit(state.copyWith(status: CustomerStatus.error));
    }
  }
}
