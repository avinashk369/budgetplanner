// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel()
      ..id = json['id'] as String?
      ..catName = json['cat_name'] as String?
      ..amount = (json['amount'] as num?)?.toDouble()
      ..recurrance = json['recurrance'] as String?
      ..transactionType = json['transacion_type'] as String?
      ..createdOn = json['created_on'] == null
          ? null
          : DateTime.parse(json['created_on'] as String)
      ..updatedOn = json['updated_on'] == null
          ? null
          : DateTime.parse(json['updated_on'] as String)
      ..userId = json['user_id'] as String?
      ..expenseSource = json['expense_source'] as String?
      ..expenseType = json['expense_type'] as String?
      ..notes = json['notes'] as String?
      ..isRecurring = json['is_recurring'] as bool?;

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cat_name': instance.catName,
      'amount': instance.amount,
      'recurrance': instance.recurrance,
      'transacion_type': instance.transactionType,
      'created_on': instance.createdOn?.toIso8601String(),
      'updated_on': instance.updatedOn?.toIso8601String(),
      'user_id': instance.userId,
      'expense_source': instance.expenseSource,
      'expense_type': instance.expenseType,
      'notes': instance.notes,
      'is_recurring': instance.isRecurring,
    };
