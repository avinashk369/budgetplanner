import 'package:json_annotation/json_annotation.dart';
part 'saving_category.g.dart';

@JsonSerializable()
class SavingCategory {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  SavingCategory();

  factory SavingCategory.fromJson(Map<String, dynamic> json) =>
      _$SavingCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$SavingCategoryToJson(this);
}
