import 'package:json_annotation/json_annotation.dart';
part 'saving_goal_model.g.dart';

@JsonSerializable()
class SavingGoal {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "budget_cat")
  String? catName;
  @JsonKey(name: "user_id")
  String? userId;
  @JsonKey(name: "amount")
  double? amount;
  @JsonKey(name: "alert")
  String? alert;
  @JsonKey(name: "month_name")
  String? monthName;
  @JsonKey(name: "created_on")
  String? createdOn;
  @JsonKey(name: "updated_on")
  String? updatedOn;
  SavingGoal();

  factory SavingGoal.fromJson(Map<String, dynamic> json) =>
      _$SavingGoalFromJson(json);
  Map<String, dynamic> toJson() => _$SavingGoalToJson(this);
}
