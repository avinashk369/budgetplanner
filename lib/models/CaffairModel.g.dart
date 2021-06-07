// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CaffairModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaffairModel _$CaffairModelFromJson(Map<String, dynamic> json) {
  return CaffairModel()
    ..id = json['id'] as int?
    ..title = json['title'] as String?
    ..description = json['description'] as String?
    ..caUrl = json['ca_url'] as String?
    ..catId = json['cat_id'] as String?
    ..publishedDate = json['published_date'] as String?
    ..flags = json['flags'] as String?
    ..createdAt = json['created_at'] as String?
    ..updatedAt = json['updated_at'] as String?
    ..currentPage = json['current_page'] as int?
    ..data = (json['data'] as List<dynamic>?)
        ?.map((e) => CaffairModel.fromJson(e as Map<String, dynamic>))
        .toList()
    ..firstPageUrl = json['first_page_url'] as String?
    ..from = json['from'] as int?
    ..lastPage = json['last_page'] as int?
    ..lastPageUrl = json['last_page_url'] as String?
    ..links = (json['links'] as List<dynamic>?)
        ?.map((e) => PaginationMeta.fromJson(e as Map<String, dynamic>))
        .toList()
    ..nextPageUrl = json['next_page_url'] as String?
    ..path = json['path'] as String?
    ..perPage = json['per_page'] as int?
    ..prevPageUrl = json['prev_page_url'] as String?
    ..to = json['to'] as int?
    ..total = json['total'] as int?;
}

Map<String, dynamic> _$CaffairModelToJson(CaffairModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'ca_url': instance.caUrl,
      'cat_id': instance.catId,
      'published_date': instance.publishedDate,
      'flags': instance.flags,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'current_page': instance.currentPage,
      'data': instance.data,
      'first_page_url': instance.firstPageUrl,
      'from': instance.from,
      'last_page': instance.lastPage,
      'last_page_url': instance.lastPageUrl,
      'links': instance.links,
      'next_page_url': instance.nextPageUrl,
      'path': instance.path,
      'per_page': instance.perPage,
      'prev_page_url': instance.prevPageUrl,
      'to': instance.to,
      'total': instance.total,
    };
