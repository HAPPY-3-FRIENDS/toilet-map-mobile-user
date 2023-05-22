import 'package:json_annotation/json_annotation.dart';
part 'common_comment.g.dart';

@JsonSerializable()
class CommonComment {
  int id;
  String name;
  String status;

  CommonComment(this.id, this.name, this.status);

  factory CommonComment.fromJson(Map<String, dynamic> json) => _$CommonCommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommonCommentToJson(this);
}