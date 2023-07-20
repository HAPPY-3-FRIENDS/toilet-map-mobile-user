// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vnpay_json_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VNPayJsonData _$VNPayJsonDataFromJson(Map<String, dynamic> json) => VNPayJsonData(
  json['accountId'] as int,
  json['total'] as int,
  json['method'] as String,
  json['createdDate'] as String,
);

Map<String, dynamic> _$VNPayJsonDataToJson(VNPayJsonData instance) => <String, dynamic>{
  'accountId': instance.accountId,
  'total': instance.total,
  'method': instance.method,
  'createdDate': instance.createdDate,
};
