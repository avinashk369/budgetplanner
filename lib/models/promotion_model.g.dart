// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromotionModel _$PromotionModelFromJson(Map<String, dynamic> json) =>
    PromotionModel()
      ..id = json['id'] as String?
      ..imgUrl = json['img_url'] as String?
      ..srcUrl = json['src_url'] as String?
      ..title = json['title'] as String?
      ..sq = json['sq'] as int?;

Map<String, dynamic> _$PromotionModelToJson(PromotionModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('img_url', instance.imgUrl);
  writeNotNull('src_url', instance.srcUrl);
  writeNotNull('title', instance.title);
  writeNotNull('sq', instance.sq);
  return val;
}
