import 'dart:convert';
import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:toiletmap/app/main.dart';
import 'package:toiletmap/app/models/checkin/checkin.dart';
import 'package:toiletmap/app/models/checkin/checkin_argument.dart';
import 'package:toiletmap/app/models/service/service.dart';
import 'package:toiletmap/app/repositories/checkin_repository.dart';
import 'package:toiletmap/app/repositories/shared_preferences_repository.dart';
import 'package:toiletmap/app/repositories/user_info_repository.dart';
import 'package:toiletmap/app/ui/home/home_main_appbar/home_main_appbar_ver3.dart';
import 'package:toiletmap/app/ui/home/home_main_bottom_panel/home_main_bottom_panel.dart';
import 'package:toiletmap/app/ui/home/home_main_map/home_main_map.dart';
import 'package:toiletmap/app/utils/constants.dart';

import '../../models/combo/combo.dart';
import '../../models/combo/comboArgument.dart';
import '../../models/transaction/transaction.dart';
import '../../models/userInfo/user_info.dart';
import '../../repositories/combo_repository.dart';
import '../../repositories/service_repository.dart';
import '../../utils/routes.dart';
import 'home_main_appbar/home_main_appbar.dart';
import 'home_main_appbar/home_main_appbar_ver2.dart';
import 'home_main_appbar/widget_ver3/qr_code_builder.dart';
import 'home_main_bottom_panel/widget/panel_widget.dart';

class HomeMainScreen extends StatefulWidget {
  static int newCheckins = 0;
  static bool activeWebSocket = false;
  static late StompClient client;
  static late StompClient client2;
  static late int lastCheckinId;

  const HomeMainScreen({Key? key}) : super(key: key);

  @override
  State<HomeMainScreen> createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  late List<Service>? services;

  _initRatingNew() async {
    int? num = await CheckinRepository().countCheckinsNotRatingByAccountId();
    setState(() {
      HomeMainScreen.newCheckins = num!;
      HomeMainScreen.lastCheckinId = 0;
    });
  }

  _initClient() async {
    String? accessToken = await SharedPreferencesRepository().getAccessToken();

     {
      try {
        if (HomeMainScreen.client.isActive) {
          HomeMainScreen.client.deactivate();
        }
        if (HomeMainScreen.client2.isActive) {
          HomeMainScreen.client2.deactivate();
        }
      } catch (e) {
        print(e);
      }
      setState(() {
        HomeMainScreen.client = StompClient(
            config: StompConfig.SockJS(
              url: '${AppString.appDomain}/ws-message',
              onConnect: onConnect,
              onWebSocketError: (dynamic error) => print(error.toString()),
              stompConnectHeaders: {'Authorization': 'Bearer ${accessToken}'},
              webSocketConnectHeaders: {'Authorization': 'Bearer ${accessToken}'},
            )
        );
        HomeMainScreen.client2 = StompClient(
            config: StompConfig.SockJS(
              url: '${AppString.appDomain}/ws-message',
              onConnect: onConnect2,
              onWebSocketError: (dynamic error) => print(error.toString()),
              stompConnectHeaders: {'Authorization': 'Bearer ${accessToken}'},
              webSocketConnectHeaders: {'Authorization': 'Bearer ${accessToken}'},
            )
        );
        HomeMainScreen.activeWebSocket = true;
      });

      HomeMainScreen.client.activate();
      HomeMainScreen.client2.activate();
    }
  }

  void onConnect(StompFrame connectFrame) async {
    String? phone = await SharedPreferencesRepository().getUsername();

    print("connect websocket oke");
    HomeMainScreen.client.subscribe(
        destination: '/topic/check-in',
        callback: (StompFrame frame) async {
          Map<String, dynamic> result = json.decode(frame.body!);
          Checkin checkin = Checkin.fromJson(result);
          if (checkin.id != HomeMainScreen.lastCheckinId && checkin.username == phone) {
            setState(() {
              HomeMainScreen.lastCheckinId = checkin.id;
              HomeMainScreen.newCheckins += 1;
              print("Có in ko + " + QRCodeBuilder.qrCode.toString());
              if (QRCodeBuilder.qrCode == true) {
                Navigator.pop(context);
              }
              print(QRCodeBuilder.qrCode);
              AwesomeDialog(
                  context: context,
                  dialogType: DialogType.success,
                  animType: AnimType.topSlide,
                  btnOkText: 'Đánh giá ngay',
                  //btnOkColor: AppColor.primaryColor1,
                  showCloseIcon: true,
                  body: Container(
                      height: 120.h,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(20.w),
                        child: RichText(
                          text: TextSpan(
                              text: 'Cảm ơn bạn đã sử dụng dịch vụ tại ',
                              style: TextStyle(fontSize: 18.sp, color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: checkin.toiletName,
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: AppColor.primaryColor1,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ]
                          ),
                        ),
                      )
                  ),
                  btnOkOnPress: () async {
                    Navigator.pushNamed(context, Routes.ratingMainScreen, arguments: checkin).then((_) => setState(() {}));
                  }
              ).show();
            });
          };
          print('id ne ' + checkin.id.toString());
          /*try {
            Checkin checkin = Checkin.fromJson(result);
            if (checkin.id != HomeMainScreen.lastCheckinId && checkin.username == phone) await {
              setState(() {
                HomeMainScreen.lastCheckinId = checkin.id;
                HomeMainScreen.newCheckins += 1;
                print("Có in ko + " + QRCodeBuilder.qrCode.toString());
                if (QRCodeBuilder.qrCode == true) {
                  Navigator.pop(context);
                }
                print(QRCodeBuilder.qrCode);
                AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.topSlide,
                    btnOkText: 'Đánh giá ngay',
                    //btnOkColor: AppColor.primaryColor1,
                    showCloseIcon: true,
                    body: Container(
                        height: 120.h,
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.all(20.w),
                          child: RichText(
                            text: TextSpan(
                                text: 'Cảm ơn bạn đã sử dụng dịch vụ tại ',
                                style: TextStyle(fontSize: 18.sp, color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: checkin.toiletName,
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      color: AppColor.primaryColor1,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]
                            ),
                          ),
                        )
                    ),
                    btnOkOnPress: () async {
                      Navigator.pushNamed(context, Routes.ratingMainScreen, arguments: checkin).then((_) => setState(() {}));
                    }
                ).show();
              })
            };
            print('id ne ' + checkin.id.toString());
          } catch (e) {
            CheckinArgument checkinArgument = CheckinArgument.fromJson(result);
            int? account = await SharedPreferencesRepository().getAccountId();
            if (checkinArgument.accountId == account) {
              setState(() {
                print("Có in ko + " + QRCodeBuilder.qrCode.toString());
                if (QRCodeBuilder.qrCode == true) {
                  Navigator.pop(context);
                }
                AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.topSlide,
                    btnOkText: (checkinArgument.isAccountTurnNotEnough! == "true") ? 'Mua lượt ngay' : 'Nạp tiền ngay',
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
                                    text: (checkinArgument.isAccountTurnNotEnough! == "true")
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
                      if (checkinArgument.isAccountTurnNotEnough!  == "true") {
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
              });
            }
          }*/
        });
  }

  void onConnect2(StompFrame connectFrame) async {
    String? phone = await SharedPreferencesRepository().getUsername();
    int? accountId = await SharedPreferencesRepository().getAccountId();

    print("connect websocket oke");
    HomeMainScreen.client.subscribe(
        destination: '/topic/payment',
        callback: (StompFrame frame) async {
          Map<String, dynamic> result = json.decode(frame.body!);
          Transaction transaction = Transaction.fromJson(result);
          if (transaction.accountId == accountId) {
            setState(() {
              if (QRCodeBuilder.qrCode == true) {
                Navigator.pop(context);
              }
              AwesomeDialog(
                  context: context,
                  dialogType: DialogType.success,
                  animType: AnimType.topSlide,
                  dismissOnBackKeyPress: true,
                  autoDismiss: true,
                  dismissOnTouchOutside: true,
                  //btnOkColor: AppColor.primaryColor1,
                  showCloseIcon: true,
                  body: Container(
                      height: 100.h,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: 'Tài khoản của bạn đã được nạp thành công ',
                                  style: TextStyle(fontSize: 16.sp, color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(transaction.total) + " VNĐ",
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        color: AppColor.primaryColor1,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ]
                              ),
                            ),
                          ],
                        )
                      )
                  ),
              ).show();
            });
          }
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initRatingNew();
    _initClient();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            body: Stack(
              children: [
                HomeMainMap(),
                HomeMainAppbarVer3(),
                HomeMainBottomPanel(),
              ],
            )
        ),
      )
    );
  }
}
