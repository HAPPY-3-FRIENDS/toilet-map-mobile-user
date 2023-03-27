// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      json['totalTurn'] as int,
      json['totalPrice'] as int,
      json['paymentMethod'] as String,
      json['dateTime'] as String,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'totalTurn': instance.totalTurn,
      'totalPrice': instance.totalPrice,
      'paymentMethod': instance.paymentMethod,
      'dateTime': instance.dateTime,
    };
