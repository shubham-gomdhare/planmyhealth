// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insurance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Insurance _$InsuranceFromJson(Map<String, dynamic> json) {
  return Insurance(
    mongoId: json['_id'] as String,
    id: json['id'] as int,
    insuranceCo: json['insuranceCo'] as String,
    insCode: json['insCode'] as String,
    telAreaCode: json['telAreaCode'] as String,
    telNo: json['telNo'] as String,
    faxNo: json['faxNo'] as String,
    emailId: json['emailId'] as String,
    webId: json['webId'] as String,
    address1: json['address1'] as String,
    address2: json['address2'] as String,
    addressArea: json['addressArea'] as String,
    cityCode: json['cityCode'] as String,
    pinCode: json['pinCode'] as String,
    stateCode: json['stateCode'] as String,
    countryCode: json['countryCode'] as String,
    remarks: json['remarks'] as String,
    officeType: json['officeType'] as String,
    parentCode: json['parentCode'] as String,
    branchName: json['branchName'] as String,
    compAvail: json['compAvail'] as String,
    oldInsCode: json['oldInsCode'] as String,
    mainInsCode: json['mainInsCode'] as String,
    doCode: json['doCode'] as String,
  );
}

Map<String, dynamic> _$InsuranceToJson(Insurance instance) => <String, dynamic>{
      '_id': instance.mongoId,
      'id': instance.id,
      'insuranceCo': instance.insuranceCo,
      'insCode': instance.insCode,
      'telAreaCode': instance.telAreaCode,
      'telNo': instance.telNo,
      'faxNo': instance.faxNo,
      'emailId': instance.emailId,
      'webId': instance.webId,
      'address1': instance.address1,
      'address2': instance.address2,
      'addressArea': instance.addressArea,
      'cityCode': instance.cityCode,
      'pinCode': instance.pinCode,
      'stateCode': instance.stateCode,
      'countryCode': instance.countryCode,
      'remarks': instance.remarks,
      'officeType': instance.officeType,
      'parentCode': instance.parentCode,
      'branchName': instance.branchName,
      'compAvail': instance.compAvail,
      'oldInsCode': instance.oldInsCode,
      'mainInsCode': instance.mainInsCode,
      'doCode': instance.doCode,
    };
