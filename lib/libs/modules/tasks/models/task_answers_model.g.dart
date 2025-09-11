// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_answers_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskAnswersModel _$TaskAnswersModelFromJson(Map<String, dynamic> json) =>
    TaskAnswersModel(
      checklist: (json['checklist'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String?),
          ) ??
          const {},
      injectionLight: json['injectionLight'] as bool? ?? false,
      km: json['km'] as String?,
      observation: json['observation'] as String?,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => TaskImageModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TaskImageModel>[],
    );

Map<String, dynamic> _$TaskAnswersModelToJson(TaskAnswersModel instance) =>
    <String, dynamic>{
      'checklist': instance.checklist,
      'injectionLight': instance.injectionLight,
      'km': instance.km,
      'observation': instance.observation,
      'images': instance.images.map((e) => e.toJson()).toList(),
    };
