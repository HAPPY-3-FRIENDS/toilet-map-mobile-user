import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:toiletmap/app/models/checkin/checkin.dart';
import 'package:toiletmap/app/repositories/checkin_repository.dart';
import 'package:toiletmap/app/repositories/shared_preferences_repository.dart';
import 'package:toiletmap/app/ui/home/home_main_appbar/home_main_appbar_ver3.dart';
import 'package:toiletmap/app/ui/home/home_main_bottom_panel/home_main_bottom_panel.dart';
import 'package:toiletmap/app/ui/home/home_main_map/home_main_map.dart';
import 'package:toiletmap/app/utils/constants.dart';

import '../../utils/routes.dart';
import 'home_main_appbar/home_main_appbar.dart';
import 'home_main_appbar/home_main_appbar_ver2.dart';
import 'home_main_appbar/widget_ver3/qr_code_builder.dart';
import 'home_main_bottom_panel/widget/panel_widget.dart';

class HomeMainScreen extends StatefulWidget {
  static int newCheckins = 0;

  const HomeMainScreen({Key? key}) : super(key: key);

  @override
  State<HomeMainScreen> createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  late StompClient client;
  late int lastCheckinId;

  _initRatingNew() async {
    int? num = await CheckinRepository().countCheckinsNotRatingByAccountId();
    setState(() {
      HomeMainScreen.newCheckins = num!;
      lastCheckinId = 0;
    });
  }

  _initClient() async {
    String? accessToken = await SharedPreferencesRepository().getAccessToken();

    setState(() {
      client = StompClient(
          config: StompConfig.SockJS(
            url: 'https://toilet-map.azurewebsites.net/ws-message',
            onConnect: onConnect,
            onWebSocketError: (dynamic error) => print(error.toString()),
            stompConnectHeaders: {'Authorization': 'Bearer ${accessToken}'},
            webSocketConnectHeaders: {'Authorization': 'Bearer ${accessToken}'},
          )
      );
    });
    client.activate();
  }

  void onConnect(StompFrame connectFrame) async {
    String? phone = await SharedPreferencesRepository().getUsername();

    print("connect websocket oke");
    client.subscribe(
        destination: '/topic/check-in',
        callback: (StompFrame frame) {
          Map<String, dynamic> result = json.decode(frame.body!);
          Checkin checkin = Checkin.fromJson(result);
          if (checkin.id != lastCheckinId && checkin.username == phone) {
            setState(() {
              lastCheckinId = checkin.id;
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
          }
          print('id ne ' + checkin.id.toString());
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
