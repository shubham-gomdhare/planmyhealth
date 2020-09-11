// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'physiotherapy_speciality.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhysiotherapySpeciality _$PhysiotherapySpecialityFromJson(
    Map<String, dynamic> json) {
  return PhysiotherapySpeciality(
    mangoId: json['_id'] as String,
    id: json['id'] as int,
    name: json['name'] as String,
    treatmentMode: json['treatmentMode'] as String,
    provTypeCode: json['provTypeCode'] as String,
    qualification: json['qualification'] as String,
  );
}

Map<String, dynamic> _$PhysiotherapySpecialityToJson(
        PhysiotherapySpeciality instance) =>
    <String, dynamic>{
      '_id': instance.mangoId,
      'id': instance.id,
      'name': instance.name,
      'treatmentMode': instance.treatmentMode,
      'provTypeCode': instance.provTypeCode,
      'qualification': instance.qualification,
    };
