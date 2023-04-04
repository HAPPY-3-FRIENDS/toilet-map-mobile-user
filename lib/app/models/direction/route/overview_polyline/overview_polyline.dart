import 'package:json_annotation/json_annotation.dart';
part 'overview_polyline.g.dart';

@JsonSerializable()
class OverviewPolyline {
  String points;

  OverviewPolyline(this.points);

  factory OverviewPolyline.fromJson(Map<String, dynamic> json) => _$OverviewPolylineFromJson(json);
  Map<String, dynamic> toJson() => _$OverviewPolylineToJson(this);
}