import 'package:json_annotation/json_annotation.dart';
part 'checkin_argument.g.dart';

@JsonSerializable()
class CheckinArgument {
  int accountId;
  String? isAccountTurnNotEnough;

  CheckinArgument(this.accountId, this.isAccountTurnNotEnough);

  factory CheckinArgument.fromJson(Map<String, dynamic> json) => _$CheckinArgumentFromJson(json);
  Map<String, dynamic> toJson() => _$CheckinArgumentToJson(this);
}