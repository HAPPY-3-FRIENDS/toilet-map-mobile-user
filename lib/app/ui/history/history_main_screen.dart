import 'package:flutter/material.dart';
import 'package:toiletmap/app/ui/history/widget/history_checkin_list.dart';
import 'package:toiletmap/app/ui/history/widget/history_order_list.dart';
import 'package:toiletmap/app/ui/history/widget/history_transaction_list.dart';

import '../../utils/constants.dart';

class HistoryMainScreen extends StatefulWidget {

  const HistoryMainScreen({Key? key}) : super(key: key);

  @override
  State<HistoryMainScreen> createState() => _HistoryMainScreenState();
}

class _HistoryMainScreenState extends State<HistoryMainScreen> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);

    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Lịch sử'),
          titleTextStyle: AppText.appbarTitleText1,
          centerTitle: true,
          toolbarHeight: AppSize.heightScreen / 12,
          backgroundColor: Colors.transparent,

          flexibleSpace: Container(
            height: AppSize.heightScreen / 12,
            decoration: AppBoxDecoration.boxDecorationWithGradientNoBorder1,
          ),
        ),

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.widthScreen / 15),
              ),
              margin: EdgeInsets.all(AppSize.widthScreen / 40),
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.primaryColor2,
                  borderRadius: BorderRadius.circular(AppSize.widthScreen / 15),
                ),
                child: TabBar(
                  indicatorPadding: EdgeInsets.zero,
                  indicator: BoxDecoration(
                    gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: <Color>[AppColor.gradientColor1, AppColor.gradientColor2]
                    ),
                    borderRadius: BorderRadius.circular(AppSize.widthScreen / 15),
                  ),
                  controller: tabController,
                  isScrollable: true,

                  labelPadding: EdgeInsets.symmetric(horizontal: AppSize.widthScreen / 15, vertical: 0),
                  tabs: [
                    Tab(child: Text("Đi vệ sinh",),),
                    Tab(child: Text("Nạp tiền"),),
                    Tab(child: Text("Mua gói lượt"),),
                  ],
                  labelStyle: AppText.titleText3,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black54,
                ),
              ),
            ),
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
        )
      ),
    );
  }
}
