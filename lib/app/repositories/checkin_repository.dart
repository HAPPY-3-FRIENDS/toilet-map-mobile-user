import 'dart:convert';
import 'dart:io';

import 'package:toiletmap/app/repositories/shared_preferences_repository.dart';

import '../models/baseResponse/base_response.dart';
import '../models/checkin/checkin.dart';

import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class CheckinRepository {
  Future<List<Checkin>?> getCheckinsByAccountId() async {
    int? accountId = await SharedPreferencesRepository().getAccountId();
    String? accessToken = await SharedPreferencesRepository().getAccessToken();
    print('checkin get start' + accountId!.toString());

    final response = await http.get(
        Uri.parse('${AppDomain.appDomain1}/api/check-in?account-id=${accountId}'),
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
      List<Checkin> checkins = (baseResponse.data as List).map(
          (i) => Checkin.fromJson(i)).toList();
      print("checkins successfully " + checkins.toString());
      print("check checkins 1 element" + checkins[0].toString());
      return checkins;
    }

    if (response.statusCode == 204) {
      List<Checkin> checkins = [];
      print("checkin list empty");
      return checkins;
    }

    print("checkins get failed");
    return null;
  }
}