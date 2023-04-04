import 'package:json_annotation/json_annotation.dart';

import 'distance/distance.dart';
import 'duration/durations.dart';
part 'leg.g.dart';

@JsonSerializable()
class Leg {
  Distance distance;
  Durations duration;

  Leg(this.distance, this.duration);

  factory Leg.fromJson(Map<String, dynamic> json) => _$LegFromJson(json);
  Map<String, dynamic> toJson() => _$LegToJson(this);
}