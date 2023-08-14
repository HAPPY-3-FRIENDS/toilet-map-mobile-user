import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quickalert/quickalert.dart';
import 'package:toiletmap/app/utils/constants.dart';

import '../../../models/toilet/toilet.dart';
import '../../../repositories/toilet_repository.dart';
import '../../../utils/routes.dart';

class LocationReportDialog extends StatefulWidget {
  int id;
  int waitTime;

  LocationReportDialog({Key? key, required this.id, required this.waitTime}) : super(key: key);

  @override
  State<LocationReportDialog> createState() => _LocationReportDialogState();
}

class _LocationReportDialogState extends State<LocationReportDialog> {
  int choose = 0;

  @override
  Widget build(BuildContext context) {
    print("check wait time: " + widget.waitTime.toString());

    return (widget.waitTime == 0)
      ? Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      height: (choose != 1) ? 250.h : 320.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("Hoàn tất chỉ đường", style: AppText.primary1Text28,),
          Text("Bạn hài lòng với hệ thống chỉ đường/định vị chứ?", style: AppText.blackText16Bold,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  if (choose == 1) {
                    setState(() {
                      choose = 0;
                    });
                  } else {
                    setState(() {
                      choose = 1;
                    });
                  }
                },
                child: Container(
                  child: FaIcon(FontAwesomeIcons.faceFrown, size: 80.w, color: (choose == 1) ? Colors.amber : Colors.grey,),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  child: FaIcon(FontAwesomeIcons.faceSmile, size: 80.w, color: (choose == 2) ? Colors.amber : Colors.grey,),
                ),
              ),
            ],
          ),
          (choose == 1)
              ? Container(
            height: 100.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Hãy báo cáo trải nghiệm của bạn để giúp chúng tôi nâng cao chất lượng hệ thống nhé!", style: AppText.blackText16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 45.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor2,
                          borderRadius: BorderRadius.all(Radius.circular(20.r)),
                        ),
                        child: Center(child: Text("Hủy", style: AppText.blackText18,),),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.locationReportMainScreen, arguments: widget.id);
                      },
                      child: Container(
                        height: 45.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor1,
                          borderRadius: BorderRadius.all(Radius.circular(20.r)),
                        ),
                        child: Center(child: Text("Báo cáo", style: AppText.white100Text18,),),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
              : Container(),
        ],
      ))
      : Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      height: (choose != 1) ? 330.h : 400.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("Hoàn tất chỉ đường", style: AppText.primary1Text28,),
          Container(
            height: 120.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                      text: 'Nhà vệ sinh đang đầy. Vui lòng chờ trong ',
                      style: TextStyle(fontSize: 16.sp, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: widget.waitTime.toString() + " phút!",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]
                  ),
                ),
                SizedBox(height: 15.h,),
                Text("Tìm nhà vệ sinh gần nhất:", style: AppText.blackText18,),
                SizedBox(
                  height: 35.h,
                  width: 80.w,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      elevation: 1,
                      backgroundColor: AppColor.primaryColor1,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                    ),
                    onPressed: () async {
                      QuickAlert.show(
                          context: context,
                          type: QuickAlertType.loading,
                          title: 'Đang tải dữ liệu',
                          barrierDismissible: false
                      );

                      Toilet? toilet1 = await ToiletRepository().getNearestToilet();
                      Navigator.pop(context);
                      if (toilet1 == null) {
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Chú ý'),
                              content: const Text('Không tìm thấy nhà vệ sinh phù hợp!'),
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
                        Navigator.pushNamed(context, Routes.directionMainScreen, arguments: toilet1!.id);
                      }
                    },
                    child: Text('Khẩn cấp', style: AppText.titleText1),
                  ),
                ),
              ],
            ),
          ),
          Text("Bạn hài lòng với hệ thống chỉ đường/định vị chứ?", style: AppText.blackText16Bold,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  if (choose == 1) {
                    setState(() {
                      choose = 0;
                    });
                  } else {
                    setState(() {
                      choose = 1;
                    });
                  }
                },
                child: Container(
                  child: FaIcon(FontAwesomeIcons.faceFrown, size: 80.w, color: (choose == 1) ? Colors.amber : Colors.grey,),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  child: FaIcon(FontAwesomeIcons.faceSmile, size: 80.w, color: (choose == 2) ? Colors.amber : Colors.grey,),
                ),
              ),
            ],
          ),
          (choose == 1)
              ? Container(
            height: 100.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Hãy báo cáo trải nghiệm của bạn để giúp chúng tôi nâng cao chất lượng hệ thống nhé!", style: AppText.blackText16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 45.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor2,
                          borderRadius: BorderRadius.all(Radius.circular(20.r)),
                        ),
                        child: Center(child: Text("Hủy", style: AppText.blackText18,),),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.locationReportMainScreen, arguments: widget.id);
                      },
                      child: Container(
                        height: 45.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor1,
                          borderRadius: BorderRadius.all(Radius.circular(20.r)),
                        ),
                        child: Center(child: Text("Báo cáo", style: AppText.white100Text18,),),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
              : Container(),
        ],
      ));
  }
}
