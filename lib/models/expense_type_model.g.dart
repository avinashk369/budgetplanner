// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseType _$ExpenseTypeFromJson(Map<String, dynamic> json) {
  return ExpenseType()
    ..id = json['id'] as String?
    ..name = json['name'] as String?;
}

Map<String, dynamic> _$ExpenseTypeToJson(ExpenseType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
