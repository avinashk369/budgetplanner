import 'package:json_annotation/json_annotation.dart';
part 'expense_source_model.g.dart';

@JsonSerializable()
class ExpenseSourceModel {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(includeFromJson: false)
  bool isSelected = false;
  ExpenseSourceModel();
  factory ExpenseSourceModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseSourceModelFromJson(json);
  Map<String, dynamic> toJson() => _$ExpenseSourceModelToJson(this);
}
