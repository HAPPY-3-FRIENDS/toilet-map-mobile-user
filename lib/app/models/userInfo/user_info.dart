import 'package:json_annotation/json_annotation.dart';
part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {
  int accountId;
  String fullName;
  String? gmail;
  String? avatar;
  String defaultPayment;
  int accountBalance;
  int accountTurn;

  UserInfo(this.accountId, this.fullName, this.gmail, this.avatar, this.defaultPayment, this.accountBalance, this.accountTurn);

  factory UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}