import 'package:json_annotation/json_annotation.dart';
part 'rating.g.dart';

@JsonSerializable()
class Rating {
  int id;
  String fullName;
  int star;
  String comment;
  String dateTime;
  List<String?>? imageSources;


  Rating(this.id, this.fullName, this.star, this.comment, this.dateTime, this.imageSources);

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);
  Map<String, dynamic> toJson() => _$RatingToJson(this);
}