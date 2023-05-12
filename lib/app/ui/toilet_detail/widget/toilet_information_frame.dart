import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../models/toilet/toiletFacilities/toiletFacilities.dart';
import '../../../utils/constants.dart';

class ToiletInformationFrame extends StatelessWidget {
  String toiletName;
  double star;
  String address;
  String time;
  String price;
  String nearBy;
  int showerRoom;
  int normalRoom;
  int disabilityRoom;
  List<ToiletFacilities> toiletFacilities;

  ToiletInformationFrame({
    required this.toiletName,
    required this.star,
    required this.address,
    required this.time,
    required this.price,
    required this.nearBy,
    required this.showerRoom,
    required this.normalRoom,
    required this.disabilityRoom,
    required this.toiletFacilities,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String facilitiesString = '';
    if (toiletFacilities.length == 1)
      facilitiesString += toiletFacilities[0].facilityName;
    if (toiletFacilities.length > 1) {
      ToiletFacilities lastFacility = toiletFacilities.last;
      toiletFacilities.forEach((element) {
        if (element != toiletFacilities.last)
          facilitiesString += element.facilityName + " - ";
      });
      facilitiesString += lastFacility.facilityName;
    }
    if (nearBy.isNotEmpty) {
      return Container(
        color: Colors.white,
        height: 300.h,
        padding: EdgeInsets.all(15.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    flex: 5,
                    child: Container(
                      padding: new EdgeInsets.only(right: 5.w),
                      child: Expanded(
                        child: Text(
                          toiletName,
                          style: AppText.toiletInfoText1,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,),
                      ),
                    )
                ),
                Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(star.toString(), style: AppText.detailText2,),
                      Icon(Icons.star, size: AppNumber.h50, color: Colors.yellow,),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 1.8.w,),
                FaIcon(FontAwesomeIcons.locationDot, size: 12.w,),
                SizedBox(width: 18.w,),
                Expanded(
                  child: Text(
                    address,
                    style: AppText.toiletInfoText2,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,),
                )
              ],
            ),
            Row(
              children: [
                SizedBox(width: 1.8.w,),
                FaIcon(FontAwesomeIcons.locationPin, size: 12.w,),
                SizedBox(width: 18.w,),
                Expanded(
                  child: Text(
                    nearBy,
                    style: AppText.toiletInfoText2,
                    overflow: TextOverflow.ellipsis,),
                )
              ],
            ),
            Row(
              children: [
                FaIcon(FontAwesomeIcons.clock, size: 12.w,),
                SizedBox(width: 18.w,),
                Expanded(
                  child: Text(
                    time,
                    style: AppText.toiletInfoText2,
                    overflow: TextOverflow.ellipsis,),
                )
              ],
            ),
            Row(
              children: [
                FaIcon(FontAwesomeIcons.moneyBill, size: 12.w,),
                SizedBox(width: 14.4.w),
                Expanded(
                  child: Text(
                    price,
                    style: AppText.toiletInfoText2,
                    overflow: TextOverflow.ellipsis,),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: (normalRoom != 0)
                      ? Row(
                    children: [
                      SizedBox(width: 1.8.w,),
                      FaIcon(FontAwesomeIcons.toilet, size: 12.w),
                      SizedBox(width: 18.w,),
                      Text('${normalRoom} phòng', style: AppText.toiletInfoText2),
                      SizedBox(width: 18.w,),
                    ],
                  )
                      : null,
                ),

                Container(
                  child: (showerRoom != 0)
                      ? Row(
                    children: [
                      FaIcon(FontAwesomeIcons.shower, size: 12.w),
                      SizedBox(width: 18.w,),
                      Text('${showerRoom} phòng', style: AppText.toiletInfoText2),
                      SizedBox(width: 18.w,),
                    ],
                  )
                      : null,
                ),

                Container(
                  child: (disabilityRoom != 0)
                      ? Row(
                    children: [
                      FaIcon(FontAwesomeIcons.wheelchair, size: 12.w),
                      SizedBox(width: 18.w,),
                      Text('${disabilityRoom} phòng', style: AppText.toiletInfoText2),
                    ],
                  )
                      : null,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FaIcon(FontAwesomeIcons.toiletPaper, size: 12.w),
                SizedBox(width: 14.w),
                Expanded(
                  child: Text(
                    facilitiesString, style: AppText.toiletInfoText2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
    return Container(
      color: Colors.white,
      height: 260.h,
      padding: EdgeInsets.all(15.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  flex: 5,
                  child: Container(
                    padding: new EdgeInsets.only(right: 5.w),
                    child: Expanded(
                      child: Text(
                        toiletName,
                        style: AppText.toiletInfoText1,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,),
                    ),
                  )
              ),
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(star.toString(), style: AppText.detailText2,),
                    Icon(Icons.star, size: AppNumber.h50, color: Colors.yellow,),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 1.8.w,),
              FaIcon(FontAwesomeIcons.locationDot, size: 12.w,),
              SizedBox(width: 18.w,),
              Expanded(
                child: Text(
                  address,
                  style: AppText.toiletInfoText2,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,),
              )
            ],
          ),
          Row(
            children: [
              FaIcon(FontAwesomeIcons.clock, size: 12.w,),
              SizedBox(width: 18.w,),
              Expanded(
                child: Text(
                  time,
                  style: AppText.toiletInfoText2,
                  overflow: TextOverflow.ellipsis,),
              )
            ],
          ),
          Row(
            children: [
              FaIcon(FontAwesomeIcons.moneyBill, size: 12.w,),
              SizedBox(width: 14.4.w),
              Expanded(
                child: Text(
                  price,
                  style: AppText.toiletInfoText2,
                  overflow: TextOverflow.ellipsis,),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: (normalRoom != 0)
                    ? Row(
                  children: [
                    SizedBox(width: 1.8.w,),
                    FaIcon(FontAwesomeIcons.toilet, size: 12.w),
                    SizedBox(width: 18.w,),
                    Text('${normalRoom} phòng', style: AppText.toiletInfoText2),
                    SizedBox(width: 18.w,),
                  ],
                )
                    : null,
              ),

              Container(
                child: (showerRoom != 0)
                    ? Row(
                  children: [
                    FaIcon(FontAwesomeIcons.shower, size: 12.w),
                    SizedBox(width: 18.w,),
                    Text('${showerRoom} phòng', style: AppText.toiletInfoText2),
                    SizedBox(width: 18.w,),
                  ],
                )
                    : null,
              ),

              Container(
                child: (disabilityRoom != 0)
                    ? Row(
                  children: [
                    FaIcon(FontAwesomeIcons.wheelchair, size: 12.w),
                    SizedBox(width: 18.w,),
                    Text('${disabilityRoom} phòng', style: AppText.toiletInfoText2),
                  ],
                )
                    : null,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FaIcon(FontAwesomeIcons.toiletPaper, size: 12.w),
              SizedBox(width: 14.w),
              Expanded(
                child: Text(
                  facilitiesString, style: AppText.toiletInfoText2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
