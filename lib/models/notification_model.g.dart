// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel()
      ..id = json['id'] as String?
      ..title = json['title'] as String?
      ..desc = json['desc'] as String?
      ..notificationType = json['type'] as String?
      ..imgUrl = json['img_url'] as String?
      ..hasImage = json['has_img'] as bool?
      ..isMorning = json['is_mrng'] as bool?
      ..isEvening = json['is_evng'] as bool?
      ..isHourly = json['is_hrly'] as bool?;

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'desc': instance.desc,
      'type': instance.notificationType,
      'img_url': instance.imgUrl,
      'has_img': instance.hasImage,
      'is_mrng': instance.isMorning,
      'is_evng': instance.isEvening,
      'is_hrly': instance.isHourly,
    };
