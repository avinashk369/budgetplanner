import 'package:json_annotation/json_annotation.dart';
part 'expense_type_model.g.dart';

@JsonSerializable()
class ExpenseType {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  ExpenseType();

  factory ExpenseType.fromJson(Map<String, dynamic> json) =>
      _$ExpenseTypeFromJson(json);
  Map<String, dynamic> toJson() => _$ExpenseTypeToJson(this);
}
