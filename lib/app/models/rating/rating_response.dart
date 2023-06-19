import 'package:json_annotation/json_annotation.dart';
part 'rating_response.g.dart';

@JsonSerializable()
class RatingResponse {
  int id;
  String fullName;
  int star;
  String comment;
  String dateTime;
  List<String?>? imageSources;
  String? avatar;
  List<String?>? commonComments;


  RatingResponse(this.id, this.fullName, this.star, this.comment, this.dateTime, this.imageSources, this.avatar, this.commonComments);

  factory RatingResponse.fromJson(Map<String, dynamic> json) => _$RatingResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RatingResponseToJson(this);
}