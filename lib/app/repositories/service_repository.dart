import 'dart:convert';
import 'dart:io';

import 'package:toiletmap/app/models/transaction/transaction.dart';
import 'package:toiletmap/app/repositories/shared_preferences_repository.dart';

import '../models/baseResponse/base_response.dart';
import '../models/service/service.dart';
import '../utils/constants.dart';

import 'package:http/http.dart' as http;

class ServiceRepository {
  Future<List<Service>?> getServices() async {
    String? accessToken = await SharedPreferencesRepository().getAccessToken();

    final response = await http.get(
        Uri.parse('${AppDomain.appDomain1}/api/services'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
          HttpHeaders.authorizationHeader: "Bearer ${accessToken}",
        }
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      BaseResponse baseResponse = BaseResponse.fromJson(responseJson);
      print(baseResponse.data);
      List<Service> services = (baseResponse.data as List).map(
              (i) => Service.fromJson(i)).toList();
      return services;
    }

    if (response.statusCode == 204) {
      List<Service> services = [];
      print("Transaction list empty");
      return services;
    }

    print("Transaction get failed");
    return null;
  }

}