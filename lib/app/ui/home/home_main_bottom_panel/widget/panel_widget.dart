

import 'package:flutter/material.dart';
import 'package:toiletmap/app/ui/home/home_main_bottom_panel/widget/toilet_in_list_frame.dart';

import '../../../../utils/constants.dart';

class PanelWidget extends StatelessWidget {

  const PanelWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: AppBoxDecoration.boxDecoration3,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: AppSize.heightScreen / 10,
              decoration: AppBoxDecoration.boxDecoration4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      height: AppNumber.h200,
                      width: AppSize.widthScreen / 3,
                      decoration: AppBoxDecoration.boxDecoration2
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: AppNumber.h50,right: AppNumber.h50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Nhà vệ sinh gần đây", style: AppText.titleText2,),
                        Row(
                          children: [
                            Icon(Icons.filter_alt),
                            Text('Lọc'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            buildNearbyToiletList(),
          ],
        )
    );
  }

  Widget buildNearbyToiletList(){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ToiletInListFrame(),
          ToiletInListFrame(),
          ToiletInListFrame(),
          ToiletInListFrame(),
          ToiletInListFrame(),
          ToiletInListFrame(),
        ],
      ),
    );
  }

}
