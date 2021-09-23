// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saving_goal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SavingGoal _$SavingGoalFromJson(Map<String, dynamic> json) => SavingGoal()
  ..id = json['id'] as String?
  ..catName = json['budget_cat'] as String?
  ..userId = json['user_id'] as String?
  ..amount = (json['amount'] as num?)?.toDouble()
  ..alert = json['alert'] as String?
  ..monthName = json['month_name'] as String?
  ..createdOn = json['created_on'] as String?
  ..updatedOn = json['updated_on'] as String?;

Map<String, dynamic> _$SavingGoalToJson(SavingGoal instance) =>
    <String, dynamic>{
      'id': instance.id,
      'budget_cat': instance.catName,
      'user_id': instance.userId,
      'amount': instance.amount,
      'alert': instance.alert,
      'month_name': instance.monthName,
      'created_on': instance.createdOn,
      'updated_on': instance.updatedOn,
    };
