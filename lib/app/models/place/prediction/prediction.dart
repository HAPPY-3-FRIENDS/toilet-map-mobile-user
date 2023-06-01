import 'package:json_annotation/json_annotation.dart';
import 'package:toiletmap/app/models/direction/route/route.dart';

part 'prediction.g.dart';

@JsonSerializable()
class Prediction {
  String description;
  String place_id;

  Prediction(this.description, this.place_id);

  factory Prediction.fromJson(Map<String, dynamic> json) => _$PredictionFromJson(json);
  Map<String, dynamic> toJson() => _$PredictionToJson(this);
}