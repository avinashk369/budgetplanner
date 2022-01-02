import 'package:budgetplanner/models/address.dart';
import 'package:json_annotation/json_annotation.dart';

import 'PaginationMeta.dart';
part 'CaffairModel.g.dart';

@JsonSerializable()
class CaffairModel {
  @JsonKey(name: 'id')
  late int? id;
  @JsonKey(name: 'title')
  late String? title;
  @JsonKey(name: 'description')
  late String? description;
  @JsonKey(name: 'ca_url')
  late String? caUrl;
  @JsonKey(name: 'cat_id')
  late String? catId;
  @JsonKey(name: 'published_date')
  late String? publishedDate;
  @JsonKey(name: 'flags')
  late String? flags;
  @JsonKey(name: 'created_at')
  late String? createdAt;
  @JsonKey(name: 'updated_at')
  late String? updatedAt;
  @JsonKey(name: 'current_page')
  late int? currentPage;
  @JsonKey(name: 'data')
  late List<CaffairModel>? data;
  @JsonKey(name: 'first_page_url')
  late String? firstPageUrl;
  @JsonKey(name: 'from')
  late int? from;
  @JsonKey(name: 'last_page')
  late int? lastPage;
  @JsonKey(name: 'last_page_url')
  late String? lastPageUrl;
  @JsonKey(name: 'links')
  late List<PaginationMeta>? links;
  @JsonKey(name: 'next_page_url')
  late String? nextPageUrl;
  @JsonKey(name: 'path')
  late String? path;
  @JsonKey(name: 'per_page')
  late int? perPage;
  @JsonKey(name: 'prev_page_url')
  late String? prevPageUrl;
  @JsonKey(name: 'to')
  late int? to;
  @JsonKey(name: 'total')
  late int? total;
  @JsonKey(name: "address")
  Address? address;

  CaffairModel();
  factory CaffairModel.fromJson(Map<String, dynamic> json) =>
      _$CaffairModelFromJson(json);
  Map<String, dynamic> toJson() => _$CaffairModelToJson(this);
}
