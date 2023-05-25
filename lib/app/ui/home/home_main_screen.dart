import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
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
          setState(() {
            HomeMainScreen.newCheckins += 1;
          });
          print(result);
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
      child: Scaffold(
        body: Stack(
          children: [
            HomeMainMap(),
            HomeMainAppbarVer3(),
            HomeMainBottomPanel(),
          ],
        )
      ),
    );
  }
}
