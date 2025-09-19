import 'package:equatable/equatable.dart';
import 'package:executive_gps/libs/modules/tasks/models/task_answers_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:executive_gps/libs/modules/tasks/models/task_type.dart';
import 'package:executive_gps/libs/modules/tasks/models/task_step.dart';
import 'package:executive_gps/libs/modules/customers/models/customer_model.dart';
import 'package:executive_gps/libs/modules/employees/models/employee_model.dart';

part 'task_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TaskModel extends Equatable {
  final String? id;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final CustomerModel? customer;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final EmployeeModel? employee;
  final String customerId;
  final String employeeId;
  final TaskStep step;
  final TaskType type;
  final String? identifier;
  final DateTime dueDate;
  final String vehiclePlate;
  final String? observation;

  const TaskModel({
    this.id,
    this.customer,
    this.employee,
    this.step = TaskStep.scheduled,
    required this.customerId,
    required this.employeeId,
    required this.type,
    this.identifier,
    required this.dueDate,
    required this.vehiclePlate,
    this.observation,
  });

  TaskModel copyWith({
    String? id,
    CustomerModel? customer,
    EmployeeModel? employee,
    String? customerId,
    String? employeeId,
    TaskStep? step,
    TaskType? type,
    String? identifier,
    DateTime? dueDate,
    String? vehiclePlate,
    String? observation,
    TaskAnswersModel? answers,
  }) {
    return TaskModel(
      id: id ?? this.id,
      customer: customer ?? this.customer,
      employee: employee ?? this.employee,
      customerId: customerId ?? this.customerId,
      employeeId: employeeId ?? this.employeeId,
      step: step ?? this.step,
      type: type ?? this.type,
      identifier: identifier ?? this.identifier,
      dueDate: dueDate ?? this.dueDate,
      vehiclePlate: vehiclePlate ?? this.vehiclePlate,
      observation: observation ?? this.observation,
    );
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
  Map<String, dynamic> toJson() => _$TaskModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        customer,
        employee,
        customerId,
        employeeId,
        step,
        type,
        identifier,
        dueDate,
        vehiclePlate,
        observation,
      ];
}
