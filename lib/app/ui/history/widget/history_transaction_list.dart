

import 'package:flutter/material.dart';
import 'package:toiletmap/app/repositories/transaction_repository.dart';
import 'package:toiletmap/app/ui/history/widget/history_transaction.dart';

import '../../../models/transaction/transaction.dart';
import '../../../utils/constants.dart';

class HistoryTransactionList extends StatelessWidget {

  HistoryTransactionList({Key? key}) : super(key: key);

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      color: AppColor.primaryColor1,
      backgroundColor: Colors.white,
      strokeWidth: 2.0,
      onRefresh: () async {
        // Replace this delay with the code to be executed during refresh
        // and return a Future when code finishs execution.
        return Future<void>.delayed(const Duration(seconds: 3));
      },
      // Pull from top to show refresh indicator.
      child: FutureBuilder<List<Transaction>?>(
        future: TransactionRepository().getTransactionsByAccountId(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColor.primaryColor1,
                strokeWidth: 2.0,
              ),
            );
          }
          if(snapshot.hasData){
            if (snapshot.data!.isEmpty) {
              return Center(
                child: Text('Bạn chưa có lịch sử nào.', style: AppText.detailText2),
              );
            }
            else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  Transaction tracsaction = snapshot.data![index];
                  return Card(
                      margin: EdgeInsets.symmetric(horizontal: AppSize.widthScreen / 40, vertical: AppNumber.h200),
                      child: Container(
                        height: AppNumber.h10,
                        child: HistoryTransaction(createdDate: tracsaction.createdDate, method: tracsaction.method, total: tracsaction.total),
                      )
                  );
                },
              );
            }

          }
          return const Center(
            child: Text('Lỗi'),
          );
        },
      ),
    );
  }
}
