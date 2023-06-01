// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Place _$PlaceFromJson(Map<String, dynamic> json) => Place(
  (json['predictions'] as List<dynamic>)
      .map((e) => Prediction.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PlaceToJson(Place instance) => <String, dynamic>{
  'predictions': instance.predictions,
};
