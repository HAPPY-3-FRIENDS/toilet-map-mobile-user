// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      json['accountId'] as int,
      json['total'] as int,
      json['method'] as String,
      json['createdDate'] as String,
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'accountId': instance.accountId,
      'total': instance.total,
      'method': instance.method,
      'createdDate': instance.createdDate,
    };
