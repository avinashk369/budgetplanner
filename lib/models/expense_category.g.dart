// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseCategory _$ExpenseCategoryFromJson(Map<String, dynamic> json) {
  return ExpenseCategory()
    ..id = json['id'] as String?
    ..name = json['name'] as String?;
}

Map<String, dynamic> _$ExpenseCategoryToJson(ExpenseCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
