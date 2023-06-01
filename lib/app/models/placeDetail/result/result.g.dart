// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
  Geometry.fromJson(
      json['geometry'] as Map<String, dynamic>),
  json['name'] as String,
  json['formatted_address'] as String,
);

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
  'geometry': instance.geometry,
  'name': instance.name,
  'formatted_address': instance.formatted_address,
};
