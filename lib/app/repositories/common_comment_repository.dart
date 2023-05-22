import 'dart:convert';
import 'dart:io';

import 'package:toiletmap/app/models/commonComment/common_comment.dart';
import 'package:toiletmap/app/repositories/shared_preferences_repository.dart';

import '../models/baseResponse/base_response.dart';
import '../utils/constants.dart';

import 'package:http/http.dart' as http;

class CommonCommentRepository {
  Future<List<CommonComment>?> getCommonComments() async {
    String? accessToken = await SharedPreferencesRepository().getAccessToken();

    final response = await http.get(
        Uri.parse('${AppDomain.appDomain1}/api/common-comments'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
          HttpHeaders.authorizationHeader: "Bearer ${accessToken}",
        }
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      BaseResponse baseResponse = BaseResponse.fromJson(responseJson);
      print(baseResponse.data);
      List<CommonComment> comments = (baseResponse.data as List).map(
              (i) => CommonComment.fromJson(i)).toList();
      return comments;
    }

    if (response.statusCode == 204) {
      List<CommonComment> comments = [];
      print(" list empty");
      return comments;
    }

    print(" get failed");
    return null;
  }

}