import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toiletmap/app/repositories/toilet_repository.dart';
import 'package:toiletmap/app/ui/home/home_main_map/widget/images_frame.dart';

import '../../../../models/toilet/toilet.dart';
import '../../../../models/toilet/toiletArgument.dart';
import '../../../../models/toilet/toiletFacilities/toiletFacilities.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/routes.dart';

class BottomSheetToiletInfo extends StatelessWidget {
  int id;

  BottomSheetToiletInfo({Key? key, required this.id}) : super(key: key);

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

            int showerRoom = 0;
            int normalRoom = 0;
            int disabilityRoom = 0;
            List<ToiletFacilities> list = [];

            snapshot.data!.toiletFacilities.forEach((element) {
              if (element.facilityName == "Phòng vệ sinh") {
                normalRoom = element.quantity;
              }
              if (element.facilityName == "Phòng vệ sinh dành cho người khuyết tật") {
                disabilityRoom = element.quantity;
              }
              if (element.facilityName == "Phòng tắm") {
                showerRoom = element.quantity;
              }
            });


            snapshot.data!.toiletFacilities.forEach((element) {
              if (element.facilityType != "Phòng" && element.quantity > 0) {
                list.add(element);
              }
            });

            return Container(
              height: 600.h,
              padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 10.h,
              ),
              decoration: AppBoxDecoration.boxDecoration4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      height: 3.h,
                      width: 120.w,
                      decoration: AppBoxDecoration.boxDecoration2
                  ),
                  SizedBox(height: 20.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 6,
                          child: Text(snapshot.data!.toiletName, maxLines: 2, overflow: TextOverflow.ellipsis, style: AppText.bottomSheetToiletInfo1,),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.toiletDetailMainScreen,
                                arguments: ToiletArgument(
                                    snapshot.data!.id,
                                    snapshot.data!.toiletImageSources,
                                    snapshot.data!.openTime + " - " +
                                        snapshot.data!.closeTime,
                                    snapshot.data!.toiletName,
                                    (snapshot.data!.free == false)
                                        ? '${snapshot.data!.minPrice} - ${snapshot.data!.maxPrice} VND/lượt'
                                        : 'Miễn phí',
                                    snapshot.data!.address + ", " +
                                        snapshot.data!.ward + ", " +
                                        snapshot.data!.district + ", " +
                                        snapshot.data!.province,
                                    snapshot.data!.ratingStar,
                                    (snapshot.data!.nearBy == null) ? '' : snapshot.data!.nearBy,
                                    showerRoom,
                                    normalRoom,
                                    disabilityRoom,
                                    list)
                            );
                          },
                          child: Icon(Icons.upload_file, size: 20.w,),
                        )
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Text(snapshot.data!.ratingStar.toString(), style: AppText.bottomSheetToiletInfo2,),
                            Icon(Icons.star, size: 15.w, color: Colors.yellow,),
                          ],
                        )
                      ),
                    ]
                  ),
                  SizedBox(height: 20.h,),
                  Row(
                    children: [
                      Icon(Icons.location_on_sharp, size: 15.w,),
                      Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(left: 15.w,),
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
                  SizedBox(height: 20.h,),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 15.w,),
                      Padding(
                        padding: EdgeInsets.only(left: 15.w,),
                        child: Text(snapshot.data!.openTime + " - " +
                            snapshot.data!.closeTime, style: AppText.bottomSheetToiletInfo2,),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h,),
                  Row(
                    children: [
                      FaIcon(FontAwesomeIcons.moneyBill, size: 13.w,),
                      Padding(padding: EdgeInsets.only(left: 15.w,),
                        child: Text((snapshot.data!.free == false)
                            ? '${snapshot.data!.minPrice} - ${snapshot.data!.maxPrice} VND/lượt'
                            : 'Miễn phí', style: AppText.bottomSheetToiletInfo2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h,),
                  ImagesFrame(imageSource: snapshot.data!.toiletImageSources,),
                  SizedBox(height: 20.h,),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 90.w),
                    child: SizedBox(
                    width: double.infinity,
                    height: 45.h,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                            primary: AppColor.primaryColor2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r))),
                        onPressed: () async {
                          Navigator.pushNamed(context, Routes.directionMainScreen, arguments: id);
                        },
                        child: Text("Đến nhà vệ sinh", style: AppText.bottomSheetToiletInfo2,)
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
