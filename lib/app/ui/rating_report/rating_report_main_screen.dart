import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toiletmap/app/ui/location_report/location_report_content_frame.dart';
import 'package:toiletmap/app/ui/rating_report/rating_report_content_frame.dart';

import '../../models/rating/rating.dart';
import '../../models/rating/rating_response.dart';
import '../../utils/constants.dart';
import '../rating/widget/rating_main_information_frame.dart';

class RatingReportMainScreen extends StatefulWidget {
  RatingResponse rating;

  RatingReportMainScreen({Key? key, required this.rating}) : super(key: key);

  @override
  State<RatingReportMainScreen> createState() => _RatingReportMainScreenState();
}

class _RatingReportMainScreenState extends State<RatingReportMainScreen> {
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

                title: Text('Báo cáo đánh giá'),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 60.h,
                    width: double.infinity,
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 20.w),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Vui lòng chọn lý do báo cáo", style: AppText.blackText20Bold,),
                    ),
                  ),
                  SizedBox(height: 2.h,),
                  RatingReportContentFrame(),
                ],
              ),
          )
      ),
    );
  }
}
