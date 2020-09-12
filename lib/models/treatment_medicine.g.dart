// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment_medicine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreatmentMedicine _$TreatmentMedicineFromJson(Map<String, dynamic> json) {
  return TreatmentMedicine(
    mongoId: json['_id'] as String,
    id: json['id'] as int,
    providerTypeCode: json['providerTypeCode'] as String,
    procedureName: json['procedureName'] as String,
    preProcedureDetails: json['preProcedureDetails'] as String,
    postProcedureDetails: json['postProcedureDetails'] as String,
    procedureVideo: json['procedureVideo'] as String,
    status: json['status'] as String,
    procedureDetails: json['procedureDetails'] as String,
    testDetails: json['testDetails'] as String,
    drugDetails: json['drugDetails'] as String,
    homeHealthCare: json['homeHealthCare'] as String,
    qualificationNeeded: json['qualificationNeeded'] as String,
    speciality: json['speciality'] as String,
    duration: json['duration'] as String,
    minCost: json['minCost'] as String,
    maxCost: json['maxCost'] as String,
  );
}

Map<String, dynamic> _$TreatmentMedicineToJson(TreatmentMedicine instance) =>
    <String, dynamic>{
      '_id': instance.mongoId,
      'id': instance.id,
      'providerTypeCode': instance.providerTypeCode,
      'procedureName': instance.procedureName,
      'preProcedureDetails': instance.preProcedureDetails,
      'postProcedureDetails': instance.postProcedureDetails,
      'procedureVideo': instance.procedureVideo,
      'status': instance.status,
      'procedureDetails': instance.procedureDetails,
      'testDetails': instance.testDetails,
      'drugDetails': instance.drugDetails,
      'homeHealthCare': instance.homeHealthCare,
      'qualificationNeeded': instance.qualificationNeeded,
      'speciality': instance.speciality,
      'duration': instance.duration,
      'minCost': instance.minCost,
      'maxCost': instance.maxCost,
    };
