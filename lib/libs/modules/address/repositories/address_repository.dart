import 'package:executive_gps/libs/modules/address/models/address_model.dart';
import 'package:executive_gps/libs/modules/address/datasources/address_datasource.dart';

abstract class AddressRepository {
  Future<AddressModel> getAddressByCep(String cep);
}

class AddressRepositoryImpl extends AddressRepository {
  final AddressDatasource datasource;

  AddressRepositoryImpl(this.datasource);

  @override
  Future<AddressModel> getAddressByCep(String cep) {
    return datasource.getAddressByCep(cep);
  }
}
