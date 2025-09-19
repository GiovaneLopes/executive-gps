// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskImageModel _$TaskImageModelFromJson(Map<String, dynamic> json) =>
    TaskImageModel(
      url: json['url'] as String?,
      name: json['name'] as String?,
      type: $enumDecode(_$TaskImageTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$TaskImageModelToJson(TaskImageModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'name': instance.name,
      'type': _$TaskImageTypeEnumMap[instance.type]!,
    };

const _$TaskImageTypeEnumMap = {
  TaskImageType.signature: 'signature',
  TaskImageType.equipmentId: 'equipmentId',
  TaskImageType.chassi: 'chassi',
  TaskImageType.wiring: 'wiring',
  TaskImageType.customerPlace: 'customerPlace',
  TaskImageType.vehicleFront: 'vehicleFront',
  TaskImageType.additional: 'additional',
};
