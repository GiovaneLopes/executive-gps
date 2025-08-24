import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:executive_gps/libs/modules/address/models/address_model.dart';

abstract class AddressDatasource {
  Future<AddressModel> getAddressByCep(String cep);
}

class AddressDatasourceImpl implements AddressDatasource {
  @override
  Future<AddressModel> getAddressByCep(String cep) async {
    final response =
        await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));
    if (response.statusCode == 200) {
      return AddressModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Requisição inválida!');
    }
  }
}
