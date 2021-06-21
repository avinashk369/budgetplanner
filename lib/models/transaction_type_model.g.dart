// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionType _$TransactionTypeFromJson(Map<String, dynamic> json) {
  return TransactionType()
    ..id = json['id'] as String?
    ..name = json['name'] as String?;
}

Map<String, dynamic> _$TransactionTypeToJson(TransactionType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
