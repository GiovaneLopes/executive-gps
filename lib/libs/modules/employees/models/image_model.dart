import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image_model.g.dart';

@JsonSerializable()
class ImageModel extends Equatable {
  final String? url;
  final String? name;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final XFile? file;

  const ImageModel({
    this.url,
    this.name,
    this.file,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);
  Map<String, dynamic> toJson() => _$ImageModelToJson(this);

  ImageModel copyWith({
    String? url,
    String? name,
    XFile? file,
  }) {
    return ImageModel(
      url: url ?? this.url,
      name: name ?? this.name,
      file: file ?? this.file,
    );
  }

  @override
  List<Object?> get props => [
        url,
        name,
        file,
      ];
}
