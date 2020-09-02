// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diagnolotic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Diagnolotic _$DiagnoloticFromJson(Map<String, dynamic> json) {
  return Diagnolotic(
    json['_id'] as String,
    json['id'] as int,
    json['name'] as String,
    json['code'] as String,
    (json['rate'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$DiagnoloticToJson(Diagnolotic instance) =>
    <String, dynamic>{
      '_id': instance.mongoId,
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'rate': instance.rate,
    };
