import 'package:json_annotation/json_annotation.dart';
part 'combo.g.dart';

@JsonSerializable()
class Combo {
  int id;
  int totalTurn;
  int price;

  Combo(this.id, this.totalTurn, this.price);

  factory Combo.fromJson(Map<String, dynamic> json) => _$ComboFromJson(json);
  Map<String, dynamic> toJson() => _$ComboToJson(this);
}