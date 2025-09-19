import 'package:equatable/equatable.dart';
import 'package:executive_gps/libs/modules/tasks/models/task_image_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'task_answers_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TaskAnswersModel extends Equatable {
  final Map<String, String?> checklist;
  final bool injectionLight;
  final String? km;
  final String? observation;
  final List<TaskImageModel> images;

  const TaskAnswersModel({
    this.checklist = const {},
    this.injectionLight = false,
    this.km,
    this.observation,
    this.images = const <TaskImageModel>[],
  });

  factory TaskAnswersModel.fromJson(Map<String, dynamic> json) =>
      _$TaskAnswersModelFromJson(json);
  Map<String, dynamic> toJson() => _$TaskAnswersModelToJson(this);

  TaskAnswersModel copyWith({
    Map<String, String?>? checklist,
    bool? injectionLight,
    String? km,
    String? observation,
    List<TaskImageModel>? images,
  }) {
    return TaskAnswersModel(
      checklist: checklist ?? this.checklist,
      injectionLight: injectionLight ?? this.injectionLight,
      km: km ?? this.km,
      observation: observation ?? this.observation,
      images: images ?? this.images,
    );
  }

  @override
  List<Object?> get props => [
        checklist,
        injectionLight,
        km,
        observation,
        images,
      ];
}
