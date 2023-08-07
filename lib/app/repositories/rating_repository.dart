import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:toiletmap/app/repositories/shared_preferences_repository.dart';

import '../models/baseResponse/base_response.dart';
import '../models/rating/rating.dart';
import '../models/rating/rating_response.dart';
import '../utils/constants.dart';

class RatingRepository {
  Future<List<RatingResponse>?> getRatingsByToiletId(int id, int page, int star) async {
    String? accessToken = await SharedPreferencesRepository().getAccessToken();

    final response;
    if (star == 0) {
      response = await http.get(
          Uri.parse('${AppDomain.appDomain1}/api/ratings?toilet-id=${id}&pageIndex=${page}&pageSize=10'),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
            HttpHeaders.authorizationHeader: "Bearer ${accessToken}",
          }
      );
    } else {
      response = await http.get(
          Uri.parse('${AppDomain.appDomain1}/api/ratings/filter-rating-by-star?toilet-id=${id}&star=${star}&pageIndex=${page}&pageSize=10'),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
            HttpHeaders.authorizationHeader: "Bearer ${accessToken}",
          }
      );
    }


    if (response.statusCode == 200) {
      print('hihi');
      final responseJson = jsonDecode(response.body);
      print(responseJson);
      BaseResponse baseResponse = BaseResponse.fromJson(responseJson);
      List<RatingResponse> ratings = (baseResponse.data as List).map(
              (i) => RatingResponse.fromJson(i)).toList();
      print("Rating successfully 2");
      print("Rating successfully " + ratings[0].toString());
      return ratings;
    }

    if (response.statusCode == 204) {
      List<RatingResponse> ratings = [];
      print("Rating list empty");
      return ratings;
    }

    print("Rating get failed");
    return null;
  }

  Future<int?> countRatingsByToiletId(int id) async {
    String? accessToken = await SharedPreferencesRepository().getAccessToken();
    print('rating count start');

    final response = await http.get(
        Uri.parse('${AppDomain.appDomain1}/api/ratings/count?toilet-id=${id}'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
          HttpHeaders.authorizationHeader: "Bearer ${accessToken}",
        }
    );

    if (response.statusCode == 200) {
      print('hihi');
      final responseJson = jsonDecode(response.body);
      print(responseJson);
      BaseResponse baseResponse = BaseResponse.fromJson(responseJson);
      print(baseResponse.data);
      print("count successfully ");
      return baseResponse.data;
    }

    print("get failed");
    return null;
  }

  Future<Rating?> postRating(toiletId, star, comment, checkInId, imageSources, ratingCommonComments) async {
    int? accountId = await SharedPreferencesRepository().getAccountId();
    String? accessToken = await SharedPreferencesRepository().getAccessToken();

    var response = await http.post(
        Uri.parse("${AppDomain.appDomain1}/api/ratings"),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
          HttpHeaders.authorizationHeader: "Bearer ${accessToken}",
        },
        body:
        jsonEncode({
          "toiletId": toiletId,
          "star": star,
          "comment": comment,
          "accountId": accountId,
          "checkInId": checkInId,
          "imageSources": imageSources,
          "commonComments": ratingCommonComments,
        })
    );
    print('response ne: ' + response.body);
    if (response.statusCode == 201) {
      print('checkin successfully');
      final responseJson = jsonDecode(response.body);
      BaseResponse baseResponse = BaseResponse.fromJson(responseJson);
      Rating rating = Rating.fromJson(baseResponse.data);
      return rating;
    } else {
    }
  }
}