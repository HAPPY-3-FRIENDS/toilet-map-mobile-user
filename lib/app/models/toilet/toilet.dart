import 'package:json_annotation/json_annotation.dart';
import 'package:toiletmap/app/models/toilet/toiletFacilities/toiletFacilities.dart';

part 'toilet.g.dart';

@JsonSerializable()
class Toilet {
  int id;
  String toiletName;
  String address;
  String ward;
  String district;
  String province;
  double latitude;
  double longitude;
  String? nearBy;
  String openTime;
  String closeTime;
  int minPrice;
  int maxPrice;
  List<ToiletFacilities> toiletFacilities;
  List<String> toiletImageSources;
  double ratingStar;
  bool free;
  String? duration;
  String? distance;

  Toilet(this.id, this.toiletName, this.address, this.ward, this.district, this.province,
      this.latitude, this.longitude, this.nearBy, this.openTime, this.closeTime,
      this.minPrice, this.maxPrice, this.toiletFacilities, this.toiletImageSources,
      this.ratingStar, this.free, this.duration, this.distance);

  factory Toilet.fromJson(Map<String, dynamic> json) => _$ToiletFromJson(json);
  Map<String, dynamic> toJson() => _$ToiletToJson(this);
}

