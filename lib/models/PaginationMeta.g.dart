// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PaginationMeta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationMeta _$PaginationMetaFromJson(Map<String, dynamic> json) {
  return PaginationMeta()
    ..url = json['url']
    ..label = json['label']
    ..active = json['active'] as bool?;
}

Map<String, dynamic> _$PaginationMetaToJson(PaginationMeta instance) =>
    <String, dynamic>{
      'url': instance.url,
      'label': instance.label,
      'active': instance.active,
    };
