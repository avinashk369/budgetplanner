import 'package:json_annotation/json_annotation.dart';
import 'package:get/get.dart';
part 'budget_model.g.dart';

@JsonSerializable()
class BudgetModel {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "cat_name")
  String? catName;
  @JsonKey(name: "notes")
  String? notes;
  @JsonKey(name: "amount")
  double? amount;
  @JsonKey(name: "user_id")
  String? userId;
  @JsonKey(name: "month_name")
  String? monthName;
  @JsonKey(name: "created_on")
  DateTime? createdOn;
  @JsonKey(name: "updated_on")
  DateTime? updatedOn;
  @JsonKey(includeFromJson: false)
  var totalBudgetExpense = 0.0.obs;
  setTotalBudgetExpense(double total) => totalBudgetExpense(total);
  BudgetModel();
  factory BudgetModel.fromJson(Map<String, dynamic> json) =>
      _$BudgetModelFromJson(json);
  Map<String, dynamic> toJson() => _$BudgetModelToJson(this);
}
