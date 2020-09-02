// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctors.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doctor _$DoctorFromJson(Map<String, dynamic> json) {
  return Doctor(
    mongoId: json['_id'] as String,
    id: json['id'] as int,
    name: json['name'] as String,
    qualification: json['qualification'] as String,
    experience: json['experience'] as int,
    treatmentType: json['treatmentType'] as String,
    picture: json['picture'] as String,
    cityId: json['cityId'] as String,
    pinCode: json['pincode'] as int,
    regId: json['regId'] as String,
    email: json['email'] as String,
    fromTime: json['fromTime'] as String,
    toTime: json['toTime'] as String,
  );
}

Map<String, dynamic> _$DoctorToJson(Doctor instance) => <String, dynamic>{
      '_id': instance.mongoId,
      'id': instance.id,
      'name': instance.name,
      'qualification': instance.qualification,
      'experience': instance.experience,
      'treatmentType': instance.treatmentType,
      'picture': instance.picture,
      'cityId': instance.cityId,
      'pincode': instance.pinCode,
      'regId': instance.regId,
      'email': instance.email,
      'fromTime': instance.fromTime,
      'toTime': instance.toTime,
    };
