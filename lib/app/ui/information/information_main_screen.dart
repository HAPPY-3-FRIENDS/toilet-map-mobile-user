import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toiletmap/app/repositories/user_info_repository.dart';
import 'package:toiletmap/app/ui/location_report/widget/location_report_dialog.dart';
import 'package:toiletmap/app/ui/login/login_main_screen.dart';
import 'package:toiletmap/app/utils/routes.dart';

import '../../models/userInfo/user_info.dart';
import '../../repositories/checkin_repository.dart';
import '../../repositories/order_repository.dart';
import '../../repositories/transaction_repository.dart';
import '../../utils/constants.dart';
import '../login/login_otp_confirmation_screen.dart';

class InformationMainScreen extends StatefulWidget {
  const InformationMainScreen({Key? key}) : super(key: key);

  @override
  State<InformationMainScreen> createState() => _InformationMainScreenState();
}

class _InformationMainScreenState extends State<InformationMainScreen> {

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

                title: Text('Thông tin cá nhân'),
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
                        String phone = '********' + snapshot!.data!.phone!.substring(8,10);

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.white,
                              height: 130.h,
                              padding: EdgeInsets.all(10.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: (snapshot!.data!.avatar != null)
                                          ? Container(
                                        padding: EdgeInsets.only(left: 10.w),
                                        child: CircleAvatar(
                                          radius: 50.w,
                                          backgroundImage: NetworkImage(snapshot!.data!.avatar!),
                                        ),
                                      )
                                          : Container(
                                        padding: EdgeInsets.only(left: 10.w),
                                        child: CircleAvatar(
                                          radius: 50.w,
                                          backgroundImage: AssetImage('assets/default-avatar.png'),
                                        ),
                                      )
                                  ),
                                  SizedBox(width: 20.w,),
                                  Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(flex: 5,
                                              child: Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Text(snapshot!.data!.fullName!, style: AppText.titleText2,
                                                  maxLines: 1, overflow: TextOverflow.ellipsis,),
                                              )
                                          ),
                                          Expanded(flex: 1, child: Container(),),
                                          Expanded(flex: 5,
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(phone, style: AppText.titleText2),
                                              )
                                          ),
                                        ],
                                      )),
                                  VerticalDivider(
                                    color: AppColor.primaryColor2,
                                    thickness: 1,
                                    indent: 15.w,
                                    endIndent: 15.w,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: InkWell(
                                      onTap: () => showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                              elevation: 5,
                                              alignment: Alignment.center,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppNumber.h60)),
                                              content: Container(
                                                height: 300.h,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    QrImage(
                                                      data: '23',
                                                      version: QrVersions.auto,
                                                      gapless: false,
                                                      size: 200.w,
                                                    ),
                                                    Text('Mã cá nhân', style: AppText.titleText2,),
                                                  ],
                                                ),
                                              )
                                          )),
                                      child:  QrImage(
                                        size: 70.w,
                                        data: '23',
                                        version: QrVersions.auto,
                                        gapless: false,
                                      ),
                                    ),
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
                                    onTap: () {
                                      Navigator.pushNamed(context, Routes.informationChangeMainScreen);
                                    },
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
                                                  Icon(Icons.person, color: AppColor.primaryColor1, size: 20.w,),
                                                  SizedBox(width: 10.w),
                                                  Text("Thiết lập thông tin cá nhân", style: AppText.titleText2,),
                                                ],
                                              ),
                                              Icon(Icons.arrow_forward_ios_outlined, size: 17.w, color: Colors.black38,),
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
                                    onTap: () {
                                      Navigator.pushNamed(context, Routes.informationPaymentScreen);
                                    },
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
                                                  Icon(Icons.account_balance_wallet, color: AppColor.primaryColor1, size: 20.w,),
                                                  SizedBox(width: 10.w),
                                                  Text("Thiết lập thanh toán", style: AppText.titleText2,),
                                                ],
                                              ),
                                              Icon(Icons.arrow_forward_ios_outlined, size: 17.w, color: Colors.black38,),
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
                                    onTap: () async {
                                      QuickAlert.show(
                                        context: context,
                                        type: QuickAlertType.loading,
                                        title: 'Đang tải dữ liệu',
                                      );
                                      int? checkin = await CheckinRepository().countCheckinsByAccountId();
                                      int? order = await OrderRepository().countOrdersByAccountId();
                                      int? transaction = await TransactionRepository().countTransactionsByAccountId();
                                      Navigator.pop(context);
                                      Navigator.pushNamed(context, Routes.historyMainScreen, arguments: [checkin!, order!, transaction!]).then((_) => setState(() {}));
                                    },
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
                                                  Icon(Icons.history, color: AppColor.primaryColor1, size: 20.w,),
                                                  SizedBox(width: 10.w),
                                                  Text("Lịch sử", style: AppText.titleText2,),
                                                ],
                                              ),
                                              Icon(Icons.arrow_forward_ios_outlined, size: 17.w, color: Colors.black38,),
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
                                    onTap: () {
                                      Navigator.pushNamed(context, Routes.informationServicePriceScreen);
                                    },
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
                                                  Icon(Icons.wc_rounded, color: AppColor.primaryColor1, size: 20.w,),
                                                  SizedBox(width: 10.w),
                                                  Text("Giá dịch vụ", style: AppText.titleText2,),
                                                ],
                                              ),
                                              Icon(Icons.arrow_forward_ios_outlined, size: 17.w, color: Colors.black38,),
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
                                    onTap: () {
                                      Navigator.pushNamed(context, Routes.informationLinkedAppScreen);
                                    },
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
                                                  Icon(Icons.apps_outlined, color: AppColor.primaryColor1, size: 20.w,),
                                                  SizedBox(width: 10.w),
                                                  Text("Ứng dụng liên kết", style: AppText.titleText2,),
                                                ],
                                              ),
                                              Icon(Icons.arrow_forward_ios_outlined, size: 17.w, color: Colors.black38,),
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