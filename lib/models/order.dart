import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  @JsonKey(name: '_id')
  final String mongoId;
  final String id;
  final String name;
  final double price;
  final String type;
  final DateTime bookedAt;
  final DateTime updatedAt;
  final DateTime createdAt;

  Order({
    this.mongoId,
    this.id,
    this.name,
    this.price,
    this.type,
    this.bookedAt,
    this.updatedAt,
    this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
