// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Checkin _$CheckinFromJson(Map<String, dynamic> json) => Checkin(
      json['toiletId'] as int,
      json['toiletName'] as String,
      json['dateTime'] as String?,
      json['serviceName'] as String,
      json['balance'] as int?,
      json['turn'] as int?,
      json['id'] as int,
      json['status'] as String?,
    );

Map<String, dynamic> _$CheckinToJson(Checkin instance) => <String, dynamic>{
      'toiletId': instance.toiletId,
      'toiletName': instance.toiletName,
      'dateTime': instance.dateTime,
      'serviceName': instance.serviceName,
      'balance': instance.balance,
      'turn': instance.turn,
      'id': instance.id,
      'status': instance.status
    };
