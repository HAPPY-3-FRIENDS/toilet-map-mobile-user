import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toiletmap/app/models/toilet/toiletArgument.dart';
import 'package:toiletmap/app/utils/constants.dart';

import '../../../../models/toilet/toiletFacilities/toiletFacilities.dart';
import '../../../../utils/routes.dart';

class ToiletInListFrame extends StatelessWidget {
  int toiletId;
  List<String> toiletImagesList;
  String time;
  String toiletImage;
  String toiletName;
  String price;
  String address;
  double star;
  String? nearBy;
  int showerRoom;
  int normalRoom;
  int disabilityRoom;
  List<ToiletFacilities> facilities;

  ToiletInListFrame({
    required this.toiletId,
    required this.time,
    required this.toiletImagesList,
    required this.toiletImage,
    required this.toiletName,
    required this.price,
    required this.address,
    required this.star,
    required this.nearBy,
    required this.showerRoom,
    required this.normalRoom,
    required this.disabilityRoom,
    required this.facilities,

    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String facilitiesString = '';
    if (facilities.length == 1)
      facilitiesString += facilities[0].facilityName;
    if (facilities.length > 1) {
      ToiletFacilities lastFacility = facilities.last;
      facilities.forEach((element) {
        if (element != facilities.last)
        facilitiesString += element.facilityName + " - ";
      });
      facilitiesString += lastFacility.facilityName;
    }

    if (nearBy != null) {
      return InkWell(
          onTap: () => {
            Navigator.pushNamed(context, Routes.toiletDetailMainScreen,
                arguments: ToiletArgument(
                    toiletId,
                    toiletImagesList,
                    time,
                    toiletName,
                    price,
                    address,
                    star,
                    nearBy,
                    showerRoom,
                    normalRoom,
                    disabilityRoom,
                    facilities)
            ),
          },
          child: Column(
            children: [
              Container(
                  decoration: AppBoxDecoration.boxDecoration1,
                  padding: EdgeInsets.all(10.r),
                  height: 220.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CachedNetworkImage(
                        imageUrl: toiletImage,
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Container(
                          height: 200.h,
                          width: 130.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            image: DecorationImage(
                              image: AssetImage("assets/images/nearby-toilets-no-image.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                          imageBuilder: (context, imageProvider) => Container(
                            height: 200.h,
                            width: 130.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                              ),
                            ),
                          )
                      ),
                      SizedBox(width: 3.w,),
                      Expanded(child: Container(
                        padding: EdgeInsets.only(left: 5.w),
                        height: 200.h,
                        width: 95.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(child: Container(
                                  padding: new EdgeInsets.only(right: 9.w),
                                  child: Text(toiletName, maxLines: 2, overflow: TextOverflow.ellipsis, style: AppText.detailText1,),
                                )),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(star.toString(), style: AppText.detailText2,),
                                    Icon(Icons.star, size: 10.w, color: Colors.yellow,),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: 2.5.w,),
                                FaIcon(FontAwesomeIcons.moneyBill, size: 10.w,),
                                SizedBox(width: 3.5.w,),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 0.75.w),
                                  child: Text(price, style: AppText.detailText4,),
                                )
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.pin_drop, size: 15.w,),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 4.5.w),
                                    child: Text(
                                      address, style: AppText.detailText3,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              child: Row(
                                children: [
                                  SizedBox(width: 4.w,),
                                  FaIcon(FontAwesomeIcons.locationPin, size: 10.w,),
                                  SizedBox(width: 2.w,),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 4.5.w),
                                      child: Text(
                                        nearBy!, style: AppText.detailText3,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(width: 3.5.w,),

                                Container(
                                  child: (normalRoom != 0)
                                      ? Row(
                                    children: [
                                      FaIcon(FontAwesomeIcons.toilet, size: 10.w),
                                      SizedBox(width: 6.w,),
                                      Text('${normalRoom} phòng', style: AppText.detailText3),
                                      SizedBox(width: 3.w,),
                                    ],
                                  )
                                      : null,
                                ),

                                Container(
                                  child: (showerRoom != 0)
                                      ? Row(
                                    children: [
                                      Icon(Icons.shower, size: 10.w,),
                                      //SizedBox(width: AppNumber.h400,),
                                      Text('${showerRoom} phòng', style: AppText.detailText3),
                                      SizedBox(width: 6.w,),
                                    ],
                                  )
                                      : null,
                                ),

                                Container(
                                  child: (disabilityRoom != 0)
                                      ? Row(
                                    children: [
                                      FaIcon(FontAwesomeIcons.wheelchair, size: 10.w),
                                      //SizedBox(width: AppNumber.h400,),
                                      Text('${disabilityRoom} phòng', style: AppText.detailText3, overflow: TextOverflow.fade),
                                    ],
                                  )
                                      : null,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: 2.5.w,),
                                FaIcon(FontAwesomeIcons.toiletPaper, size: 10.w),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                                    child: Text(
                                      facilitiesString, style: AppText.detailText3,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ))
                    ],
                  )
              ),
              Container(height: 10.h, color: AppColor.appBackground,)
            ],
          )
      );
    }
    return InkWell(
        onTap: () => {
          Navigator.pushNamed(context, Routes.toiletDetailMainScreen, arguments: ToiletArgument(
              toiletId,
              toiletImagesList,
              time,
              toiletName,
              price,
              address,
              star,
              '',
              showerRoom,
              normalRoom,
              disabilityRoom,
              facilities)),
        },
        child: Column(
          children: [
            Container(
                decoration: AppBoxDecoration.boxDecoration1,
                padding: EdgeInsets.all(10.r),
                height: 220.h,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CachedNetworkImage(
                        imageUrl: toiletImage,
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Container(
                          height: 200.h,
                          width: 130.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            image: DecorationImage(
                              image: AssetImage("assets/images/nearby-toilets-no-image.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        imageBuilder: (context, imageProvider) => Container(
                          height: 200.h,
                          width: 130.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                    ),
                    SizedBox(width: 3.w,),
                    Expanded(child: Container(
                      padding: EdgeInsets.only(left: 5.w),
                      height: 200.h,
                      width: 95.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(child: Container(
                                padding: new EdgeInsets.only(right: 9.w),
                                child: Text(toiletName, maxLines: 2, overflow: TextOverflow.ellipsis, style: AppText.detailText1,),
                              )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(star.toString(), style: AppText.detailText2,),
                                  Icon(Icons.star, size: 10.w, color: Colors.yellow,),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(width: 2.5.w,),
                              FaIcon(FontAwesomeIcons.moneyBill, size: 10.w,),
                              SizedBox(width: 3.5.w,),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0.75.w),
                                child: Text(price, style: AppText.detailText4,),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.pin_drop, size: 15.w,),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4.5.w),
                                  child: Text(
                                    address, style: AppText.detailText3,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(width: 3.5.w,),

                              Container(
                                child: (normalRoom != 0)
                                    ? Row(
                                  children: [
                                    FaIcon(FontAwesomeIcons.toilet, size: 10.w),
                                    SizedBox(width: 6.w,),
                                    Text('${normalRoom} phòng', style: AppText.detailText3),
                                    SizedBox(width: 3.w,),
                                  ],
                                )
                                    : null,
                              ),

                              Container(
                                child: (showerRoom != 0)
                                    ? Row(
                                  children: [
                                    Icon(Icons.shower, size: 10.w,),
                                    //SizedBox(width: AppNumber.h400,),
                                    Text('${showerRoom} phòng', style: AppText.detailText3),
                                    SizedBox(width: 6.w,),
                                  ],
                                )
                                    : null,
                              ),

                              Container(
                                child: (disabilityRoom != 0)
                                    ? Row(
                                  children: [
                                    FaIcon(FontAwesomeIcons.wheelchair, size: 10.w),
                                    //SizedBox(width: AppNumber.h400,),
                                    Text('${disabilityRoom} phòng', style: AppText.detailText3, overflow: TextOverflow.fade),
                                  ],
                                )
                                    : null,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(width: 2.5.w,),
                              FaIcon(FontAwesomeIcons.toiletPaper, size: 10.w),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                                  child: Text(
                                    facilitiesString, style: AppText.detailText3,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ))
                  ],
                )
            ),
            Container(height: 10.h, color: AppColor.appBackground,)
          ],
        )
    );
  }
}
