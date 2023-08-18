// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkin_argument.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckinArgument _$CheckinArgumentFromJson(Map<String, dynamic> json) => CheckinArgument(
  json['accountId'] as int,
  json['isAccountTurnNotEnough'] as String?,
);

Map<String, dynamic> _$CheckinArgumentToJson(CheckinArgument instance) => <String, dynamic>{
  'accountId': instance.accountId,
  'isAccountTurnNotEnough': instance.isAccountTurnNotEnough
};
