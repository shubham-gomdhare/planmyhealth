import 'package:json_annotation/json_annotation.dart';

part 'doctors.g.dart';

@JsonSerializable()
class Doctor {
  @JsonKey(name: '_id')
  final String mongoId;
  final int id;
  final String name;
  final String qualification;
  final int experience;
  @JsonKey(name: 'treatmentType')
  final String treatmentType;
  final String picture;
  @JsonKey(name: 'cityId')
  final String cityId;
  @JsonKey(name: 'pincode')
  final int pinCode;
  @JsonKey(name: 'regId')
  final String regId;
  final String email;
  @JsonKey(name: 'fromTime')
  final String fromTime;
  @JsonKey(name: 'toTime')
  final String toTime;

  Doctor({
    this.mongoId,
    this.id,
    this.name,
    this.qualification,
    this.experience,
    this.treatmentType,
    this.picture,
    this.cityId,
    this.pinCode,
    this.regId,
    this.email,
    this.fromTime,
    this.toTime,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);
  Map<String, dynamic> toJson() => _$DoctorToJson(this);
}
