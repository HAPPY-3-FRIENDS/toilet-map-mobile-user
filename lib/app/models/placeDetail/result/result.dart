import 'package:json_annotation/json_annotation.dart';
import 'package:toiletmap/app/models/placeDetail/result/geometry/geometry.dart';
part 'result.g.dart';

@JsonSerializable()
class Result {
  Geometry geometry;
  String name;
  String formatted_address;


  Result(this.geometry, this.name, this.formatted_address);

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
  Map<String, dynamic> toJson() => _$ResultToJson(this);
}