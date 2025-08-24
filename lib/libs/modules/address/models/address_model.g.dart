// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
      logradouro: json['logradouro'] as String?,
      bairro: json['bairro'] as String?,
      numero: json['numero'] as String?,
      complemento: json['complemento'] as String?,
      localidade: json['localidade'] as String?,
      uf: json['uf'] as String?,
      cep: json['cep'] as String?,
    );

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'logradouro': instance.logradouro,
      'bairro': instance.bairro,
      'numero': instance.numero,
      'complemento': instance.complemento,
      'localidade': instance.localidade,
      'uf': instance.uf,
      'cep': instance.cep,
    };
