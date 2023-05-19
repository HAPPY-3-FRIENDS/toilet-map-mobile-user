import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toiletmap/app/models/accessToken/access_token.dart';
import 'package:toiletmap/app/models/baseResponse/base_response.dart';
import 'package:toiletmap/app/repositories/shared_preferences_repository.dart';
import 'package:toiletmap/app/utils/constants.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../models/jwt/jwt.dart';

class AuthRepository {
  Future<AccessToken?> authPhoneLogin() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final phone = sharedPreferences.getString("username");

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
    if(response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      BaseResponse baseResponse = BaseResponse.fromJson(responseJson);
      AccessToken accessToken = AccessToken.fromJson(baseResponse.data);
      decodeJWT(accessToken.accessToken);
      print("auth successfully");
      return accessToken;
    } else {
      print('ko thanh cong');
      return null;
    }
  }

  Future<AccessToken> createUserWithPhone(fullName) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final phone = sharedPreferences.getString("username");

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
    decodeJWT(accessToken.accessToken);
    return accessToken;
  }

  Future<AccessToken?> changePhone(String phone) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = await SharedPreferencesRepository().getAccessToken();
    final accountId = sharedPreferences.getInt('accountId');

    final response = await http.patch(
        Uri.parse('${AppDomain.appDomain1}/api/accounts/${accountId}'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
          HttpHeaders.authorizationHeader: "Bearer ${accessToken}",
        },
        body:
        jsonEncode({
          "username": phone,
        })
    );
    if(response.statusCode == 200) {
      print("change phone successfully");
      sharedPreferences.setString("username", phone);
      return await authPhoneLogin();
    } else {
      print('ko thanh cong');
      return null;
    }
  }

  Future decodeJWT(String accessToken) async {
    Map<String, dynamic> load = Jwt.parseJwt(accessToken);
    JWT jwt = JWT.fromJson(load);

    print('decode done' + jwt.username + jwt.sub);

    print("sub " + jwt.sub);
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("accessToken", accessToken);
    sharedPreferences.setInt("accountId", (int.parse(jwt.sub)));
  }
}