import 'dart:convert';
import 'dart:io';

import 'package:toiletmap/app/repositories/shared_preferences_repository.dart';

import '../models/baseResponse/base_response.dart';
import '../models/toilet/toilet.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class ToiletRepository {
  Future<Toilet?> getToiletByToiletId(int toiletId) async {
    print('toilet by toilet id: ' + toiletId!.toString());
    String? accessToken = await SharedPreferencesRepository().getAccessToken();

    final response = await http.get(
        Uri.parse('${AppDomain.appDomain1}/api/toilets/${toiletId}'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
          HttpHeaders.authorizationHeader: "Bearer ${accessToken}",
        }
    );

    if (response.statusCode == 200) {
      print('hihi toilet info');
      final responseJson = jsonDecode(response.body);
      print(responseJson);
      BaseResponse baseResponse = BaseResponse.fromJson(responseJson);
      print(baseResponse.data);
      Toilet toilet = Toilet.fromJson(baseResponse.data);
      print("toilet info successfully " + toilet.toiletName);
      return toilet;
    } else {
      print("toilet info get failed");
      return null;
    }
  }

  Future<List<Toilet>?> getToiletsNearbyByCurrentLatLong() async {
    List<double?> latlong = await SharedPreferencesRepository().getCurrentLatLong();
    double lat = latlong[0]!;
    double long = latlong[1]!;
    //double lat = 10.848072;
    //double long = 106.793756;
    String? accessToken = await SharedPreferencesRepository().getAccessToken();
    print('Do nearby' + long.toString());

    final response = await http.get(
        Uri.parse('${AppDomain.appDomain1}/api/toilets?current-latitude=${lat}&current-longitude=${long}'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
          HttpHeaders.authorizationHeader: "Bearer ${accessToken}",
        },
    );

    if (response.statusCode == 200) {
      print('hihi toilets info');
      final responseJson = jsonDecode(response.body);
      print(responseJson);
      BaseResponse baseResponse = BaseResponse.fromJson(responseJson);
      print(baseResponse.data);
      List<Toilet> toilets = (baseResponse.data as List).map(
              (i) => Toilet.fromJson(i)).toList();
      print("Toilet length successfully " + toilets.length.toString());
      print("check Toilet 1 element" + toilets[0].toString());
      return toilets;
    }

    if (response.statusCode == 204) {
      List<Toilet> toilets = [];
      print("Toilets list empty");
      return toilets;
    }

    print("Toilets list get failed");
    return null;
  }

  Future<List<Toilet>?> getToiletsNearbyByLatLong(double lat, double long) async {
    String? accessToken = await SharedPreferencesRepository().getAccessToken();
    print('Do nearby' + long.toString());

    final response = await http.get(
      Uri.parse('${AppDomain.appDomain1}/api/toilets?current-latitude=${lat}&current-longitude=${long}'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
        HttpHeaders.authorizationHeader: "Bearer ${accessToken}",
      },
    );

    if (response.statusCode == 200) {
      print('hihi toilets info');
      final responseJson = jsonDecode(response.body);
      print(responseJson);
      BaseResponse baseResponse = BaseResponse.fromJson(responseJson);
      print(baseResponse.data);
      List<Toilet> toilets = (baseResponse.data as List).map(
              (i) => Toilet.fromJson(i)).toList();
      print("Toilet length successfully " + toilets.length.toString());
      print("check Toilet 1 element" + toilets[0].toString());
      return toilets;
    }

    if (response.statusCode == 204) {
      List<Toilet> toilets = [];
      print("Toilets list empty");
      return toilets;
    }

    print("Toilets list get failed");
    return null;
  }

  Future<Toilet?> getNearestToilet() async {
    List<double?> latlong = await SharedPreferencesRepository().getCurrentLatLong();
    double lat = latlong[0]!;
    double long = latlong[1]!;
    String? accessToken = await SharedPreferencesRepository().getAccessToken();
    print('Do nearest' + long.toString());

    final response = await http.get(
      Uri.parse('${AppDomain.appDomain1}/api/toilets/nearest-toilet?current-latitude=${lat}&current-longitude=${long}&vehicle=bike'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
        HttpHeaders.authorizationHeader: "Bearer ${accessToken}",
      },
    );

    if (response.statusCode == 200) {
      print('hihi toilets info');
      final responseJson = jsonDecode(response.body);
      print(responseJson);
      BaseResponse baseResponse = BaseResponse.fromJson(responseJson);
      print(baseResponse.data);
      Toilet toilet = Toilet.fromJson(baseResponse.data);
      return toilet;
    }

    print("Toilets list get failed");
    return null;
  }

  Future<String?> getToiletStatus(int id) async {
    String? accessToken = await SharedPreferencesRepository().getAccessToken();

    final response = await http.get(
      Uri.parse('${AppDomain.appDomain1}/api/toilets/check/${id}'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
        HttpHeaders.authorizationHeader: "Bearer ${accessToken}",
      },
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      BaseResponse baseResponse = BaseResponse.fromJson(responseJson);
      return baseResponse.data;
    }
    return null;
  }

  Future<int?> getToiletWaitTime(int id) async {
    String? accessToken = await SharedPreferencesRepository().getAccessToken();

    final response = await http.get(
      Uri.parse('${AppDomain.appDomain1}/api/toilets/wait/${id}'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
        HttpHeaders.authorizationHeader: "Bearer ${accessToken}",
      },
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      BaseResponse baseResponse = BaseResponse.fromJson(responseJson);
      return baseResponse.data;
    }
    return null;
  }
}