import 'package:json_annotation/json_annotation.dart';
part 'transaction.g.dart';

@JsonSerializable()
class Transaction {
  int accountId;
  int total;
  String method;
  String createdDate;

  Transaction(this.accountId, this.total, this.method, this.createdDate);

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}