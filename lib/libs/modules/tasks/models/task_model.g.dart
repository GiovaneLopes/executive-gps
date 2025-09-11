// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
      id: json['id'] as String?,
      step: $enumDecodeNullable(_$TaskStepEnumMap, json['step']) ??
          TaskStep.scheduled,
      customerId: json['customerId'] as String,
      employeeId: json['employeeId'] as String,
      type: $enumDecode(_$TaskTypeEnumMap, json['type']),
      identifier: json['identifier'] as String,
      dueDate: DateTime.parse(json['dueDate'] as String),
      vehiclePlate: json['vehiclePlate'] as String,
      observation: json['observation'] as String?,
    );

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'employeeId': instance.employeeId,
      'step': _$TaskStepEnumMap[instance.step]!,
      'type': _$TaskTypeEnumMap[instance.type]!,
      'identifier': instance.identifier,
      'dueDate': instance.dueDate.toIso8601String(),
      'vehiclePlate': instance.vehiclePlate,
      'observation': instance.observation,
    };

const _$TaskStepEnumMap = {
  TaskStep.waiting: 'waiting',
  TaskStep.scheduled: 'scheduled',
  TaskStep.completed: 'completed',
  TaskStep.canceled: 'canceled',
};

const _$TaskTypeEnumMap = {
  TaskType.installation: 'installation',
  TaskType.removal: 'removal',
  TaskType.maintenance: 'maintenance',
  TaskType.vehicleChange: 'vehicleChange',
  TaskType.ownerChange: 'ownerChange',
};
