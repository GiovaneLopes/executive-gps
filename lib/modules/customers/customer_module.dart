import 'package:flutter_modular/flutter_modular.dart';
import 'package:executive_gps/modules/customers/pages/add_customer.dart';
import 'package:executive_gps/modules/customers/blocs/customer_bloc.dart';
import 'package:executive_gps/modules/customers/pages/image_details_page.dart';
import 'package:executive_gps/libs/modules/address/datasources/address_datasource.dart';
import 'package:executive_gps/libs/modules/address/repositories/address_repository.dart';
import 'package:executive_gps/libs/modules/customers/datasources/customer_datasource.dart';
import 'package:executive_gps/libs/modules/customers/repositories/customer_repository.dart';

class CustomerModule extends Module {
  @override
  void exportedBinds(i) {
    i.addLazySingleton<AddressDatasource>(AddressDatasourceImpl.new);
    i.addLazySingleton<AddressRepository>(AddressRepositoryImpl.new);
    i.addLazySingleton<CustomerDatasource>(CustomerDatasourceImpl.new);
    i.addLazySingleton<CustomerRepository>(CustomerRepositoryImpl.new);
    i.addSingleton(CustomerBloc.new);
  }

  @override
  void routes(r) {
    r.child('/add', child: (_) => const AddCustomerPage());
    r.child(
      '/image-details',
      child: (_) => const ImageDetailsPage(),
    );
  }
}
