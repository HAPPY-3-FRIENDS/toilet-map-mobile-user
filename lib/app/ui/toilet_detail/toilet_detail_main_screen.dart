import 'package:flutter/material.dart';
import 'package:toiletmap/app/ui/toilet_detail/widget/detail_images_frame.dart';
import 'package:toiletmap/app/ui/toilet_detail/widget/toilet_information_frame.dart';

import '../../models/toilet/toiletArgument.dart';
import '../../utils/constants.dart';
import '../../utils/routes.dart';

class ToiletDetailMainScreen extends StatelessWidget {
  ToiletArgument toiletArgument;

  ToiletDetailMainScreen({
    required this.toiletArgument,
    Key? key}) : super(key: key);

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

              title: Text('Thông tin'),
              titleTextStyle: AppText.appbarTitleText1,
              centerTitle: true,
              toolbarHeight: AppSize.heightScreen / 10,
              elevation: 0,

              flexibleSpace: Container(
                height: AppSize.heightScreen / 10,
                decoration: AppBoxDecoration.boxDecorationWithGradient1,
              ),
            ),
          ),
        ),

        floatingActionButton: FloatingActionButton.extended(
          foregroundColor: Colors.black,
          backgroundColor: AppColor.primaryColor2,
          label: Text("Đến nhà vệ sinh"),
          onPressed: () {
            Navigator.pushNamed(context, Routes.directionMainScreen, arguments: toiletArgument.id);
          },
          elevation: 0,

        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

        body: SingleChildScrollView(
          child: Container(
            color: AppColor.primaryColor2,
            child: Column(
              children: [
                DetailImagesFrame(imageSource: toiletArgument.toiletImagesList,),
                ToiletInformationFrame(
                  nearBy: toiletArgument.nearBy!,
                  time: toiletArgument.time,
                  disabilityRoom: toiletArgument.disabilityRoom,
                  normalRoom: toiletArgument.normalRoom,
                  showerRoom: toiletArgument.showerRoom,
                  star: toiletArgument.star,
                  price: toiletArgument.price,
                  address: toiletArgument.address,
                  toiletName: toiletArgument.toiletName,
                  toiletFacilities: toiletArgument.facilities,
                ),
                SizedBox(height: AppNumber.h200),
                Container(color: Colors.white, height: AppSize.heightScreen / 3,),
              ],
            ),
          )
        ),
      )
    );
  }
}
