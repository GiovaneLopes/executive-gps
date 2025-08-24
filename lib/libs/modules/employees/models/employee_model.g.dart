// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeModel _$EmployeeModelFromJson(Map<String, dynamic> json) =>
    EmployeeModel(
      id: json['id'] as String?,
      name: json['name'] as String,
      mobile: json['mobile'] as String,
      email: json['email'] as String,
      rg: json['rg'] as String,
      cpf: json['cpf'] as String,
      address: AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      isAdmin: json['isAdmin'] as bool? ?? false,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$EmployeeModelToJson(EmployeeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mobile': instance.mobile,
      'email': instance.email,
      'rg': instance.rg,
      'cpf': instance.cpf,
      'address': instance.address.toJson(),
      'isAdmin': instance.isAdmin,
      'images': instance.images.map((e) => e.toJson()).toList(),
    };
