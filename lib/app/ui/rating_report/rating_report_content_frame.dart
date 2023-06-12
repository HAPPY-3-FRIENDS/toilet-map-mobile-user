import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toiletmap/app/utils/routes.dart';

import '../../utils/constants.dart';

class RatingReportContentFrame extends StatefulWidget {
  const RatingReportContentFrame({Key? key}) : super(key: key);

  @override
  State<RatingReportContentFrame> createState() => _RatingReportContentFrameState();
}

class _RatingReportContentFrameState extends State<RatingReportContentFrame> {
  late String reportContent = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(height: 2.h,),
              InkWell(
                onTap: () {
                  setState(() {
                    if (reportContent != 'Đánh giá chứa từ ngữ thô tục, phản cảm') {
                      reportContent = 'Đánh giá chứa từ ngữ thô tục, phản cảm';
                    } else {
                      reportContent = '';
                    }
                  });
                },
                child: Container(
                  height: 60.h,
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text("Đánh giá chứa từ ngữ thô tục, phản cảm", style: AppText.blackText18,),
                          (reportContent == 'Đánh giá chứa từ ngữ thô tục, phản cảm')
                              ? Icon(Icons.check, size: 17.w, color: AppColor.primaryColor1,)
                              : SizedBox(),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      )
                  ),
                ),
              ),
              SizedBox(height: 2.h,),
              InkWell(
                onTap: () {
                  setState(() {
                    if (reportContent != "Quảng cáo trái phép") {
                      reportContent = "Quảng cáo trái phép";
                    } else {
                      reportContent = '';
                    }
                  });
                },
                child: Container(
                  height: 60.h,
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text("Quảng cáo trái phép", style: AppText.blackText18,),
                          (reportContent == "Quảng cáo trái phép")
                              ? Icon(Icons.check, size: 17.w, color: AppColor.primaryColor1,)
                              : SizedBox(),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      )
                  ),
                ),
              ),
              SizedBox(height: 2.h,),
              InkWell(
                onTap: () {
                  setState(() {
                    if (reportContent != "Đánh giá không chính xác/gây hiểu lầm") {
                      reportContent = "Đánh giá không chính xác/gây hiểu lầm";
                    } else {
                      reportContent = '';
                    }
                  });
                },
                child: Container(
                  height: 60.h,
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text("Đánh giá không chính xác/gây hiểu lầm", style: AppText.blackText18,),
                          (reportContent == "Đánh giá không chính xác/gây hiểu lầm")
                              ? Icon(Icons.check, size: 17.w, color: AppColor.primaryColor1,)
                              : SizedBox(),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      )
                  ),
                ),
              ),
              SizedBox(height: 2.h,),
              InkWell(
                onTap: () {
                  setState(() {
                    if (reportContent != "Vi phạm khác") {
                      reportContent = "Vi phạm khác";
                    } else {
                      reportContent = '';
                    }
                  });
                },
                child: Container(
                  height: 60.h,
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text("Vi phạm khác", style: AppText.blackText18,),
                          (reportContent == "Vi phạm khác")
                              ? Icon(Icons.check, size: 17.w, color: AppColor.primaryColor1,)
                              : SizedBox(),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      )
                  ),
                ),
              ),
            ],
          ),
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
                  Navigator.pushNamed(context, Routes.homeMainScreen);
                },
                child: Text("Gửi", style: TextStyle(color: Colors.black),)
            ),
          ),
        ],
      ),
    );
  }
}
