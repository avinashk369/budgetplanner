import 'package:json_annotation/json_annotation.dart';
part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionModel {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(
      name:
          "cat_name") // this can be set using model class and same can be accessed using model class as well
  String? catName;
  @JsonKey(name: "amount")
  double? amount;
  @JsonKey(
      name:
          "recurrance") // this can be set using model class and same can be accessed using model class as well
  String? recurrance;
  @JsonKey(
      name:
          "transacion_type") // this can be set using model class and same can be accessed using model class as well
  String? transactionType;
  @JsonKey(name: "created_on")
  String? createdOn;
  @JsonKey(name: "updated_on")
  String? updatedOn;
  @JsonKey(name: "user_id")
  String? userId;
  @JsonKey(name: "expense_source")
  String? expenseSource;
  @JsonKey(name: "expense_type")
  String? expenseType;
  @JsonKey(name: "notes")
  String? notes;
  @JsonKey(name: "is_recurring")
  bool? isRecurring;
  TransactionModel();
  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
}
