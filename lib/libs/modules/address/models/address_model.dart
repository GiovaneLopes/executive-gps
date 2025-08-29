import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'address_model.g.dart';

@JsonSerializable()
class AddressModel extends Equatable {
  final String? logradouro;
  final String? bairro;
  final String? numero;
  final String? complemento;
  final String? localidade;
  final String? uf;
  final String? cep;

  const AddressModel({
    this.logradouro,
    this.bairro,
    this.numero,
    this.complemento,
    this.localidade,
    this.uf,
    this.cep,
  });

  const AddressModel.empty()
      : logradouro = 'Não informado',
        bairro = '',
        numero = '',
        complemento = '',
        localidade = '',
        uf = '',
        cep = '';

  AddressModel copyWith({
    String? logradouro,
    String? bairro,
    String? numero,
    String? complemento,
    String? localidade,
    String? uf,
    String? cep,
  }) {
    return AddressModel(
      logradouro: logradouro ?? this.logradouro,
      bairro: bairro ?? this.bairro,
      numero: numero ?? this.numero,
      complemento: complemento ?? this.complemento,
      localidade: localidade ?? this.localidade,
      uf: uf ?? this.uf,
      cep: cep ?? this.cep,
    );
  }

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);

  @override
  List<Object?> get props => [
        logradouro,
        bairro,
        numero,
        complemento,
        localidade,
        uf,
        cep,
      ];

  @override
  String toString() {
    return '$logradouro, $numero - $bairro, $localidade - $uf - $cep';
  }
}
