import 'package:json_annotation/json_annotation.dart';
part 'recurrance_model.g.dart';

@JsonSerializable()
class RecurranceModel {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  RecurranceModel();

  factory RecurranceModel.fromJson(Map<String, dynamic> json) =>
      _$RecurranceModelFromJson(json);
  Map<String, dynamic> toJson() => _$RecurranceModelToJson(this);
}
