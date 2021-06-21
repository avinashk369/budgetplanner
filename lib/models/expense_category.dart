import 'package:json_annotation/json_annotation.dart';
part 'expense_category.g.dart';

@JsonSerializable()
class ExpenseCategory {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  ExpenseCategory();

  factory ExpenseCategory.fromJson(Map<String, dynamic> json) =>
      _$ExpenseCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$ExpenseCategoryToJson(this);
}
