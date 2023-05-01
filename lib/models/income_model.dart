import 'package:json_annotation/json_annotation.dart';
part 'income_model.g.dart';

@JsonSerializable()
class IncomeModel {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(includeFromJson: false)
  bool isSelected = false;
  IncomeModel();
  factory IncomeModel.fromJson(Map<String, dynamic> json) =>
      _$IncomeModelFromJson(json);
  Map<String, dynamic> toJson() => _$IncomeModelToJson(this);
}
