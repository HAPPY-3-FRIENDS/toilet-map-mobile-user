import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toiletmap/app/repositories/transaction_repository.dart';
import 'package:toiletmap/app/ui/history/widget/history_transaction.dart';

import '../../../models/transaction/transaction.dart';
import '../../../utils/constants.dart';

class HistoryTransactionList extends StatefulWidget {

  HistoryTransactionList({Key? key}) : super(key: key);

  @override
  State<HistoryTransactionList> createState() => _HistoryTransactionListState();
}

class _HistoryTransactionListState extends State<HistoryTransactionList> {
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
      future: TransactionRepository().countTransactionsByAccountId(),
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
            return Center(
              child: Text('Bạn chưa có lịch sử nào.', style: AppText.detailText2),
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
                        Transaction transaction = posts[index];
                        return Container(
                          height: 100.h,
                          margin: EdgeInsets.symmetric(vertical: 3.h),
                          child: HistoryTransaction(createdDate: transaction.createdDate, method: transaction.method, total: transaction.total),
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
    List<Transaction>? set = await TransactionRepository().getTransactionsByAccountId(page);
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
