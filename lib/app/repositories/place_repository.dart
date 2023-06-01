
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:toiletmap/app/utils/constants.dart';

import '../models/place/place.dart';
import '../models/placeDetail/place_detail.dart';


class PlaceRepository {
  Future<Place?> getPlace(String input) async {
    final response = await http.get(
        Uri.parse('https://rsapi.goong.io/Place/AutoComplete?api_key=${AppDomain.apiKey}&input=${input}'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
        }
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      Place place = Place.fromJson(responseJson);
      print(place.predictions[0].description);
      return place;
    }
  }

  Future<PlaceDetail?> getPlaceDetail(String place_id) async {
    final response = await http.get(
        Uri.parse('https://rsapi.goong.io/Place/Detail?place_id=${place_id}&api_key=${AppDomain.apiKey}'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
        }
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      print('place detail ne: ' + responseJson.toString());
      PlaceDetail placeDetail = PlaceDetail.fromJson(responseJson);
      print(placeDetail.result.geometry.location.lat.toString());
      return placeDetail;
    }
  }
}