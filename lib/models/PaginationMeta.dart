import 'package:json_annotation/json_annotation.dart';
part 'PaginationMeta.g.dart';

@JsonSerializable()
class PaginationMeta {
  @JsonKey(name: 'url')
  late dynamic? url;
  @JsonKey(name: 'label')
  late dynamic? label;
  @JsonKey(name: 'active')
  late bool? active;

  PaginationMeta();
  factory PaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$PaginationMetaFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationMetaToJson(this);
}
