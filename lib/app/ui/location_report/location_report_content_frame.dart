import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toiletmap/app/utils/routes.dart';

import '../../utils/constants.dart';

class LocationReportContentFrame extends StatefulWidget {
  const LocationReportContentFrame({Key? key}) : super(key: key);

  @override
  State<LocationReportContentFrame> createState() => _LocationReportContentFrameState();
}

class _LocationReportContentFrameState extends State<LocationReportContentFrame> {
  late String reportContent = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 620.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(height: 5.h,),
              InkWell(
                onTap: () {
                  setState(() {
                    if (reportContent != 'Nhà vệ sinh không tồn tại/không mở cửa') {
                      reportContent = 'Nhà vệ sinh không tồn tại/không mở cửa';
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
                          Text("Nhà vệ sinh không tồn tại/không mở cửa", style: AppText.titleText2,),
                          (reportContent == 'Nhà vệ sinh không tồn tại/không mở cửa')
                              ? Icon(Icons.check, size: 17.w, color: AppColor.primaryColor1,)
                              : SizedBox(),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      )
                  ),
                ),
              ),
              SizedBox(height: 5.h,),
              InkWell(
                onTap: () {
                  setState(() {
                    if (reportContent != "Nhà vệ sinh quá xa vị trí trên bản đồ") {
                      reportContent = "Nhà vệ sinh quá xa vị trí trên bản đồ";
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
                          Text("Nhà vệ sinh quá xa vị trí trên bản đồ", style: AppText.titleText2,),
                          (reportContent == "Nhà vệ sinh quá xa vị trí trên bản đồ")
                              ? Icon(Icons.check, size: 17.w, color: AppColor.primaryColor1,)
                              : SizedBox(),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      )
                  ),
                ),
              ),
              SizedBox(height: 5.h,),
              InkWell(
                onTap: () {
                  setState(() {
                    if (reportContent != "Đường đi xa hơn thực tế") {
                      reportContent = "Đường đi xa hơn thực tế";
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
                          Text("Đường đi xa hơn thực tế", style: AppText.titleText2,),
                          (reportContent == "Đường đi xa hơn thực tế")
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
