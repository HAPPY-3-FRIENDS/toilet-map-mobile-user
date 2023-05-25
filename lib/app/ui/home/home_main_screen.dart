import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:toiletmap/app/models/checkin/checkin.dart';
import 'package:toiletmap/app/repositories/shared_preferences_repository.dart';
import 'package:toiletmap/app/ui/home/home_main_appbar/home_main_appbar_ver3.dart';
import 'package:toiletmap/app/ui/home/home_main_bottom_panel/home_main_bottom_panel.dart';
import 'package:toiletmap/app/ui/home/home_main_map/home_main_map.dart';
import 'package:toiletmap/app/utils/constants.dart';

import 'home_main_appbar/home_main_appbar.dart';
import 'home_main_appbar/home_main_appbar_ver2.dart';
import 'home_main_bottom_panel/widget/panel_widget.dart';

class HomeMainScreen extends StatefulWidget {
  static int newCheckins = 0;

  const HomeMainScreen({Key? key}) : super(key: key);

  @override
  State<HomeMainScreen> createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  late StompClient client;

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

  void onConnect(StompFrame connectFrame) {
    print("connect websocket oke");
    client.subscribe(
        destination: '/topic/check-in',
        callback: (StompFrame frame) {

          Map<String, dynamic> result = json.decode(frame.body!);
          Checkin checkin = Checkin.fromJson(result);
          setState(() {
            HomeMainScreen.newCheckins += 1;
          });
          print('id ne ' + checkin.id.toString());
          AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.topSlide,
              btnOkText: 'Đánh giá',
              btnOkColor: AppColor.primaryColor1,
              showCloseIcon: true,
              body: Container(
                height: 120.h,
                color: Colors.white,
                child: Text('hihi')
              ),
              btnOkOnPress: () async {}
          ).show();
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
