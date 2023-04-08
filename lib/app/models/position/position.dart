import 'package:json_annotation/json_annotation.dart';
part 'position.g.dart';

@JsonSerializable()
class Position {
  int id;
  double latitude;
  double longitude;

  Position(this.id, this.latitude, this.longitude);

  factory Position.fromJson(Map<String, dynamic> json) => _$PositionFromJson(json);
  Map<String, dynamic> toJson() => _$PositionToJson(this);
}