import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:executive_gps/libs/modules/employees/models/image_model.dart';
import 'package:executive_gps/libs/modules/address/models/address_model.dart';

part 'employee_model.g.dart';

@JsonSerializable(explicitToJson: true)
class EmployeeModel extends Equatable {
  final String? id;
  final String name;
  final String mobile;
  final String email;
  final String rg;
  final String cpf;
  final AddressModel address;
  final bool isAdmin;
  final List<ImageModel> images;

  const EmployeeModel({
    this.id,
    required this.name,
    required this.mobile,
    required this.email,
    required this.rg,
    required this.cpf,
    required this.address,
    this.isAdmin = false,
    this.images = const [],
  });

  EmployeeModel.empty()
      : id = null,
        name = 'Desconhecido',
        mobile = 'Não informado',
        email = 'Não informado',
        rg = 'Não informado',
        cpf = 'Não informado',
        address = const AddressModel.empty(),
        isAdmin = false,
        images = [];

  EmployeeModel copyWith({
    String? id,
    String? name,
    String? mobile,
    String? email,
    String? rg,
    String? cpf,
    AddressModel? address,
    bool? isAdmin,
    List<ImageModel>? images,
  }) {
    return EmployeeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      rg: rg ?? this.rg,
      cpf: cpf ?? this.cpf,
      address: address ?? this.address,
      isAdmin: isAdmin ?? this.isAdmin,
      images: images ?? this.images,
    );
  }

  factory EmployeeModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeModelFromJson(json);
  Map<String, dynamic> toJson() => _$EmployeeModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        mobile,
        email,
        rg,
        cpf,
        address,
        isAdmin,
        images,
      ];

  @override
  String toString() {
    return name;
  }
}
