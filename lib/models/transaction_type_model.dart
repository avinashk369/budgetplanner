import 'package:json_annotation/json_annotation.dart';
part 'transaction_type_model.g.dart';

@JsonSerializable()
class TransactionType {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  TransactionType();
  factory TransactionType.fromJson(Map<String, dynamic> json) =>
      _$TransactionTypeFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionTypeToJson(this);
}
