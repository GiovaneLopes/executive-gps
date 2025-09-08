import 'package:equatable/equatable.dart';
import 'package:executive_gps/libs/modules/employees/models/image_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'task_answers_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TaskAnswersModel extends Equatable {
  final Map<String, String?> checklist;
  final bool injectionLight;
  final String? km;
  final String? observation;
  final ImageModel? signature;
  final ImageModel? equipmentId;
  final ImageModel? wiring;
  final ImageModel? customerPlace;
  final ImageModel? vehicleFront;
  final ImageModel? additional;

  const TaskAnswersModel({
    this.checklist = const {},
    this.injectionLight = false,
    this.km,
    this.observation,
    this.signature,
    this.equipmentId,
    this.wiring,
    this.customerPlace,
    this.vehicleFront,
    this.additional,
  });

  factory TaskAnswersModel.fromJson(Map<String, dynamic> json) =>
      _$TaskAnswersModelFromJson(json);
  Map<String, dynamic> toJson() => _$TaskAnswersModelToJson(this);

  TaskAnswersModel copyWith({
    Map<String, String?>? checklist,
    bool? injectionLight,
    String? km,
    String? observation,
    ImageModel? Function()? signature,
    ImageModel? equipmentId,
    ImageModel? wiring,
    ImageModel? customerPlace,
    ImageModel? vehicleFront,
    ImageModel? additional,
  }) {
    return TaskAnswersModel(
      checklist: checklist ?? this.checklist,
      injectionLight: injectionLight ?? this.injectionLight,
      km: km ?? this.km,
      observation: observation ?? this.observation,
      signature: signature != null ? signature() : this.signature,
      equipmentId: equipmentId ?? this.equipmentId,
      wiring: wiring ?? this.wiring,
      customerPlace: customerPlace ?? this.customerPlace,
      vehicleFront: vehicleFront ?? this.vehicleFront,
      additional: additional ?? this.additional,
    );
  }

  @override
  List<Object?> get props => [
        checklist,
        injectionLight,
        km,
        observation,
        signature,
        equipmentId,
        wiring,
        customerPlace,
        vehicleFront,
        additional,
      ];
}
