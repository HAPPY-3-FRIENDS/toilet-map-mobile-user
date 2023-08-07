import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:toiletmap/app/repositories/shared_preferences_repository.dart';

import '../models/baseResponse/base_response.dart';
import '../models/order/order.dart';
import '../utils/constants.dart';

class OrderRepository {
  Future<List<Order>?> getOrdersByAccountId(int page) async {
    int? accountId = await SharedPreferencesRepository().getAccountId();
    String? accessToken = await SharedPreferencesRepository().getAccessToken();
    print('checkin get start' + accountId!.toString());

    final response = await http.get(
        Uri.parse('${AppDomain.appDomain1}/api/orders?account-id=${accountId}&pageIndex=${page}&pageSize=10'),
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

  Future<int?> countOrdersByAccountId() async {
    int? accountId = await SharedPreferencesRepository().getAccountId();
    String? accessToken = await SharedPreferencesRepository().getAccessToken();
    print('checkin get start' + accountId!.toString());

    final response = await http.get(
        Uri.parse('${AppDomain.appDomain1}/api/orders/count?account-id=${accountId}'),
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
      print("count successfully ");
      return baseResponse.data;
    }

    print("get failed");
    return null;
  }

  Future<Order?> postOrder(int comboId) async {
    int? accountId = await SharedPreferencesRepository().getAccountId();
    String? accessToken = await SharedPreferencesRepository().getAccessToken();
    String method = "Số dư";

    var response = await http.post(
        Uri.parse("${AppDomain.appDomain1}/api/orders"),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
          HttpHeaders.authorizationHeader: "Bearer ${accessToken}",
        },
        body:
        jsonEncode({
          "accountId": accountId,
          "comboId": comboId,
          "paymentMethod": "Số dư",
        })
    );
    print('response ne 234: ' + response.body);
    if (response.statusCode == 201) {
      print('order successfully');
      final responseJson = jsonDecode(response.body);
      BaseResponse baseResponse = BaseResponse.fromJson(responseJson);
      Order order = Order.fromJson(baseResponse.data);
      return order;
    } else {
      return null;
    }
  }
}