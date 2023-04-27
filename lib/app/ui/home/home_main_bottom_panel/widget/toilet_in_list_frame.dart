import 'package:flutter/material.dart';
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
                  padding: EdgeInsets.all(AppSize.widthScreen / 60),
                  height: AppSize.heightScreen / 3.8,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ClipRRect(
                            borderRadius: BorderRadius.circular(AppSize.heightScreen / 80),
                            child: Image.network(
                              toiletImage,
                              height: AppSize.heightScreen / 4.5,
                              width: AppSize.heightScreen / 6,
                              fit: BoxFit.cover,
                            ),
                          ),
                      SizedBox(width: AppNumber.h100,),
                      Expanded(child: Container(
                        height: AppSize.heightScreen / 4.5,
                        width: AppSize.heightScreen / 3.8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(child: Container(
                                  padding: new EdgeInsets.only(right: AppNumber.w40),
                                  child: Text(toiletName, maxLines: 2, overflow: TextOverflow.ellipsis, style: AppText.detailText1,),
                                )),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(star.toString(), style: AppText.detailText2,),
                                    Icon(Icons.star, size: AppNumber.h60, color: Colors.yellow,),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: AppNumber.h400,),
                                FaIcon(FontAwesomeIcons.moneyBill, size: AppNumber.h100,),
                                SizedBox(width: AppNumber.h400,),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: AppSize.widthScreen / 80),
                                  child: Text(price, style: AppText.detailText4,),
                                )
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.pin_drop, size: AppNumber.h60,),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: AppSize.widthScreen / 80),
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
                              child: (nearBy != null)
                                  ? Row(
                                children: [
                                  SizedBox(width: AppNumber.h200,),
                                  FaIcon(FontAwesomeIcons.locationPin, size: AppNumber.h100,),
                                  SizedBox(width: AppNumber.h400,),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: AppSize.widthScreen / 80),
                                      child: Text(
                                        nearBy!, style: AppText.detailText3,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                                  : null,
                            ),
                            Row(
                              children: [
                                SizedBox(width: AppNumber.h200,),

                                Container(
                                  child: (normalRoom != 0)
                                      ? Row(
                                    children: [
                                      FaIcon(FontAwesomeIcons.toilet, size: AppNumber.h100),
                                      SizedBox(width: AppSize.heightScreen / 150,),
                                      Text('${normalRoom} phòng', style: AppText.detailText3),
                                      SizedBox(width: AppNumber.h300,),
                                    ],
                                  )
                                      : null,
                                ),

                                Container(
                                  child: (showerRoom != 0)
                                      ? Row(
                                    children: [
                                      Icon(Icons.shower, size: AppNumber.h80,),
                                      //SizedBox(width: AppNumber.h400,),
                                      Text('${showerRoom} phòng', style: AppText.detailText3),
                                      SizedBox(width: AppNumber.h300,),
                                    ],
                                  )
                                      : null,
                                ),

                                Container(
                                  child: (disabilityRoom != 0)
                                      ? Row(
                                    children: [
                                      FaIcon(FontAwesomeIcons.wheelchair, size: AppNumber.h80),
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
                                SizedBox(width: AppNumber.h300,),
                                FaIcon(FontAwesomeIcons.toiletPaper, size: AppNumber.h100,),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: AppSize.widthScreen / 80),
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
              Container(height: AppSize.heightScreen / 100, color: AppColor.primaryColor2,)
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
                padding: EdgeInsets.all(AppSize.widthScreen / 60),
                height: AppSize.heightScreen / 3.8,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppSize.heightScreen / 80),
                      child: Image.network(
                        toiletImage,
                        height: AppSize.heightScreen / 4.5,
                        width: AppSize.heightScreen / 6,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: AppNumber.h100,),
                    Expanded(child: Container(
                      height: AppSize.heightScreen / 4.5,
                      width: AppSize.heightScreen / 3.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(child: Container(
                                padding: new EdgeInsets.only(right: AppNumber.w40),
                                child: Text(toiletName, maxLines: 2, overflow: TextOverflow.ellipsis, style: AppText.detailText1,),
                              )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(star.toString(), style: AppText.detailText2,),
                                  Icon(Icons.star, size: AppNumber.h60, color: Colors.yellow,),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(width: AppNumber.h400,),
                              FaIcon(FontAwesomeIcons.moneyBill, size: AppNumber.h100,),
                              SizedBox(width: AppNumber.h400,),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: AppSize.widthScreen / 80),
                                child: Text(price, style: AppText.detailText4,),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.pin_drop, size: AppNumber.h60,),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: AppSize.widthScreen / 80),
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
                              SizedBox(width: AppNumber.h200,),

                              Container(
                                child: (normalRoom != 0)
                                    ? Row(
                                  children: [
                                    FaIcon(FontAwesomeIcons.toilet, size: AppNumber.h100),
                                    SizedBox(width: AppSize.heightScreen / 150,),
                                    Text('${normalRoom} phòng', style: AppText.detailText3),
                                    SizedBox(width: AppNumber.h300,),
                                  ],
                                )
                                    : null,
                              ),

                              Container(
                                child: (showerRoom != 0)
                                    ? Row(
                                  children: [
                                    Icon(Icons.shower, size: AppNumber.h80,),
                                    //SizedBox(width: AppNumber.h400,),
                                    Text('${showerRoom} phòng', style: AppText.detailText3),
                                    SizedBox(width: AppNumber.h300,),
                                  ],
                                )
                                    : null,
                              ),

                              Container(
                                child: (disabilityRoom != 0)
                                    ? Row(
                                  children: [
                                    FaIcon(FontAwesomeIcons.wheelchair, size: AppNumber.h80),
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
                              SizedBox(width: AppNumber.h300,),
                              FaIcon(FontAwesomeIcons.toiletPaper, size: AppNumber.h100,),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: AppSize.widthScreen / 80),
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
            Container(height: AppSize.heightScreen / 100, color: AppColor.primaryColor2,)
          ],
        )
    );
  }
}
