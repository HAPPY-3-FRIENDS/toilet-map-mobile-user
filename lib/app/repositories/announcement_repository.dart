import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:toiletmap/app/models/announcement/announcement.dart';
import 'package:toiletmap/app/repositories/shared_preferences_repository.dart';

import '../models/baseResponse/base_response.dart';
import '../utils/constants.dart';

class AnnouncementRepository {
  Future<List<Announcement>?> getAnnouncement() async {
    int? accountId = await SharedPreferencesRepository().getAccountId();
    String? accessToken = await SharedPreferencesRepository().getAccessToken();
    print('checkin get start' + accountId!.toString());

    final response = await http.get(
        Uri.parse('${AppDomain.appDomain1}/api/announcements?pageIndex=1&pageSize=20'),
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
      List<Announcement> announcements = (baseResponse.data as List).map(
              (i) => Announcement.fromJson(i)).toList();
      print("Announcement successfully " + announcements.toString());
      print("check Announcement 1 element" + announcements[0].toString());
      return announcements;
    }

    if (response.statusCode == 204) {
      List<Announcement> announcements = [];
      print("Announcement list empty");
      return announcements;
    }

    print("Announcement get failed");
    return null;
  }
}