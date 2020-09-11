import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  @JsonKey(name: '_id')
  final String mongoId;
  final String id;
  final String type;
  final DateTime updatedAt;
  final DateTime createdAt;

  Order({this.mongoId, this.id, this.type, this.updatedAt, this.createdAt});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
