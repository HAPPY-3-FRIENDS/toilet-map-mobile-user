
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:toiletmap/app/repositories/shared_preferences_repository.dart';
import 'package:toiletmap/app/utils/constants.dart';

import '../models/place/place.dart';
import '../models/placeDetail/place_detail.dart';


class ReportRepository {
  Future<String?> postLocationReport(toiletId, message) async {
    String? accessToken = await SharedPreferencesRepository().getAccessToken();

    var response = await http.post(
        Uri.parse("${AppDomain.appDomain1}/api/reports"),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
          HttpHeaders.authorizationHeader: "Bearer ${accessToken}",
        },
        body:
        jsonEncode({
          "toiletId": toiletId,
          "message": message,
        })
    );
    print('response ne: ' + response.body);
    if (response.statusCode == 201) {
      print('checkin successfully');
      return 'ok';
    } else {
      return null;
    }
  }
}