import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'address_model.g.dart';

@JsonSerializable()
class AddressModel extends Equatable {
  final String? street;
  final String? neighborhood;
  final String? number;
  final String? complement;
  final String? city;
  final String? state;
  final String? zipCode;

  const AddressModel({
    this.street,
    this.neighborhood,
    this.number,
    this.complement,
    this.city,
    this.state,
    this.zipCode,
  });

  AddressModel copyWith({
    String? street,
    String? neighborhood,
    String? number,
    String? complement,
    String? city,
    String? state,
    String? zipCode,
  }) {
    return AddressModel(
      street: street ?? this.street,
      neighborhood: neighborhood ?? this.neighborhood,
      number: number ?? this.number,
      complement: complement ?? this.complement,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
    );
  }

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);

  @override
  List<Object?> get props => [
        street,
        neighborhood,
        number,
        complement,
        city,
        state,
        zipCode,
      ];
}
