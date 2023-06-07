import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toiletmap/app/ui/location_report/location_report_content_frame.dart';

import '../../utils/constants.dart';
import '../rating/widget/rating_main_information_frame.dart';

class LocationReportMainScreen extends StatefulWidget {
  int toiletId;

  LocationReportMainScreen({Key? key, required this.toiletId}) : super(key: key);

  @override
  State<LocationReportMainScreen> createState() => _LocationReportMainScreenState();
}

class _LocationReportMainScreenState extends State<LocationReportMainScreen> {
  late String reportContent = '';

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

                title: Text('Báo cáo vị trí'),
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
              children: [
                RatingMainInformationFrame(toiletId: widget.toiletId),
                LocationReportContentFrame(),
              ],
            )
          )
      ),
    );
  }
}
