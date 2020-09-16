// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diagnostic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Diagnostic _$DiagnosticFromJson(Map<String, dynamic> json) {
  return Diagnostic(
    json['_id'] as String,
    json['id'] as int,
    json['name'] as String,
    json['code'] as String,
    (json['rate'] as num)?.toDouble(),
    json['pmhRate'] as String,
    json['homeTestFlag'] as String,
    json['fastingFlag'] as String,
    json['bloodQuantityRequired'] as String,
    json['testResults'] as String,
    json['detailedDescription'] as String,
    json['diseaseListForWhichTheseTestIsConducted'] as String,
    json['minAge'] as String,
    json['maxAge'] as String,
    json['needDocPrescriptionFlag'] as String,
    json['testType'] as String,
  );
}

Map<String, dynamic> _$DiagnosticToJson(Diagnostic instance) =>
    <String, dynamic>{
      '_id': instance.mongoId,
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'rate': instance.rate,
      'pmhRate': instance.pmhRate,
      'homeTestFlag': instance.homeTestFlag,
      'fastingFlag': instance.fastingFlag,
      'bloodQuantityRequired': instance.bloodQuantityRequired,
      'testResults': instance.testResults,
      'detailedDescription': instance.detailedDescription,
      'diseaseListForWhichTheseTestIsConducted':
          instance.diseaseListForWhichTheseTestIsConducted,
      'minAge': instance.minAge,
      'maxAge': instance.maxAge,
      'needDocPrescriptionFlag': instance.needDocPrescriptionFlag,
      'testType': instance.testType,
    };
