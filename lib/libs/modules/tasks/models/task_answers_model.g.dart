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
      signature: json['signature'] == null
          ? null
          : ImageModel.fromJson(json['signature'] as Map<String, dynamic>),
      equipmentId: json['equipmentId'] == null
          ? null
          : ImageModel.fromJson(json['equipmentId'] as Map<String, dynamic>),
      wiring: json['wiring'] == null
          ? null
          : ImageModel.fromJson(json['wiring'] as Map<String, dynamic>),
      customerPlace: json['customerPlace'] == null
          ? null
          : ImageModel.fromJson(json['customerPlace'] as Map<String, dynamic>),
      vehicleFront: json['vehicleFront'] == null
          ? null
          : ImageModel.fromJson(json['vehicleFront'] as Map<String, dynamic>),
      additional: json['additional'] == null
          ? null
          : ImageModel.fromJson(json['additional'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TaskAnswersModelToJson(TaskAnswersModel instance) =>
    <String, dynamic>{
      'checklist': instance.checklist,
      'injectionLight': instance.injectionLight,
      'km': instance.km,
      'observation': instance.observation,
      'signature': instance.signature?.toJson(),
      'equipmentId': instance.equipmentId?.toJson(),
      'wiring': instance.wiring?.toJson(),
      'customerPlace': instance.customerPlace?.toJson(),
      'vehicleFront': instance.vehicleFront?.toJson(),
      'additional': instance.additional?.toJson(),
    };
