// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
      street: json['street'] as String?,
      neighborhood: json['neighborhood'] as String?,
      number: json['number'] as String?,
      complement: json['complement'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      zipCode: json['zipCode'] as String?,
    );

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'street': instance.street,
      'neighborhood': instance.neighborhood,
      'number': instance.number,
      'complement': instance.complement,
      'city': instance.city,
      'state': instance.state,
      'zipCode': instance.zipCode,
    };
