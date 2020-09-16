import 'package:json_annotation/json_annotation.dart';

part 'diagnostic.g.dart';

@JsonSerializable()
class Diagnostic {
  @JsonKey(name: '_id')
  final String mongoId;
  final int id;
  final String name;
  final String code;
  final double rate;
  final String pmhRate;
  final String homeTestFlag;
  final String fastingFlag;
  final String bloodQuantityRequired;
  final String testResults;
  final String detailedDescription;
  final String diseaseListForWhichTheseTestIsConducted;
  final String minAge;
  final String maxAge;
  final String needDocPrescriptionFlag;
  final String testType;

  Diagnostic(
      this.mongoId,
      this.id,
      this.name,
      this.code,
      this.rate,
      this.pmhRate,
      this.homeTestFlag,
      this.fastingFlag,
      this.bloodQuantityRequired,
      this.testResults,
      this.detailedDescription,
      this.diseaseListForWhichTheseTestIsConducted,
      this.minAge,
      this.maxAge,
      this.needDocPrescriptionFlag,
      this.testType);

  factory Diagnostic.fromJson(Map<String, dynamic> json) =>
      _$DiagnosticFromJson(json);
  Map<String, dynamic> toJson() => _$DiagnosticToJson(this);
}
