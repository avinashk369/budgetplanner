import 'package:json_annotation/json_annotation.dart';
part 'promotion_model.g.dart';

@JsonSerializable(includeIfNull: false)
class PromotionModel {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "img_url")
  String? imgUrl;
  @JsonKey(name: "src_url")
  String? srcUrl;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "sq")
  int? sq;
  PromotionModel();
  factory PromotionModel.fromJson(Map<String, dynamic> json) =>
      _$PromotionModelFromJson(json);
  Map<String, dynamic> toJson() => _$PromotionModelToJson(this);
}
