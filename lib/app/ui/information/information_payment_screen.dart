import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toiletmap/app/repositories/user_info_repository.dart';
import 'package:toiletmap/app/ui/login/login_main_screen.dart';
import 'package:toiletmap/app/utils/routes.dart';

import '../../models/userInfo/user_info.dart';
import '../../utils/constants.dart';
import '../login/login_otp_confirmation_screen.dart';

class InformationPaymentScreen extends StatelessWidget {
  const InformationPaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.h),
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 20.h),
              child: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: AppColor.primaryColor1,
                  ),
                ),

                title: Text('Thiết lập thanh toán'),
                titleTextStyle: AppText.appbarTitleText2,
                centerTitle: true,
                toolbarHeight: 100.h,
                backgroundColor: Colors.white,
                elevation: 0,

                iconTheme: IconThemeData(
                    color: AppColor.primaryColor1
                ),
              ),
            ),
          ),

          body: Container(
            color: Color(0xFFF1F1F1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FutureBuilder<UserInfo?> (
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
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                color: Colors.white,
                                height: 120.h,
                                padding: EdgeInsets.all(10.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                        flex: 9,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text('Số lượt', style: AppText.appbarText1,),
                                            Text('${snapshot!.data!.accountTurn} lượt', style: AppText.appbarTitleText2,),
                                          ],
                                        )
                                    ),
                                    VerticalDivider(
                                      color: AppColor.primaryColor2,
                                      thickness: 1,
                                      indent: 5.w,
                                      endIndent: 5.w,
                                    ),
                                    Expanded(
                                        flex: 13,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text('Số dư', style: AppText.appbarText1),
                                            Text(NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(snapshot.data!.accountBalance) + ' VNĐ', style: AppText.appbarTitleText2,),
                                          ],
                                        )
                                    ),
                                  ],
                                ),
                            ),
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      height: 60.h,
                                      width: double.infinity,
                                      color: Colors.white,
                                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Text("Liên kết thanh toán", style: AppText.titleText2,),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text("VÍ VNPAY", style: AppText.titleText4,),
                                                  SizedBox(width: 10.w),
                                                  Icon(Icons.arrow_forward_ios_outlined, size: 17.w, color: Colors.black38,),
                                                ],
                                              ),
                                            ],
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          )
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      height: 60.h,
                                      width: double.infinity,
                                      color: Colors.white,
                                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Text("Nạp tiền", style: AppText.titleText2,),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(Icons.arrow_forward_ios_outlined, size: 17.w, color: Colors.black38,),
                                                ],
                                              ),
                                            ],
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          )
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      height: 60.h,
                                      width: double.infinity,
                                      color: Colors.white,
                                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Text("Mua gói lượt", style: AppText.titleText2,),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(Icons.arrow_forward_ios_outlined, size: 17.w, color: Colors.black38,),
                                                ],
                                              ),
                                            ],
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          )
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                      return Center(child: Text('Lỗi'));
                    }),
                Container(
                  padding: EdgeInsets.all(15.w),
                  width: double.infinity,
                  height: 90.h,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: AppColor.primaryColor2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r))),
                      onPressed: () async {
                        try {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.clear();
                          Navigator.of(context).pushAndRemoveUntil(
                            //change Route to build apk
                              MaterialPageRoute(builder: (context) => const LoginMainScreen()), (
                              route) => false);
                        } catch (error) {
                          print(error);
                        }
                      },
                      child: Text("Đăng xuất", style: TextStyle(color: Colors.black),)
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
