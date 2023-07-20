import 'package:json_annotation/json_annotation.dart';
part 'vnpay_json_data.g.dart';

@JsonSerializable()
class VNPayJsonData {
  int accountId;
  int total;
  String method;
  String createdDate;

  VNPayJsonData(this.accountId, this.total, this.method, this.createdDate);

  factory VNPayJsonData.fromJson(Map<String, dynamic> json) => _$VNPayJsonDataFromJson(json);
  Map<String, dynamic> toJson() => _$VNPayJsonDataToJson(this);
}