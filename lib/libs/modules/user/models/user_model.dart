import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:executive_gps/libs/modules/user/models/address_model.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  final String? id;
  final String? name;
  final DateTime? birthDate;
  final String? email;
  final String? password;
  final String? mobile;
  final String? cpf;
  final String? rg;
  final AddressModel? address;

  const UserModel({
    this.id,
    this.name,
    this.birthDate,
    this.email,
    this.password,
    this.mobile,
    this.cpf,
    this.rg,
    this.address,
  });

  UserModel copyWith({
    String? id,
    String? name,
    DateTime? birthDate,
    String? email,
    String? password,
    String? mobile,
    String? cpf,
    String? rg,
    AddressModel? address,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
      email: email ?? this.email,
      password: password ?? this.password,
      mobile: mobile ?? this.mobile,
      cpf: cpf ?? this.cpf,
      rg: rg ?? this.rg,
      address: address ?? this.address,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        birthDate,
        email,
        password,
        mobile,
        cpf,
        rg,
        address,
      ];
}
