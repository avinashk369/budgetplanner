import 'package:json_annotation/json_annotation.dart';
part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "desc")
  String? desc;
  @JsonKey(name: "type")
  String? notificationType;
  @JsonKey(name: "img_url")
  String? imgUrl;
  @JsonKey(name: "has_img")
  bool? hasImage = false;
  @JsonKey(name: "is_mrng")
  bool? isMorning = false;
  @JsonKey(name: "is_evng")
  bool? isEvening = false;
  @JsonKey(name: "is_hrly")
  bool? isHourly = false;

  NotificationModel();
  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
