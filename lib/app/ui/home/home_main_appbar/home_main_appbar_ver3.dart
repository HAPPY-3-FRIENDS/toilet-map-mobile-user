import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toiletmap/app/repositories/shared_preferences_repository.dart';
import 'package:toiletmap/app/repositories/user_info_repository.dart';
import 'package:toiletmap/app/ui/home/home_main_appbar/widget_ver3/home_appbar_action_frame.dart';
import 'package:toiletmap/app/ui/home/home_main_screen.dart';
import 'package:toiletmap/app/ui/login/login_main_screen.dart';

import '../../../models/userInfo/user_info.dart';
import '../../../repositories/auth_repository.dart';
import '../../../repositories/checkin_repository.dart';
import '../../../repositories/order_repository.dart';
import '../../../repositories/transaction_repository.dart';
import '../../../utils/constants.dart';
import '../../../utils/routes.dart';
import '../../login/login_otp_confirmation_screen.dart';

class HomeMainAppbarVer3 extends StatefulWidget {
  const HomeMainAppbarVer3({Key? key}) : super(key: key);

  @override
  State<HomeMainAppbarVer3> createState() => _HomeMainAppbarVer3State();
}

class _HomeMainAppbarVer3State extends State<HomeMainAppbarVer3> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      child: AppBar(
        shape: AppShapeBorder.shapeBorder1,
        elevation: 5,

        leading: InkWell(
          onTap: () async {
            Navigator.pushNamed(context, Routes.informationMainScreen).then((_) => setState(() {}));
          },
          child: Icon(Icons.person, size: 25.w, color: Colors.white,),
        ),


        titleSpacing: 0,
        title: FutureBuilder<UserInfo?> (
            future: UserInfoRepository().getUserInfo(),
            builder: (context, snapshot)  {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                        color: AppColor.primaryColor1,
                        strokeWidth: 2.0
                    )
                );
              }
              if (snapshot.hasData) {
                return Text('Xin chào ${snapshot.data!.fullName}', style: TextStyle(fontSize: 20.sp),);
              }
              return Center(child: Text('Lỗi'));
            }),

        actions: [
          InkWell(
            onTap: () async {
              int? checkin = await CheckinRepository().countCheckinsByAccountId();
              int? order = await OrderRepository().countOrdersByAccountId();
              int? transaction = await TransactionRepository().countTransactionsByAccountId();
              Navigator.pushNamed(context, Routes.historyMainScreen, arguments: [checkin!, order!, transaction!]).then((_) => setState(() {}));
            },
            child: (HomeMainScreen.newCheckins != 0)
              ? Align(
              alignment: Alignment.center,
              child: badges.Badge(
                badgeStyle: badges.BadgeStyle(
                  shape: badges.BadgeShape.square,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                badgeContent: Text(
                  "${HomeMainScreen.newCheckins}",
                  style: AppText.white100Text12,
                ),
                child: Icon(Icons.history, size: 25.w, color: Colors.white,),
              ),
            )
                : Icon(Icons.history, size: 25.w, color: Colors.white,),
          ),
          Padding(padding: EdgeInsets.only(right: 15.w))
        ],

        flexibleSpace: Container(
            decoration: AppBoxDecoration.boxDecorationWithGradient1
        ),


        bottom: PreferredSize(
            preferredSize: Size.fromHeight(300.h),
            child: Container(
              padding: EdgeInsets.only(
                left: 8.w,
                right: 8.w,
                bottom: 10.h,
              ),
              child: ActionFrame(),
            ),
        ),
      ),
    );
  }
}