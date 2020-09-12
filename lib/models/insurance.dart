import 'package:json_annotation/json_annotation.dart';

part 'insurance.g.dart';

@JsonSerializable()
class Insurance {
  @JsonKey(name: '_id')
  final String mongoId;
  final int id;
  final String insuranceCo;
  final String insCode;
  final String insType;
  final String telAreaCode;
  final String telNo;
  final String faxNo;
  final String emailId;
  final String webId;
  final String address1;
  final String address2;
  final String addressArea;
  final String cityCode;
  final String pinCode;
  final String stateCode;
  final String countryCode;
  final String remarks;
  final String officeType;
  final String parentCode;
  final String branchName;
  final String compAvail;
  final String oldInsCode;
  final String mainInsCode;
  final String doCode;

  Insurance({
    this.mongoId,
    this.id,
    this.insuranceCo,
    this.insCode,
    this.insType,
    this.telAreaCode,
    this.telNo,
    this.faxNo,
    this.emailId,
    this.webId,
    this.address1,
    this.address2,
    this.addressArea,
    this.cityCode,
    this.pinCode,
    this.stateCode,
    this.countryCode,
    this.remarks,
    this.officeType,
    this.parentCode,
    this.branchName,
    this.compAvail,
    this.oldInsCode,
    this.mainInsCode,
    this.doCode,
  });

  factory Insurance.fromJson(Map<String, dynamic> json) =>
      _$InsuranceFromJson(json);
  Map<String, dynamic> toJson() => _$InsuranceToJson(this);
}
