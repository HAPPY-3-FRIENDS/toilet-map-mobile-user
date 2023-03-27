import 'package:json_annotation/json_annotation.dart';
part 'order.g.dart';

@JsonSerializable()
class Order {
  int totalTurn;
  int totalPrice;
  String paymentMethod;
  String dateTime;

  Order(this.totalTurn, this.totalPrice, this.paymentMethod, this.dateTime);

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}