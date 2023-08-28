import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:toiletmap/app/repositories/report_repository.dart';
import 'package:toiletmap/app/utils/routes.dart';

import '../../utils/constants.dart';

class LocationReportContentFrame extends StatefulWidget {
  int toiletId;

  LocationReportContentFrame({Key? key, required this.toiletId}) : super(key: key);

  @override
  State<LocationReportContentFrame> createState() => _LocationReportContentFrameState();
}

class _LocationReportContentFrameState extends State<LocationReportContentFrame> {
  late String reportContent = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 610.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(height: 5.h,),
              InkWell(
                onTap: () {
                  setState(() {
                    if (reportContent != 'Nhà vệ sinh không tồn tại') {
                      reportContent = 'Nhà vệ sinh không tồn tại';
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
                          Text("Nhà vệ sinh không tồn tại", style: AppText.titleText2,),
                          (reportContent == 'Nhà vệ sinh không tồn tại')
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
                    if (reportContent != "Nhà vệ sinh không mở cửa") {
                      reportContent = "Nhà vệ sinh không mở cửa";
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
                          Text("Nhà vệ sinh không mở cửa", style: AppText.titleText2,),
                          (reportContent == "Nhà vệ sinh không mở cửa")
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
                    if (reportContent != "Nhà vệ sinh không đúng vị trí định vị") {
                      reportContent = "Nhà vệ sinh không đúng vị trí định vị";
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
                          Text("Nhà vệ sinh không đúng vị trí định vị", style: AppText.titleText2,),
                          (reportContent == "Nhà vệ sinh không đúng vị trí định vị")
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
                  if (reportContent == '') {
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Chú ý'),
                          content: const Text('Vui lòng chọn mục báo cáo!'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Xác nhận'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    String? string = await ReportRepository().postLocationReport(widget.toiletId, reportContent);
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.success,
                      title: "Cảm ơn bạn đã báo cáo!",
                      confirmBtnColor: AppColor.primaryColor1,
                      confirmBtnText: "Đóng",
                      barrierDismissible: true,
                      text: 'Cảm ơn bạn đã báo cáo! Báo cáo này sẽ giúp chúng tôi nâng cấp chất lượng hệ thống hơn!',
                    ).then((value) => Navigator.pushNamed(context, Routes.homeMainScreen));
                  }
                },
                child: Text("Gửi", style: TextStyle(color: Colors.black),)
            ),
          ),
        ],
      ),
    );
  }
}
