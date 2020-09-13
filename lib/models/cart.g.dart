// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) {
  return Cart(
    medicineList: (json['medicines'] as List)
        ?.map((e) =>
            e == null ? null : Medicine.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    diagnoloticList: (json['diagnolotics'] as List)
        ?.map((e) =>
            e == null ? null : Diagnolotic.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'medicines': instance.medicineList,
      'diagnolotics': instance.diagnoloticList,
    };

PostCart _$PostCartFromJson(Map<String, dynamic> json) {
  return PostCart(
    userId: json['userId'] as String,
    id: json['id'] as String,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$PostCartToJson(PostCart instance) => <String, dynamic>{
      'userId': instance.userId,
      'itemId': instance.id,
      'itemType': instance.type,
    };
