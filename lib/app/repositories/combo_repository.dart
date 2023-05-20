import 'dart:convert';
import 'dart:io';

import 'package:toiletmap/app/repositories/shared_preferences_repository.dart';

import '../models/baseResponse/base_response.dart';
import '../models/combo/combo.dart';
import '../utils/constants.dart';

import 'package:http/http.dart' as http;

class ComboRepository {
  Future<List<Combo>?> getCombos() async {
    String? accessToken = await SharedPreferencesRepository().getAccessToken();

    final response = await http.get(
        Uri.parse('${AppDomain.appDomain1}/api/combos'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
          HttpHeaders.authorizationHeader: "Bearer ${accessToken}",
        }
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      BaseResponse baseResponse = BaseResponse.fromJson(responseJson);
      print(baseResponse.data);
      List<Combo> combos = (baseResponse.data as List).map(
              (i) => Combo.fromJson(i)).toList();
      return combos;
    }

    if (response.statusCode == 204) {
      List<Combo> combos = [];
      print(" list empty");
      return combos;
    }

    print(" get failed");
    return null;
  }

}