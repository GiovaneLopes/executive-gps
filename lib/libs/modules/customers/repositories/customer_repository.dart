import 'package:executive_gps/libs/modules/employees/models/image_model.dart';
import 'package:executive_gps/libs/modules/customers/models/customer_model.dart';
import 'package:executive_gps/libs/modules/customers/datasources/customer_datasource.dart';

abstract class CustomerRepository {
  Future<List<CustomerModel>> getCustomers();
  Future<void> addCustomer(
      CustomerModel customer,  List<ImageModel>? images);
  Future<void> updateCustomer(
    CustomerModel customer,
    List<ImageModel>? images,
    List<ImageModel>? deletedImages,
  );
  Future<void> deleteCustomer(String customerId);
}

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerDatasource datasource;
  CustomerRepositoryImpl(this.datasource);

  @override
  Future<List<CustomerModel>> getCustomers() {
    return datasource.getCustomers();
  }

  @override
  Future<void> addCustomer(
      CustomerModel customer, List<ImageModel>? images) {
    return datasource.addCustomer(customer,  images);
  }

  @override
  Future<void> updateCustomer(
    CustomerModel customer,
    List<ImageModel>? images,
    List<ImageModel>? deletedImages,
  ) {
    return datasource.updateCustomer(customer, images, deletedImages);
  }

  @override
  Future<void> deleteCustomer(String customerId) {
    return datasource.deleteCustomer(customerId);
  }
}
