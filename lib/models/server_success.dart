import 'package:json_annotation/json_annotation.dart';

part 'server_success.g.dart';

@JsonSerializable()
class ServerSuccess {
  final String message;
  ServerSuccess({this.message});

  factory ServerSuccess.fromJson(Map<String, dynamic> json) => _$ServerSuccessFromJson(json);
  Map<String, dynamic> toJson() => _$ServerSuccessToJson(this);
}