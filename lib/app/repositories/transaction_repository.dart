import 'dart:convert';
import 'dart:io';

import 'package:toiletmap/app/models/transaction/transaction.dart';
import 'package:toiletmap/app/repositories/shared_preferences_repository.dart';

import '../models/baseResponse/base_response.dart';
import '../utils/constants.dart';

import 'package:http/http.dart' as http;

class TransactionRepository {
  Future<List<Transaction>?> getTransactionsByAccountId() async {
    int? accountId = await SharedPreferencesRepository().getAccountId();
    String? accessToken = await SharedPreferencesRepository().getAccessToken();
    print('Transaction get start' + accountId!.toString());

    final response = await http.get(
        Uri.parse('${AppDomain.appDomain1}/api/payments/${accountId}'),
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
      List<Transaction> transactions = (baseResponse.data as List).map(
              (i) => Transaction.fromJson(i)).toList();
      print("Transaction successfully " + transactions.toString());
      print("check Transaction 1 element" + transactions[0].toString());
      return transactions;
    }

    if (response.statusCode == 204) {
      List<Transaction> transactions = [];
      print("Transaction list empty");
      return transactions;
    }

    print("Transaction get failed");
    return null;
  }
}