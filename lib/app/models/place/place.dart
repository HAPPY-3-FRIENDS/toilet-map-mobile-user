import 'package:json_annotation/json_annotation.dart';
import 'package:toiletmap/app/models/direction/route/route.dart';
import 'package:toiletmap/app/models/place/prediction/prediction.dart';

part 'place.g.dart';

@JsonSerializable()
class Place {
  List<Prediction> predictions;

  Place(this.predictions);

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceToJson(this);
}