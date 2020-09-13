// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Member _$MemberFromJson(Map<String, dynamic> json) {
  return Member(
    mongoId: json['_id'] as String,
    id: json['id'] as String,
    name: json['name'] as String,
    cityId: json['cityId'] as String,
    pincode: json['pincode'] as int,
    gender: json['gender'] as String,
    age: json['age'] as int,
    mobile: json['mobile'] as int,
    password: json['password'] as String,
    dateOfJoining: json['dateOfJoining'] as String,
    employeeTag: json['employeeTag'] as String,
    employeeId: json['employeeId'] as int,
    groupId: json['groupId'] as String,
    relation: json['relation'] as String,
    email: json['email'] as String,
    renewalFlag: json['renewalFlag'] as String,
    activeFlag: json['activeFlag'] as String,
    activePlanId: json['activePlanId'] as String,
  );
}

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      '_id': instance.mongoId,
      'id': instance.id,
      'name': instance.name,
      'cityId': instance.cityId,
      'pincode': instance.pincode,
      'gender': instance.gender,
      'age': instance.age,
      'mobile': instance.mobile,
      'password': instance.password,
      'dateOfJoining': instance.dateOfJoining,
      'employeeTag': instance.employeeTag,
      'employeeId': instance.employeeId,
      'groupId': instance.groupId,
      'relation': instance.relation,
      'email': instance.email,
      'renewalFlag': instance.renewalFlag,
      'activeFlag': instance.activeFlag,
      'activePlanId': instance.activePlanId,
    };
