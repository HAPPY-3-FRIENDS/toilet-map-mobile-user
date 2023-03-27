// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      json['accountId'] as int,
      json['fullName'] as String,
      json['gmail'] as String?,
      json['avatar'] as String?,
      json['defaultPayment'] as String,
      json['accountBalance'] as int,
      json['accountTurn'] as int,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'accountId': instance.accountId,
      'fullName': instance.fullName,
      'gmail': instance.gmail,
      'avatar': instance.avatar,
      'defaultPayment': instance.defaultPayment,
      'accountBalance': instance.accountBalance,
      'accountTurn': instance.accountTurn,
    };
