// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rating _$RatingFromJson(Map<String, dynamic> json) => Rating(
  json['id'] as int,
  json['fullName'] as String,
  json['star'] as int,
  json['comment'] as String,
  json['dateTime'] as String,
  (json['imageSources'] as List<dynamic>?)
      ?.map((e) => e as String?)
      ?.toList(),
);

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
  'id': instance.id,
  'fullName': instance.fullName,
  'star': instance.star,
  'comment': instance.comment,
  'dateTime': instance.dateTime,
  'imageSources': instance.imageSources,
};
