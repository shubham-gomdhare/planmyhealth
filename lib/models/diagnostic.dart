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

  Diagnostic(this.mongoId, this.id, this.name, this.code, this.rate);

  factory Diagnostic.fromJson(Map<String, dynamic> json) =>
      _$DiagnosticFromJson(json);
  Map<String, dynamic> toJson() => _$DiagnosticToJson(this);
}
