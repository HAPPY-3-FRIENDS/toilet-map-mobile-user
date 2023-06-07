import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:toiletmap/app/models/direction/direction.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:toiletmap/app/repositories/shared_preferences_repository.dart';
import 'package:toiletmap/app/utils/constants.dart';

import '../models/baseResponse/base_response.dart';
import '../models/direction/route/route.dart';
import '../models/position/position.dart';


class MapRepository {
  Future<List<List<num>>?> getDirection(double firstLat, double firstLong, double secondLat, double secondLong) async {
    final response = await http.get(
        Uri.parse('https://rsapi.goong.io/Direction?origin=${firstLat.toString()},${firstLong.toString()}&destination=${secondLat.toString()},${secondLong.toString()}&vehicle=car&api_key=${AppDomain.apiKey}'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
        }
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      Direction direction = Direction.fromJson(responseJson);
      Route route = direction.routes[0];

      List<List<num>> decodedPolyline = decodePolyline(route.overview_polyline.points);
      List<List<num>> reversePolyline = [];
      decodedPolyline.forEach((element) {
        reversePolyline.add(element.reversed.toList());
      });
      print('get Direction true true true');
      return reversePolyline;
    }
  }

  Future<List<Position>?> getAllPosition() async {
    String? accessToken = await SharedPreferencesRepository().getAccessToken();
    final response = await http.get(
        Uri.parse('${AppDomain.appDomain1}/api/toilets'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
          HttpHeaders.authorizationHeader: "Bearer ${accessToken}",
        }
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      BaseResponse baseResponse = BaseResponse.fromJson(responseJson);
      List<Position> positions = (baseResponse.data as List).map(
              (i) => Position.fromJson(i)).toList();
      return positions;
    }
  }

}