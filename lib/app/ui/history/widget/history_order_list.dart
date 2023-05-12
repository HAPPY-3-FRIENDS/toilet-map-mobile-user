import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toiletmap/app/ui/history/widget/history_order.dart';

import '../../../models/order/order.dart';
import '../../../repositories/order_repository.dart';
import '../../../utils/constants.dart';

class HistoryOrderList extends StatefulWidget {

  HistoryOrderList({Key? key}) : super(key: key);

  @override
  State<HistoryOrderList> createState() => _HistoryOrderListState();
}

class _HistoryOrderListState extends State<HistoryOrderList> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  final scrollController = ScrollController();
  bool isLoadingMore = false;
  List posts = [];
  int page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(_scrollListener);
    _fetchPosts(page);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int?>(
      future: OrderRepository().countOrdersByAccountId(),
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          print("ham nay bi goi lai");
          return const Center(
            child: CircularProgressIndicator(
              color: AppColor.primaryColor1,
              strokeWidth: 2.0,
            ),
          );
        }
        if(snapshot.hasData){
          print("check okok");
          if (snapshot.data! == 0) {
            return Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: 10.h,),
                  SizedBox(height: 200.w, width: 200.w,
                    child: Image(image: AssetImage('assets/images/no-data.gif'),),),
                  SizedBox(height: 10.h,),
                  Text('Bạn chưa có lịch sử nào', style: AppText.detailText2)
                ],
              ),
            );
          } else {
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
                child: Container(
                  padding: EdgeInsets.only(top: 5.h),
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: isLoadingMore ? posts.length + 1 : posts.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index < posts.length) {
                        Order order = posts[index];
                        return Container(
                          height: 100.h,
                          margin: EdgeInsets.symmetric(vertical: 3.h),
                          child: HistoryOrder(dateTime: order.dateTime, paymentMethod: order.paymentMethod, totalPrice: order.totalPrice, totalTurn: order.totalTurn),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                )
            );
          }
        }
        return const Center(
          child: Text('Lỗi'),
        );
      },
    );
  }

  Future<void> _fetchPosts(int page) async {
    List<Order>? set = await OrderRepository().getOrdersByAccountId(page);
    setState(() {
      posts = posts + set!;
    });
  }

  Future<void> _scrollListener() async {
    if (isLoadingMore) return;
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      setState(() {
        isLoadingMore = true;
      });
      page += 1;
      await _fetchPosts(page);
      setState(() {
        isLoadingMore = false;
      });
    }
  }
}
