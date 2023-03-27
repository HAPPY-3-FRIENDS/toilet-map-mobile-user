import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:toiletmap/app/repositories/shared_preferences_repository.dart';
import 'package:toiletmap/app/utils/constants.dart';
import 'package:http/http.dart' as http;

import '../models/baseResponse/base_response.dart';
import '../models/userInfo/user_info.dart';

class UserInfoRepository {
  Future<UserInfo?> getUserInfo() async {
    int? accountId = await SharedPreferencesRepository().getAccountId();
    String? accessToken = await SharedPreferencesRepository().getAccessToken();
    print('userinfo' + accountId!.toString());

    final response = await http.get(
        Uri.parse('${AppDomain.appDomain1}/api/accounts/${accountId}/user-infos'),
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
      UserInfo userInfo = UserInfo.fromJson(baseResponse.data);
      print("user info successfully " + userInfo.fullName);
      return userInfo;
    } else {
      return null;
    }
  }

  Future<UserInfo?> patchUserInfoChangePaymentMethod() async {
    int? accountId = await SharedPreferencesRepository().getAccountId();
    String? accessToken = await SharedPreferencesRepository().getAccessToken();
    print('userinfo ' + accountId!.toString() + accessToken.toString());

    final response = await http.patch(
        Uri.parse('${AppDomain.appDomain1}/api/accounts/$accountId/user-info'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
          HttpHeaders.authorizationHeader: "Bearer ${accessToken}",
        },
        body:
        jsonEncode({
          "defaultPayment": null,
        })
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      BaseResponse baseResponse = BaseResponse.fromJson(responseJson);
      UserInfo userInfo = UserInfo.fromJson(baseResponse.data);
      print("patch user info successfully " + userInfo.fullName);
      return userInfo;
    } else {
      return null;
    }
  }
}