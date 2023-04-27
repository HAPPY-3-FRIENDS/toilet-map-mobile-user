

import 'package:flutter/material.dart';
import 'package:toiletmap/app/ui/history/widget/history_order.dart';

import '../../../models/order/order.dart';
import '../../../repositories/order_repository.dart';
import '../../../utils/constants.dart';

class HistoryOrderList extends StatelessWidget {

  HistoryOrderList({Key? key}) : super(key: key);

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
      child: FutureBuilder<List<Order>?>(
        future: OrderRepository().getOrdersByAccountId(),
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
                  Order order = snapshot.data![index];
                  return Card(
                      margin: EdgeInsets.symmetric(horizontal: AppSize.widthScreen / 40, vertical: AppNumber.h200),
                      child: Container(
                        height: AppSize.heightScreen / 8,
                        child: HistoryOrder(dateTime: order.dateTime, paymentMethod: order.paymentMethod, totalPrice: order.totalPrice, totalTurn: order.totalTurn),
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
