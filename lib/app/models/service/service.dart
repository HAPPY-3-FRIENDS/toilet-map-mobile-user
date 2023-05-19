import 'package:json_annotation/json_annotation.dart';
part 'service.g.dart';

@JsonSerializable()
class Service {
  int id;
  String name;
  int price;
  int turn;

  Service(this.id, this.name, this.price, this.turn);

  factory Service.fromJson(Map<String, dynamic> json) => _$ServiceFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}