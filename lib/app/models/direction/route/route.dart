import 'package:json_annotation/json_annotation.dart';

import 'leg/leg.dart';
import 'overview_polyline/overview_polyline.dart';
part 'route.g.dart';

@JsonSerializable()
class Route {
  List<Leg> legs;
  OverviewPolyline overview_polyline;

  Route(this.legs, this.overview_polyline);

  factory Route.fromJson(Map<String, dynamic> json) => _$RouteFromJson(json);
  Map<String, dynamic> toJson() => _$RouteToJson(this);
}