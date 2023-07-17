import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quickalert/quickalert.dart';
import 'package:toiletmap/app/repositories/toilet_repository.dart';
import 'package:toiletmap/app/ui/home/home_main_map/widget/images_frame.dart';

import '../../../models/toilet/toilet.dart';
import '../../../models/toilet/toiletFacilities/toiletFacilities.dart';
import '../../../utils/constants.dart';
import '../../../utils/routes.dart';

class DirectionBottomPanel extends StatelessWidget {
  int id;

  DirectionBottomPanel({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Toilet?> (
        future: ToiletRepository().getToiletByToiletId(id),
        builder: (context, snapshot)  {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
                    color: AppColor.primaryColor1,
                    strokeWidth: 2.0
                )
            );
          }
          if (snapshot.hasData) {

            int showerRoom = snapshot.data!.toiletFacilities[0].quantity;
            int normalRoom = snapshot.data!.toiletFacilities[1].quantity;
            int disabilityRoom = snapshot.data!.toiletFacilities[2].quantity;
            List<ToiletFacilities> list = [];
            snapshot.data!.toiletFacilities.forEach((element) {
              if (element.facilityType != "Phòng" && element.quantity > 0) {
                list.add(element);
              }
            });

            return Container(
              height: 270.h,
              padding: EdgeInsets.symmetric(
                  horizontal: 18.w,
                  vertical: 9.w
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.r),
                    topLeft: Radius.circular(10.r)
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h,),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 8,
                          child: Text(snapshot.data!.toiletName, maxLines: 2, overflow: TextOverflow.ellipsis, style: AppText.bottomSheetToiletInfo1,),
                        ),
                        Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Text(snapshot.data!.ratingStar.toString(), style: AppText.bottomSheetToiletInfo2,),
                                Icon(Icons.star, size: 18.w, color: Colors.amber,),
                              ],
                            )
                        ),
                      ]
                  ),
                  SizedBox(height: 10.h,),
                  Row(
                    children: [
                      Icon(Icons.location_on_sharp, size: 15.w,),
                      Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(left: 14.4.w,),
                            child: Text(
                              snapshot.data!.address + ", " +
                                  snapshot.data!.ward + ", " +
                                  snapshot.data!.district + ", " +
                                  snapshot.data!.province,
                              maxLines: 3,
                              style: AppText.bottomSheetToiletInfo2,
                            )
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10.h,),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 15.w,),
                      Padding(
                        padding: EdgeInsets.only(left: 14.4.w,),
                        child: Text(snapshot.data!.openTime + " - " +
                            snapshot.data!.closeTime, style: AppText.bottomSheetToiletInfo2,),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h,),
                  Row(
                    children: [
                      FaIcon(FontAwesomeIcons.moneyBill, size: 15.w,),
                      Padding(padding: EdgeInsets.only(left: 14.4.w,),
                        child: Text((snapshot.data!.free == false)
                            ? '${snapshot.data!.minPrice} - ${snapshot.data!.maxPrice} VND/lượt'
                            : 'Miễn phí', style: AppText.bottomSheetToiletInfo2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 120.w),
                    child: SizedBox(
                      width: double.infinity,
                      height: 45.h,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: AppColor.primaryColor2,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r))),
                          onPressed: () async {
                            Navigator.pushReplacementNamed(context, Routes.homeMainScreen);

                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.info,
                              text: 'Buy two, get one free',
                              title: 'Hệ thống chỉ đường',
                              onConfirmBtnTap: () {
                                print('toilet id:: ' + id.toString());
                              }
                            );
                          },
                          child: Text("Hoàn tất", style: AppText.bottomSheetToiletInfo2,)
                      ),
                    ),)
                ],
              ),
            );
          }
          return Center(child: Text('Lỗi'));
        }
    );
  }
}
