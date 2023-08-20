import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:toiletmap/app/models/service/service.dart';
import 'package:toiletmap/app/models/userInfo/user_info.dart';
import 'package:toiletmap/app/repositories/shared_preferences_repository.dart';
import 'package:toiletmap/app/repositories/user_info_repository.dart';
import 'package:toiletmap/app/ui/home/home_main_appbar/widget_ver3/qr_code_builder.dart';
import 'package:toiletmap/app/utils/constants.dart';

import '../../../../models/combo/combo.dart';
import '../../../../models/combo/comboArgument.dart';
import '../../../../repositories/combo_repository.dart';
import '../../../../repositories/service_repository.dart';
import '../../../../utils/routes.dart';

class HomeAppbarQRCodeFrame extends StatelessWidget {
  final int accountId;

  const HomeAppbarQRCodeFrame({Key? key, required this.accountId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: 3.w,
          right: 3.w,
          top: 10.w,
          bottom: 3.w
      ),
      decoration: AppBoxDecoration.appBarQRCodeDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Mã thanh toán', style: AppText.appbarQRButtonText2,),
          Container(
            height: 120.h,
            padding: EdgeInsets.all(3.w),
            decoration: AppBoxDecoration.boxDecoration1,
            child: FutureBuilder<UserInfo?> (
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
                    UserInfo userInfo = snapshot.data!;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(width: 1.5.w, color: AppColor.primaryColor2),
                                )
                            ),
                            child: InkWell(
                              onTap: () async {
                                List<Service>? services = await ServiceRepository().getServices();

                                if (userInfo.defaultPayment == "Số lượt") {
                                  if (userInfo.accountTurn < services![0].turn) {
                                    AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.error,
                                        animType: AnimType.topSlide,
                                        btnOkText: (userInfo.defaultPayment! == "Số lượt") ? 'Mua lượt ngay' : 'Nạp tiền ngay',
                                        //btnOkColor: AppColor.primaryColor1,
                                        showCloseIcon: true,
                                        body: Container(
                                            height: 120.h,
                                            color: Colors.white,
                                            child: Padding(
                                              padding: EdgeInsets.all(20.w),
                                              child: RichText(
                                                text: TextSpan(
                                                    text: 'Tài khoản của quý khách đã hết ',
                                                    style: TextStyle(fontSize: 18.sp, color: Colors.black),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: (userInfo.defaultPayment! == "Số lượt")
                                                            ? "lượt. " : "tiền. ",
                                                        style: TextStyle(
                                                          fontSize: 20.sp,
                                                          color: AppColor.primaryColor1,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: 'Vui lòng nạp thêm hoặc đổi phương thức thanh toán!',
                                                        style: TextStyle(
                                                          fontSize: 18.sp,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ]
                                                ),
                                              ),
                                            )
                                        ),
                                        btnOkColor: Colors.orangeAccent,
                                        btnOkOnPress: () async {
                                          if (userInfo.defaultPayment! == "Số lượt") {
                                            UserInfo? userInfo = await UserInfoRepository().getUserInfo();

                                            List<String> buttonList = [];
                                            List<int> priceList = [];
                                            List<Combo>? combo = await ComboRepository().getCombos();

                                            combo!.forEach((element) {
                                              buttonList.add(NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(element.price) + " VNĐ/" + element.totalTurn.toString() + " lượt");
                                              priceList.add(element.price);
                                            });

                                            ComboArgument comboArgument = ComboArgument(buttonList, priceList, userInfo!.accountBalance);
                                            await Navigator.pushNamed(context, Routes.buyComboMainScreen, arguments: comboArgument);
                                          } else
                                            Navigator.pushNamed(context, Routes.topUpMoneyMainScreen);
                                        }
                                    ).show();
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (_) => QRCodeBuilder(accountId: accountId,data: 'Đi vệ sinh (tiểu tiện)')
                                    );
                                  }
                                } else {
                                  if (userInfo.accountBalance < services![0].price) {
                                    AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.error,
                                        animType: AnimType.topSlide,
                                        btnOkText: (userInfo.defaultPayment! == "Số lượt") ? 'Mua lượt ngay' : 'Nạp tiền ngay',
                                        //btnOkColor: AppColor.primaryColor1,
                                        showCloseIcon: true,
                                        body: Container(
                                            height: 120.h,
                                            color: Colors.white,
                                            child: Padding(
                                              padding: EdgeInsets.all(20.w),
                                              child: RichText(
                                                text: TextSpan(
                                                    text: 'Tài khoản của quý khách đã hết ',
                                                    style: TextStyle(fontSize: 18.sp, color: Colors.black),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: (userInfo.defaultPayment! == "Số lượt")
                                                            ? "lượt. " : "tiền. ",
                                                        style: TextStyle(
                                                          fontSize: 20.sp,
                                                          color: AppColor.primaryColor1,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: 'Vui lòng nạp thêm hoặc đổi phương thức thanh toán!',
                                                        style: TextStyle(
                                                          fontSize: 18.sp,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ]
                                                ),
                                              ),
                                            )
                                        ),
                                        btnOkColor: Colors.orangeAccent,
                                        btnOkOnPress: () async {
                                          if (userInfo.defaultPayment! == "Số lượt") {
                                            UserInfo? userInfo = await UserInfoRepository().getUserInfo();

                                            List<String> buttonList = [];
                                            List<int> priceList = [];
                                            List<Combo>? combo = await ComboRepository().getCombos();

                                            combo!.forEach((element) {
                                              buttonList.add(NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(element.price) + " VNĐ/" + element.totalTurn.toString() + " lượt");
                                              priceList.add(element.price);
                                            });

                                            ComboArgument comboArgument = ComboArgument(buttonList, priceList, userInfo!.accountBalance);
                                            await Navigator.pushNamed(context, Routes.buyComboMainScreen, arguments: comboArgument);
                                          } else
                                            Navigator.pushNamed(context, Routes.topUpMoneyMainScreen);
                                        }
                                    ).show();
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (_) => QRCodeBuilder(accountId: accountId,data: 'Đi vệ sinh (tiểu tiện)')
                                    );
                                  }
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.qr_code_2, size: 15.w),
                                  Text('Tiểu tiện',style: TextStyle(
                                      fontSize: 18.sp
                                  ),),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(width: 1.5.w, color: AppColor.primaryColor2),
                                )
                            ),
                            child: InkWell(
                              onTap: () async {
                                List<Service>? services = await ServiceRepository().getServices();

                                if (userInfo.defaultPayment == "Số lượt") {
                                  if (userInfo.accountTurn < services![1].turn) {
                                    AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.error,
                                        animType: AnimType.topSlide,
                                        btnOkText: (userInfo.defaultPayment! == "Số lượt") ? 'Mua lượt ngay' : 'Nạp tiền ngay',
                                        //btnOkColor: AppColor.primaryColor1,
                                        showCloseIcon: true,
                                        body: Container(
                                            height: 120.h,
                                            color: Colors.white,
                                            child: Padding(
                                              padding: EdgeInsets.all(20.w),
                                              child: RichText(
                                                text: TextSpan(
                                                    text: 'Tài khoản của quý khách đã hết ',
                                                    style: TextStyle(fontSize: 18.sp, color: Colors.black),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: (userInfo.defaultPayment! == "Số lượt")
                                                            ? "lượt. " : "tiền. ",
                                                        style: TextStyle(
                                                          fontSize: 20.sp,
                                                          color: AppColor.primaryColor1,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: 'Vui lòng nạp thêm hoặc đổi phương thức thanh toán!',
                                                        style: TextStyle(
                                                          fontSize: 18.sp,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ]
                                                ),
                                              ),
                                            )
                                        ),
                                        btnOkColor: Colors.orangeAccent,
                                        btnOkOnPress: () async {
                                          if (userInfo.defaultPayment! == "Số lượt") {
                                            UserInfo? userInfo = await UserInfoRepository().getUserInfo();

                                            List<String> buttonList = [];
                                            List<int> priceList = [];
                                            List<Combo>? combo = await ComboRepository().getCombos();

                                            combo!.forEach((element) {
                                              buttonList.add(NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(element.price) + " VNĐ/" + element.totalTurn.toString() + " lượt");
                                              priceList.add(element.price);
                                            });

                                            ComboArgument comboArgument = ComboArgument(buttonList, priceList, userInfo!.accountBalance);
                                            await Navigator.pushNamed(context, Routes.buyComboMainScreen, arguments: comboArgument);
                                          } else
                                            Navigator.pushNamed(context, Routes.topUpMoneyMainScreen);
                                        }
                                    ).show();
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (_) => QRCodeBuilder(accountId: accountId, data: 'Đi vệ sinh (đại tiện)')
                                    );
                                  }
                                } else {
                                  if (userInfo.accountBalance < services![1].price) {
                                    AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.error,
                                        animType: AnimType.topSlide,
                                        btnOkText: (userInfo.defaultPayment! == "Số lượt") ? 'Mua lượt ngay' : 'Nạp tiền ngay',
                                        //btnOkColor: AppColor.primaryColor1,
                                        showCloseIcon: true,
                                        body: Container(
                                            height: 120.h,
                                            color: Colors.white,
                                            child: Padding(
                                              padding: EdgeInsets.all(20.w),
                                              child: RichText(
                                                text: TextSpan(
                                                    text: 'Tài khoản của quý khách đã hết ',
                                                    style: TextStyle(fontSize: 18.sp, color: Colors.black),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: (userInfo.defaultPayment! == "Số lượt")
                                                            ? "lượt. " : "tiền. ",
                                                        style: TextStyle(
                                                          fontSize: 20.sp,
                                                          color: AppColor.primaryColor1,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: 'Vui lòng nạp thêm hoặc đổi phương thức thanh toán!',
                                                        style: TextStyle(
                                                          fontSize: 18.sp,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ]
                                                ),
                                              ),
                                            )
                                        ),
                                        btnOkColor: Colors.orangeAccent,
                                        btnOkOnPress: () async {
                                          if (userInfo.defaultPayment! == "Số lượt") {
                                            UserInfo? userInfo = await UserInfoRepository().getUserInfo();

                                            List<String> buttonList = [];
                                            List<int> priceList = [];
                                            List<Combo>? combo = await ComboRepository().getCombos();

                                            combo!.forEach((element) {
                                              buttonList.add(NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(element.price) + " VNĐ/" + element.totalTurn.toString() + " lượt");
                                              priceList.add(element.price);
                                            });

                                            ComboArgument comboArgument = ComboArgument(buttonList, priceList, userInfo!.accountBalance);
                                            await Navigator.pushNamed(context, Routes.buyComboMainScreen, arguments: comboArgument);
                                          } else
                                            Navigator.pushNamed(context, Routes.topUpMoneyMainScreen);
                                        }
                                    ).show();
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (_) => QRCodeBuilder(accountId: accountId, data: 'Đi vệ sinh (đại tiện)')
                                    );
                                  }
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.qr_code_2, size: 15.w),
                                  Text(' Đại tiện',style: TextStyle(
                                      fontSize: 18.sp
                                  ),),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: InkWell(
                              onTap: () async {
                                List<Service>? services = await ServiceRepository().getServices();

                                if (userInfo.defaultPayment == "Số lượt") {
                                  if (userInfo.accountTurn < services![2].turn) {
                                    AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.error,
                                        animType: AnimType.topSlide,
                                        btnOkText: (userInfo.defaultPayment! == "Số lượt") ? 'Mua lượt ngay' : 'Nạp tiền ngay',
                                        //btnOkColor: AppColor.primaryColor1,
                                        showCloseIcon: true,
                                        body: Container(
                                            height: 120.h,
                                            color: Colors.white,
                                            child: Padding(
                                              padding: EdgeInsets.all(20.w),
                                              child: RichText(
                                                text: TextSpan(
                                                    text: 'Tài khoản của quý khách đã hết ',
                                                    style: TextStyle(fontSize: 18.sp, color: Colors.black),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: (userInfo.defaultPayment! == "Số lượt")
                                                            ? "lượt. " : "tiền. ",
                                                        style: TextStyle(
                                                          fontSize: 20.sp,
                                                          color: AppColor.primaryColor1,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: 'Vui lòng nạp thêm hoặc đổi phương thức thanh toán!',
                                                        style: TextStyle(
                                                          fontSize: 18.sp,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ]
                                                ),
                                              ),
                                            )
                                        ),
                                        btnOkColor: Colors.orangeAccent,
                                        btnOkOnPress: () async {
                                          if (userInfo.defaultPayment! == "Số lượt") {
                                            UserInfo? userInfo = await UserInfoRepository().getUserInfo();

                                            List<String> buttonList = [];
                                            List<int> priceList = [];
                                            List<Combo>? combo = await ComboRepository().getCombos();

                                            combo!.forEach((element) {
                                              buttonList.add(NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(element.price) + " VNĐ/" + element.totalTurn.toString() + " lượt");
                                              priceList.add(element.price);
                                            });

                                            ComboArgument comboArgument = ComboArgument(buttonList, priceList, userInfo!.accountBalance);
                                            await Navigator.pushNamed(context, Routes.buyComboMainScreen, arguments: comboArgument);
                                          } else
                                            Navigator.pushNamed(context, Routes.topUpMoneyMainScreen);
                                        }
                                    ).show();
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (_) => QRCodeBuilder(accountId: accountId,data: 'Đi tắm')
                                    );
                                  }
                                } else {
                                  if (userInfo.accountBalance < services![2].price) {
                                    AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.error,
                                        animType: AnimType.topSlide,
                                        btnOkText: (userInfo.defaultPayment! == "Số lượt") ? 'Mua lượt ngay' : 'Nạp tiền ngay',
                                        //btnOkColor: AppColor.primaryColor1,
                                        showCloseIcon: true,
                                        body: Container(
                                            height: 120.h,
                                            color: Colors.white,
                                            child: Padding(
                                              padding: EdgeInsets.all(20.w),
                                              child: RichText(
                                                text: TextSpan(
                                                    text: 'Tài khoản của quý khách đã hết ',
                                                    style: TextStyle(fontSize: 18.sp, color: Colors.black),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: (userInfo.defaultPayment! == "Số lượt")
                                                            ? "lượt. " : "tiền. ",
                                                        style: TextStyle(
                                                          fontSize: 20.sp,
                                                          color: AppColor.primaryColor1,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: 'Vui lòng nạp thêm hoặc đổi phương thức thanh toán!',
                                                        style: TextStyle(
                                                          fontSize: 18.sp,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ]
                                                ),
                                              ),
                                            )
                                        ),
                                        btnOkColor: Colors.orangeAccent,
                                        btnOkOnPress: () async {
                                          if (userInfo.defaultPayment! == "Số lượt") {
                                            UserInfo? userInfo = await UserInfoRepository().getUserInfo();

                                            List<String> buttonList = [];
                                            List<int> priceList = [];
                                            List<Combo>? combo = await ComboRepository().getCombos();

                                            combo!.forEach((element) {
                                              buttonList.add(NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(element.price) + " VNĐ/" + element.totalTurn.toString() + " lượt");
                                              priceList.add(element.price);
                                            });

                                            ComboArgument comboArgument = ComboArgument(buttonList, priceList, userInfo!.accountBalance);
                                            await Navigator.pushNamed(context, Routes.buyComboMainScreen, arguments: comboArgument);
                                          } else
                                            Navigator.pushNamed(context, Routes.topUpMoneyMainScreen);
                                        }
                                    ).show();
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (_) => QRCodeBuilder(accountId: accountId,data: 'Đi tắm')
                                    );
                                  }
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.qr_code_2, size: 15.w),
                                  Text(' Đi tắm',style: TextStyle(
                                      fontSize: 18.sp
                                  ),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return Center(child: Text('Lỗi'));
                }),
          )
        ],
      ),
    );
  }
}