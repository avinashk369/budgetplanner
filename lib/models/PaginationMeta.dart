import 'package:json_annotation/json_annotation.dart';
part 'PaginationMeta.g.dart';

@JsonSerializable()
class PaginationMeta {
  @JsonKey(name: 'url')
  dynamic url;
  @JsonKey(name: 'label')
  dynamic label;
  @JsonKey(name: 'active')
  bool? active;

  PaginationMeta();
  factory PaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$PaginationMetaFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationMetaToJson(this);
}
