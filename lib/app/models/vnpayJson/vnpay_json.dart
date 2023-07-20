import 'package:json_annotation/json_annotation.dart';
import 'package:toiletmap/app/models/vnpayJson/vnpay_json_data/vnpay_json_data.dart';
part 'vnpay_json.g.dart';

@JsonSerializable()
class VNPayJson {
  String message;
  int status;
  VNPayJsonData data;

  VNPayJson(this.message, this.status, this.data);

  factory VNPayJson.fromJson(Map<String, dynamic> json) => _$VNPayJsonFromJson(json);
  Map<String, dynamic> toJson() => _$VNPayJsonToJson(this);
}