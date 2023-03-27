import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toiletmap/app/utils/constants.dart';

import '../../../../utils/routes.dart';

class ToiletInListFrame extends StatelessWidget {
  const ToiletInListFrame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.pushNamed(context, Routes.toiletDetailMainScreen),
      },
      child: Column(
        children: [
          Container(
              decoration: AppBoxDecoration.boxDecoration1,
              height: AppSize.heightScreen / 4.7,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppSize.heightScreen / 80),
                    child: Image.network(
                      "https://images.unsplash.com/photo-1556228149-d8f523f77b5a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
                      height: AppSize.heightScreen / 6,
                      width: AppSize.heightScreen / 6,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: AppNumber.h100,),
                  Container(
                    height: AppSize.heightScreen / 6.1,
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
                              child: Text('Nhà vệ sinh quận 7', overflow: TextOverflow.ellipsis, style: AppText.detailText1,),
                            )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('4.8', style: AppText.detailText2,),
                                Icon(Icons.star, size: AppNumber.h60,),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            FaIcon(FontAwesomeIcons.moneyBill, size: 8,),
                            SizedBox(width: AppNumber.h400,),
                            Text('2.000 - 8.000 VND/lượt', style: AppText.detailText4,),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.pin_drop, size: 10,),
                            Text('200m', style: AppText.detailText3),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: AppNumber.h400,),
                            FaIcon(FontAwesomeIcons.locationPin, size: 8,),
                            SizedBox(width: AppNumber.h400,),
                            Text('Gần Circle K, Phúc Long', style: AppText.detailText3),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: AppNumber.h400,),
                            FaIcon(FontAwesomeIcons.toilet, size: 8),
                            SizedBox(width: AppNumber.h400,),
                            Text('4 phòng', style: AppText.detailText3),

                            SizedBox(width: AppNumber.h300,),
                            Icon(Icons.circle, size: AppNumber.h200,),
                            SizedBox(width: AppNumber.h300,),

                            Icon(Icons.shower, size: 10,),
                            Text('2 phòng', style: AppText.detailText3),

                            SizedBox(width: AppNumber.h300,),
                            Icon(Icons.circle, size: AppNumber.h200,),
                            SizedBox(width: AppNumber.h300,),

                            FaIcon(FontAwesomeIcons.wheelchair, size: 10),
                            Text('Không có', style: AppText.detailText3),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.pin_drop, size: 10,),
                            Text('Vòi xịch', style: AppText.detailText3),
                            SizedBox(width: AppNumber.h300,),
                            Icon(Icons.circle, size: AppNumber.h200,),
                            SizedBox(width: AppNumber.h300,),
                            Text('Thiết bị hong khô', style: AppText.detailText3),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )
          ),
          SizedBox(height: AppNumber.h100,),
        ],
      )
    );
  }
}
