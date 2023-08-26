import 'package:json_annotation/json_annotation.dart';
part 'configuration.g.dart';

@JsonSerializable()
class Configurationn {
  String id;
  int value;

  Configurationn(this.id, this.value);

  factory Configurationn.fromJson(Map<String, dynamic> json) => _$ConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$ConfigurationToJson(this);
}