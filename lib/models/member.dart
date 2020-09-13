import 'package:json_annotation/json_annotation.dart';

part 'member.g.dart';

@JsonSerializable()
class Member {
  @JsonKey(name: '_id')
  final String mongoId;
  final String id;
  final String name;
  final String cityId;
  final int pincode;
  final String gender;
  final int age;
  final int mobile;
  final String password;
  final String dateOfJoining;
  final String employeeTag;
  final int employeeId;
  final String groupId;
  final String relation;
  final String email;
  final String renewalFlag;
  final String activeFlag;
  final String activePlanId;

  Member({
    this.mongoId,
    this.id,
    this.name,
    this.cityId,
    this.pincode,
    this.gender,
    this.age,
    this.mobile,
    this.password,
    this.dateOfJoining,
    this.employeeTag,
    this.employeeId,
    this.groupId,
    this.relation,
    this.email,
    this.renewalFlag,
    this.activeFlag,
    this.activePlanId,
  });

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
  Map<String, dynamic> toJson() => _$MemberToJson(this);
}
