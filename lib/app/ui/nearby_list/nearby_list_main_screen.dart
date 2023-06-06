import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toiletmap/app/ui/home/home_main_bottom_panel/widget/panel_widget.dart';
import 'package:toiletmap/app/ui/nearby_list/widget/nearby_list_widget.dart';

import '../../utils/constants.dart';
import '../../utils/routes.dart';

class NearbyListMainScreen extends StatefulWidget {
  const NearbyListMainScreen({Key? key}) : super(key: key);

  @override
  State<NearbyListMainScreen> createState() => _NearbyListMainScreenState();
}

class _NearbyListMainScreenState extends State<NearbyListMainScreen> {
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

                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.homeMainScreen);
                    },
                    icon: Icon(
                      Icons.home_rounded,
                      color: AppColor.primaryColor1,
                    ),
                  ),
                ],

                title: Text('Nhà vệ sinh gần đây'),
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

          body: NearbyListWidget(),
      ),
    );
  }
}
