import 'package:json_annotation/json_annotation.dart';

part 'diagnolotic.g.dart';

@JsonSerializable()
class Diagnolotic {
  @JsonKey(name: '_id')
  final String mongoId;
  final int id;
  final String name;
  final String code;
  final double rate;

  Diagnolotic(this.mongoId, this.id, this.name, this.code, this.rate);

  factory Diagnolotic.fromJson(Map<String, dynamic> json) =>
      _$DiagnoloticFromJson(json);
  Map<String, dynamic> toJson() => _$DiagnoloticToJson(this);
}
