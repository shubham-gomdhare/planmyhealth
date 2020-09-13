import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:medico/models/diagnostic.dart';
import 'package:medico/models/medicines.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart {
  @JsonKey(name: 'medicines')
  final List<Medicine> medicineList;
  @JsonKey(name: 'diagnostics')
  final List<Diagnostic> diagnostic;

  Cart({this.medicineList, this.diagnostic});

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
  Map<String, dynamic> toJson() => _$CartToJson(this);
}

@JsonSerializable()
class PostCart {
  final String userId;
  final String id;
  final String type;

  PostCart({
    @required this.userId,
    @required this.id,
    @required this.type,
  });

  factory PostCart.fromJson(Map<String, dynamic> json) =>
      _$PostCartFromJson(json);
  Map<String, dynamic> toJson() => _$PostCartToJson(this);
}
