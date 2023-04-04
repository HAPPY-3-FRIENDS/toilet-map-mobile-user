import 'package:json_annotation/json_annotation.dart';
import 'package:toiletmap/app/models/direction/route/route.dart';

part 'direction.g.dart';

@JsonSerializable()
class Direction {
  List<Route> routes;

  Direction(this.routes);

  factory Direction.fromJson(Map<String, dynamic> json) => _$DirectionFromJson(json);
  Map<String, dynamic> toJson() => _$DirectionToJson(this);
}