import 'package:json_annotation/json_annotation.dart';
import 'package:toiletmap/app/models/direction/route/route.dart';
import 'package:toiletmap/app/models/placeDetail/result/result.dart';

part 'place_detail.g.dart';

@JsonSerializable()
class PlaceDetail {
  Result result;

  PlaceDetail(this.result);

  factory PlaceDetail.fromJson(Map<String, dynamic> json) => _$PlaceDetailFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceDetailToJson(this);
}