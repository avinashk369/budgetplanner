import 'package:json_annotation/json_annotation.dart';
part 'budget_category_model.g.dart';

@JsonSerializable()
class BudgetCategoryModel {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(ignore: true)
  bool isSelected = false;

  BudgetCategoryModel();

  factory BudgetCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$BudgetCategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$BudgetCategoryModelToJson(this);
}
