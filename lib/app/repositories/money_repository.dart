import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:toiletmap/app/models/vnpayResponse/vnpay_response.dart';
import 'package:toiletmap/app/repositories/shared_preferences_repository.dart';

import '../models/baseResponse/base_response.dart';
import '../utils/constants.dart';

class MoneyRepository {
  Future<String?> postVNPay(total) async {
    int? accountId = await SharedPreferencesRepository().getAccountId();
    String? accessToken = await SharedPreferencesRepository().getAccessToken();

    var response = await http.post(
        Uri.parse("${AppDomain.appDomain1}/api/payments"),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
          HttpHeaders.authorizationHeader: "Bearer ${accessToken}",
        },
        body:
        jsonEncode({
          "accountId": accountId,
          "total": total,
          "method": 'VNPAY',
        })
    );
    print('response ne: ' + response.body);
    if (response.statusCode == 201) {
      print('checkin successfully');
      final responseJson = jsonDecode(response.body);
      BaseResponse baseResponse = BaseResponse.fromJson(responseJson);
      VNPayResponse vnPayResponse = VNPayResponse.fromJson(baseResponse.data);
      return vnPayResponse.paymentUrl;
    } else {
      return null;
    }
  }
}