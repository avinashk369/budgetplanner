// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BudgetModel _$BudgetModelFromJson(Map<String, dynamic> json) => BudgetModel()
  ..id = json['id'] as String?
  ..catName = json['cat_name'] as String?
  ..notes = json['notes'] as String?
  ..amount = (json['amount'] as num?)?.toDouble()
  ..userId = json['user_id'] as String?
  ..monthName = json['month_name'] as String?
  ..createdOn = json['created_on'] == null
      ? null
      : DateTime.parse(json['created_on'] as String)
  ..updatedOn = json['updated_on'] == null
      ? null
      : DateTime.parse(json['updated_on'] as String);

Map<String, dynamic> _$BudgetModelToJson(BudgetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cat_name': instance.catName,
      'notes': instance.notes,
      'amount': instance.amount,
      'user_id': instance.userId,
      'month_name': instance.monthName,
      'created_on': instance.createdOn?.toIso8601String(),
      'updated_on': instance.updatedOn?.toIso8601String(),
    };
