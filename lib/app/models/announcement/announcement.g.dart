// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Announcement _$AnnouncementFromJson(Map<String, dynamic> json) => Announcement(
  json['id'] as int,
  json['title'] as String,
  json['url'] as String?,
  json['imageSource'] as String,
  json['startDate'] as String?,
  json['endDate'] as String?,
  json['description'] as String?,
  json['type'] as String,
);

Map<String, dynamic> _$AnnouncementToJson(Announcement instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'url': instance.url,
  'imageSource': instance.imageSource,
  'startDate': instance.startDate,
  'endDate': instance.endDate,
  'description': instance.description,
  'type': instance.type,
};
