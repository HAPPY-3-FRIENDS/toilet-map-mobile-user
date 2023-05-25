import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toiletmap/app/ui/history/widget/history_checkin_list.dart';
import 'package:toiletmap/app/ui/history/widget/history_order_list.dart';
import 'package:toiletmap/app/ui/history/widget/history_transaction_list.dart';
import 'package:toiletmap/app/ui/home/home_main_screen.dart';

import '../../utils/constants.dart';

class HistoryMainScreen extends StatefulWidget {

  const HistoryMainScreen({Key? key}) : super(key: key);

  @override
  State<HistoryMainScreen> createState() => _HistoryMainScreenState();
}

class _HistoryMainScreenState extends State<HistoryMainScreen> with TickerProviderStateMixin {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      HomeMainScreen.newCheckins = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);

    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150.h),
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 20.h),
            child: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: AppColor.primaryColor1,
                ),
              ),

              title: Text('Lịch sử'),
              titleTextStyle: AppText.appbarTitleText2,
              centerTitle: true,
              toolbarHeight: 150.h,
              backgroundColor: Colors.white,
              elevation: 1,
              iconTheme: IconThemeData(
                  color: AppColor.primaryColor1
              ),

              bottom: PreferredSize(
                preferredSize: Size.fromHeight(40.h),
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  child: Center(
                    child: TabBar(
                      indicatorPadding: EdgeInsets.zero,
                      indicator: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: AppColor.primaryColor1,
                                width: 2.h
                            )
                        ),
                      ),
                      controller: tabController,
                      isScrollable: true,

                      labelPadding: EdgeInsets.symmetric(horizontal: 25.w),
                      tabs: [
                        Tab(child: Text("Đi vệ sinh",),),
                        Tab(child: Text("Nạp tiền"),),
                        Tab(child: Text("Mua gói lượt"),),
                      ],
                      labelStyle: AppText.titleText3,
                      labelColor: AppColor.primaryColor1,
                      unselectedLabelColor: Colors.black54,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        body: Container(
          color: Color(0xFFF1F1F1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      HistoryCheckinList(),
                      HistoryTransactionList(),
                      HistoryOrderList()
                    ],
                  ))
            ],
          ),
        )
      ),
    );
  }
}
