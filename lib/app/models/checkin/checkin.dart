import 'package:json_annotation/json_annotation.dart';
part 'checkin.g.dart';

@JsonSerializable()
class Checkin {
  int toiletId;
  String toiletName;
  String? dateTime;
  String serviceName;
  int? balance;
  int? turn;
  int id;
  String? status;
  String username;
/*
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? fullName;

  @JsonKey(includeFromJson: false, includeToJson: false)
  String? paymentMethod;
*/



  Checkin(this.toiletId, this.toiletName, this.dateTime, this.serviceName, this.balance, this.turn, this.id, this.status, this.username);

  factory Checkin.fromJson(Map<String, dynamic> json) => _$CheckinFromJson(json);
  Map<String, dynamic> toJson() => _$CheckinToJson(this);
}