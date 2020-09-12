import 'package:json_annotation/json_annotation.dart';

part 'treatment_medicine.g.dart';

@JsonSerializable()
class TreatmentMedicine {
  @JsonKey(name: '_id')
  final String mongoId;
  final int id;
  final String providerTypeCode;
  final String procedureName;
  final String preProcedureDetails;
  final String postProcedureDetails;
  final String procedureVideo;
  final String status;
  final String procedureDetails;
  final String testDetails;
  final String drugDetails;
  final String homeHealthCare;
  final String qualificationNeeded;
  final String speciality;
  final String duration;
  final String minCost;
  final String maxCost;

  TreatmentMedicine({
    this.mongoId,
    this.id,
    this.providerTypeCode,
    this.procedureName,
    this.preProcedureDetails,
    this.postProcedureDetails,
    this.procedureVideo,
    this.status,
    this.procedureDetails,
    this.testDetails,
    this.drugDetails,
    this.homeHealthCare,
    this.qualificationNeeded,
    this.speciality,
    this.duration,
    this.minCost,
    this.maxCost,
  });

  factory TreatmentMedicine.fromJson(Map<String, dynamic> json) =>
      _$TreatmentMedicineFromJson(json);
  Map<String, dynamic> toJson() => _$TreatmentMedicineToJson(this);
}
