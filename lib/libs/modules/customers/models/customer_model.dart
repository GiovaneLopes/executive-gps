import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:executive_gps/libs/modules/employees/models/image_model.dart';
import 'package:executive_gps/libs/modules/address/models/address_model.dart';

part 'customer_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CustomerModel extends Equatable {
  final String? id;
  final String name;
  final String mobile;
  final String email;
  final String cpf;
  final AddressModel address;
  final List<ImageModel> images;

  const CustomerModel({
    this.id,
    required this.name,
    required this.mobile,
    required this.email,
    required this.cpf,
    required this.address,
    this.images = const [],
  });

  CustomerModel copyWith({
    String? id,
    String? name,
    String? mobile,
    String? email,
    String? cpf,
    AddressModel? address,
    List<ImageModel>? images,
  }) {
    return CustomerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      cpf: cpf ?? this.cpf,
      address: address ?? this.address,
      images: images ?? this.images,
    );
  }

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        mobile,
        email,
        cpf,
        address,
        images,
      ];
}
