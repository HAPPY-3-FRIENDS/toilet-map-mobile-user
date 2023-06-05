import 'package:json_annotation/json_annotation.dart';
part 'announcement.g.dart';

@JsonSerializable()
class Announcement {
  int id;
  String title;
  String? url;
  String imageSource;
  String? startDate;
  String? endDate;
  String? description;
  String type;

  Announcement(this.id, this.title, this.url, this.imageSource, this.startDate, this.endDate, this.description, this.type);

  factory Announcement.fromJson(Map<String, dynamic> json) => _$AnnouncementFromJson(json);
  Map<String, dynamic> toJson() => _$AnnouncementToJson(this);
}