import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:toiletmap/app/repositories/shared_preferences_repository.dart';

import '../models/baseResponse/base_response.dart';
import '../models/order/order.dart';
import '../utils/constants.dart';

class OrderRepository {
  Future<List<Order>?> getOrdersByAccountId() async {
    int? accountId = await SharedPreferencesRepository().getAccountId();
    String? accessToken = await SharedPreferencesRepository().getAccessToken();
    print('checkin get start' + accountId!.toString());

    final response = await http.get(
        Uri.parse('${AppDomain.appDomain1}/api/orders/${accountId}'),
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
      List<Order> orders = (baseResponse.data as List).map(
              (i) => Order.fromJson(i)).toList();
      print("Order successfully " + orders.toString());
      print("check Order 1 element" + orders[0].toString());
      return orders;
    }

    if (response.statusCode == 204) {
      List<Order> orders = [];
      print("Orders list empty");
      return orders;
    }

    print("Order get failed");
    return null;
  }
}