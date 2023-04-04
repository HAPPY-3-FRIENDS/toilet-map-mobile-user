import 'package:json_annotation/json_annotation.dart';
part 'durations.g.dart';

@JsonSerializable()
class Durations {
  String text;
  int value;

  Durations(this.text, this.value);

  factory Durations.fromJson(Map<String, dynamic> json) => _$DurationsFromJson(json);
  Map<String, dynamic> toJson() => _$DurationsToJson(this);
}