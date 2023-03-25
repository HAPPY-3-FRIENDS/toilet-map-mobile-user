import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:toiletmap/app/models/accessToken/access_token.dart';
import 'package:toiletmap/app/models/baseResponse/base_response.dart';
import 'package:toiletmap/app/utils/constants.dart';

class AuthRepository {
  Future<AccessToken?> authPhoneLogin(phone) async {
    final response = await http.post(
        Uri.parse('${AppDomain.appDomain1}/api/auth'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
        },
        body:
        jsonEncode({
          "username": phone,
          "password": null,
        })
    );

    final responseJson = jsonDecode(response.body);
    BaseResponse baseResponse = BaseResponse.fromJson(responseJson);
    if (baseResponse.statusCode == 200) {
      AccessToken accessToken = AccessToken.fromJson(baseResponse.data);
      return accessToken;
    } else {
      return null;
    }
  }

  Future<AccessToken> createUserWithPhone(phone, fullName) async {
    final response = await http.post(
        Uri.parse('${AppDomain.appDomain1}/api/accounts/user'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
        },
        body:
        jsonEncode({
          "username": phone,
          "fullName": fullName,
        })
    );

    final responseJson = jsonDecode(response.body);
    BaseResponse baseResponse = BaseResponse.fromJson(responseJson);
    AccessToken accessToken = AccessToken.fromJson(baseResponse.data);
    return accessToken;
  }
}