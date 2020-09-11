import 'package:json_annotation/json_annotation.dart';

part 'physiotherapy_speciality.g.dart';

@JsonSerializable()
class PhysiotherapySpeciality {
  @JsonKey(name: "_id")
  final String mangoId;
  final int id;
  final String name;
  final String treatmentMode;
  final String provTypeCode;
  final String qualification;

  PhysiotherapySpeciality(
      {this.mangoId,
      this.id,
      this.name,
      this.treatmentMode,
      this.provTypeCode,
      this.qualification});

  factory PhysiotherapySpeciality.fromJson(Map<String, dynamic> json) =>
      _$PhysiotherapySpecialityFromJson(json);
  Map<String, dynamic> toJson() => _$PhysiotherapySpecialityToJson(this);
}
