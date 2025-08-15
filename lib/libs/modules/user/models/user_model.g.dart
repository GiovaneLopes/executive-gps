// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      email: json['email'] as String?,
      password: json['password'] as String?,
      mobile: json['mobile'] as String?,
      cpf: json['cpf'] as String?,
      rg: json['rg'] as String?,
      address: json['address'] == null
          ? null
          : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'birthDate': instance.birthDate?.toIso8601String(),
      'email': instance.email,
      'password': instance.password,
      'mobile': instance.mobile,
      'cpf': instance.cpf,
      'rg': instance.rg,
      'address': instance.address,
    };
