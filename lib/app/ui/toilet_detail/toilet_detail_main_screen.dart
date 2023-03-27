import 'package:flutter/material.dart';
import 'package:toiletmap/app/ui/toilet_detail/widget/image_carousel_widget.dart';

import '../../utils/constants.dart';

class ToiletDetailMainScreen extends StatelessWidget {
  const ToiletDetailMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: AppSize.heightScreen / 6),
            child: Container(
                color: AppColor.primaryColor2,
              child: Column(
                children: [
                  ImageCarouselWidget(),
                  SizedBox(height: AppNumber.h60),
                  Container(
                    height: AppSize.heightScreen / 2,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            color: Colors.white,
                            height: AppSize.heightScreen / 3,
                          ),
                          SizedBox(height: AppNumber.h60),
                          Container(
                            color: Colors.white,
                            height: AppSize.heightScreen / 3,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          //This is AppBar
          Container(
            height: AppSize.heightScreen / 6,
            color: AppColor.primaryColor2,
            child: AppBar(
              shape: AppShapeBorder.shapeBorder1,

              title: Text('Thông tin'),
              titleTextStyle: AppText.appbarTitleText1,
              centerTitle: true,
              toolbarHeight: AppSize.heightScreen / 6,
              elevation: 5,

              flexibleSpace: Container(
                height: AppSize.heightScreen / 6,
                decoration: AppBoxDecoration.boxDecorationWithGradient1,
              ),
            ),
          ),
        ],
      )
    );
  }
}
