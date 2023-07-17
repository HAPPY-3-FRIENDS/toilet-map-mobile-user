import 'package:json_annotation/json_annotation.dart';
part 'vnpay_response.g.dart';

@JsonSerializable()
class VNPayResponse {
  String paymentUrl;

  VNPayResponse(this.paymentUrl);

  factory VNPayResponse.fromJson(Map<String, dynamic> json) => _$VNPayResponseFromJson(json);
  Map<String, dynamic> toJson() => _$VNPayResponseToJson(this);
}