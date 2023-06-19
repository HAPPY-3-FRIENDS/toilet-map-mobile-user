// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingResponse _$RatingResponseFromJson(Map<String, dynamic> json) => RatingResponse(
  json['id'] as int,
  json['fullName'] as String,
  json['star'] as int,
  json['comment'] as String,
  json['dateTime'] as String,
  (json['imageSources'] as List<dynamic>?)
      ?.map((e) => e as String?)
      ?.toList(),
  json['avatar'] as String?,
  (json['commonComments'] as List<dynamic>?)
      ?.map((e) => e as String?)
      ?.toList(),
);

Map<String, dynamic> _$RatingResponseToJson(RatingResponse instance) => <String, dynamic>{
  'id': instance.id,
  'fullName': instance.fullName,
  'star': instance.star,
  'comment': instance.comment,
  'dateTime': instance.dateTime,
  'imageSources': instance.imageSources,
  'avatar': instance.avatar,
  'commonComments': instance.commonComments,
};
