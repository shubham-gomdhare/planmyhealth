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
    diagnostic: (json['diagnostics'] as List)
        ?.map((e) =>
            e == null ? null : Diagnostic.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'medicines': instance.medicineList,
      'diagnostics': instance.diagnostic,
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
      'id': instance.id,
      'type': instance.type,
    };
