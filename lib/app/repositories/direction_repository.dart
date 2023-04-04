import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:toiletmap/app/models/direction/direction.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';

import '../models/direction/route/route.dart';


class DirectionRepository {

  Future<List<List<num>>?> getDirection(double firstLat, double firstLong, double secondLat, double secondLong) async {

    final response = await http.get(
        Uri.parse('https://rsapi.goong.io/Direction?origin=${firstLat.toString()},${firstLong.toString()}&destination=${secondLat.toString()},${secondLong.toString()}&vehicle=car&api_key=ZXrUvqdTcl9AYCA8ZRbSoCqscAev0tBcFvpCS3QQ'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
        }
    );

    if (response.statusCode == 200) {
      print('direction');
      final responseJson = jsonDecode(response.body);
      Direction direction = Direction.fromJson(responseJson);
      Route route = direction.routes[0];

      List<List<num>> decodedPolyline = decodePolyline(route.overview_polyline.points);
      print('before reverse: ' + decodedPolyline[0].toString());
      List<List<num>> reversePolyline = [];
      decodedPolyline.forEach((element) {
        reversePolyline.add(element.reversed.toList());
      });
      print('after reverse: ' + reversePolyline[0].toString());
      print("Polyline: " + reversePolyline.toString());
      return reversePolyline;
    }
  }



}