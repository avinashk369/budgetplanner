// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) {
  return TransactionModel()
    ..id = json['id'] as String?
    ..catName = json['cat_name'] as String?
    ..amount = (json['amount'] as num?)?.toDouble()
    ..recurrance = json['recurrance'] as String?
    ..transactionType = json['transacion_type'] as String?
    ..createdOn = json['created_on'] as String?
    ..updatedOn = json['updated_on'] as String?
    ..userId = json['user_id'] as String?
    ..expenseSource = json['expense_source'] as String?
    ..expenseType = json['expense_type'] as String?;
}

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cat_name': instance.catName,
      'amount': instance.amount,
      'recurrance': instance.recurrance,
      'transacion_type': instance.transactionType,
      'created_on': instance.createdOn,
      'updated_on': instance.updatedOn,
      'user_id': instance.userId,
      'expense_source': instance.expenseSource,
      'expense_type': instance.expenseType,
    };
