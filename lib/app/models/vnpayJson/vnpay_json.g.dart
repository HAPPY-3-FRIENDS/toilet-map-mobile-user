// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vnpay_json.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VNPayJson _$VNPayJsonFromJson(Map<String, dynamic> json) => VNPayJson(
  json['message'] as String,
  json['status'] as int,
  VNPayJsonData.fromJson(
      json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$VNPayJsonToJson(VNPayJson instance) => <String, dynamic>{
  'message': instance.message,
  'status': instance.status,
  'data': instance.data,
};
