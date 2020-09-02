import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:medico/models/diagnolotic.dart';
import 'package:medico/models/medicines.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart {
  @JsonKey(name: 'medicines')
  final List<Medicine> medicineList;
  @JsonKey(name: 'diagnolotics')
  final List<Diagnolotic> diagnoloticList;

  Cart({this.medicineList, this.diagnoloticList});

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
  Map<String, dynamic> toJson() => _$CartToJson(this);
}

@JsonSerializable()
class PostCart {
  final String userId;
  final String itemId;
  final String itemType;

  PostCart({@required this.userId, @required this.itemId, @required this.itemType,});

  factory PostCart.fromJson(Map<String, dynamic> json) => _$PostCartFromJson(json);
  Map<String, dynamic> toJson() => _$PostCartToJson(this);
}