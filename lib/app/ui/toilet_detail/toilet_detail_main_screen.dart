import 'package:flutter/material.dart';
import 'package:toiletmap/app/ui/toilet_detail/widget/image_carousel_widget.dart';
import 'package:toiletmap/app/ui/toilet_detail/widget/toilet_information_frame.dart';

import '../../utils/constants.dart';

class ToiletDetailMainScreen extends StatelessWidget {
  const ToiletDetailMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppSize.heightScreen / 10),
          child: Container(
            height: AppSize.heightScreen / 10,
            color: AppColor.primaryColor2,
            child: AppBar(
              shape: AppShapeBorder.shapeBorder1,

              title: Text('Thông tin'),
              titleTextStyle: AppText.appbarTitleText1,
              centerTitle: true,
              toolbarHeight: AppSize.heightScreen / 10,
              elevation: 5,

              flexibleSpace: Container(
                height: AppSize.heightScreen / 10,
                decoration: AppBoxDecoration.boxDecorationWithGradient1,
              ),
            ),
          ),
        ),

        body: SingleChildScrollView(
          child: Container(
            color: AppColor.primaryColor2,
            child: Column(
              children: [
                ImageCarouselWidget(),
                SizedBox(height: AppNumber.h80),
                ToiletInformationFrame(),
                SizedBox(height: AppNumber.h80),
                Container(color: Colors.white, height: AppSize.heightScreen / 3,),
              ],
            ),
          )
        ),
      )
    );
  }
}
