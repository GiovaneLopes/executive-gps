import 'package:executive_gps/libs/modules/employees/models/image_model.dart';
import 'package:executive_gps/libs/modules/tasks/models/task_image_type.dart';
import 'package:image_picker/image_picker.dart';
import 'package:json_annotation/json_annotation.dart';
part 'task_image_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TaskImageModel extends ImageModel {
  final TaskImageType type;
  const TaskImageModel({
    super.url,
    super.name,
    super.file,
    required this.type,
  });

  @override
  TaskImageModel copyWith({
    String? url,
    String? name,
    XFile? file,
    TaskImageType? type,
  }) {
    return TaskImageModel(
      url: url ?? this.url,
      name: name ?? this.name,
      file: file ?? this.file,
      type: type ?? this.type,
    );
  }

  factory TaskImageModel.fromJson(Map<String, dynamic> json) =>
      _$TaskImageModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TaskImageModelToJson(this);

  @override
  List<Object?> get props => [
        url,
        name,
        file,
        type,
      ];
}
