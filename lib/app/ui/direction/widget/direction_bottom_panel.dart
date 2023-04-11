import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
              height: AppSize.heightScreen * 1/3.4,
              padding: EdgeInsets.symmetric(
                  horizontal: AppSize.widthScreen / 20,
                  vertical: AppSize.widthScreen / 40
              ),
              decoration: AppBoxDecoration.boxDecoration4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: AppNumber.h80,),
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
                                Icon(Icons.star, size: AppNumber.h40, color: Colors.yellow,),
                              ],
                            )
                        ),
                      ]
                  ),
                  SizedBox(height: AppNumber.h60,),
                  Row(
                    children: [
                      Icon(Icons.location_on_sharp, size: AppNumber.h40,),
                      Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(left: AppSize.widthScreen / 25,),
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
                  SizedBox(height: AppNumber.h80,),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: AppNumber.h40,),
                      Padding(
                        padding: EdgeInsets.only(left: AppSize.widthScreen / 25,),
                        child: Text(snapshot.data!.openTime + " - " +
                            snapshot.data!.closeTime, style: AppText.bottomSheetToiletInfo2,),
                      ),
                    ],
                  ),
                  SizedBox(height: AppNumber.h80,),
                  Row(
                    children: [
                      FaIcon(FontAwesomeIcons.moneyBill, size: AppNumber.h45,),
                      Padding(padding: EdgeInsets.only(left: AppSize.widthScreen / 25,),
                        child: Text((snapshot.data!.free == false)
                            ? '${snapshot.data!.minPrice} - ${snapshot.data!.maxPrice} VND/lượt'
                            : 'Miễn phí', style: AppText.bottomSheetToiletInfo2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppNumber.h60,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSize.widthScreen / 3),
                    child: SizedBox(
                      width: double.infinity,
                      height: AppNumber.h20,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: AppColor.primaryColor2,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(AppSize.widthScreen / 10))),
                          onPressed: () async {
                            Navigator.pushNamed(context, Routes.homeMainScreen);
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
