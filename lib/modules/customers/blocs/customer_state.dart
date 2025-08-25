part of 'customer_bloc.dart';

class CustomerState extends Equatable {
  final AppRoute? route;
  final List<CustomerModel> customers;
  final CustomerModel? selectedCustomer;
  final ImageModel? selectedImage;
  final List<ImageModel> images;
  final List<ImageModel> deletedImages;
  final CustomerStatus status;
  final AddressModel? address;

  const CustomerState({
    this.route,
    this.customers = const [],
    this.selectedCustomer,
    this.selectedImage,
    this.images = const [],
    this.deletedImages = const [],
    this.status = CustomerStatus.initial,
    this.address,
  });

  CustomerState copyWith({
    AppRoute? route,
    List<CustomerModel>? customers,
    CustomerModel? Function()? selectedCustomer,
    ImageModel? selectedImage,
    List<ImageModel>? images,
    List<ImageModel>? deletedImages,
    CustomerStatus? status,
    AddressModel? address,
  }) {
    return CustomerState(
      route: route?..navigate(),
      customers: customers ?? this.customers,
      selectedCustomer:
          selectedCustomer != null ? selectedCustomer() : this.selectedCustomer,
      selectedImage: selectedImage ?? this.selectedImage,
      images: images ?? this.images,
      deletedImages: deletedImages ?? this.deletedImages,
      status: status ?? this.status,
      address: address ?? this.address,
    );
  }

  @override
  List<Object?> get props => [
        customers,
        selectedCustomer,
        selectedImage,
        images,
        deletedImages,
        status,
        address,
      ];
}
