import 'package:flutter/material.dart';
import 'package:toiletmap/app/ui/home/home_main_appbar/home_main_appbar_ver3.dart';
import 'package:toiletmap/app/ui/home/home_main_bottom_panel/home_main_bottom_panel.dart';
import 'package:toiletmap/app/ui/home/home_main_map/home_main_map.dart';
import 'package:toiletmap/app/utils/constants.dart';

import 'home_main_appbar/home_main_appbar.dart';
import 'home_main_appbar/home_main_appbar_ver2.dart';
import 'home_main_bottom_panel/widget/panel_widget.dart';

class HomeMainScreen extends StatefulWidget {
  const HomeMainScreen({Key? key}) : super(key: key);

  @override
  State<HomeMainScreen> createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        body: Stack(
          children: const [
            HomeMainMap(),
            HomeMainAppbarVer3(),
            HomeMainBottomPanel(),
          ],
        )
      ),
    );
  }
}
