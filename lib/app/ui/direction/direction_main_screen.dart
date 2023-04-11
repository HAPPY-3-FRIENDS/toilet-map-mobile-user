import 'package:flutter/material.dart';
import 'package:toiletmap/app/ui/direction/widget/direction_bottom_panel.dart';
import 'package:toiletmap/app/ui/direction/widget/direction_map_frame.dart';

import '../../utils/constants.dart';

class DirectionMainScreen extends StatelessWidget {
  int id;

  DirectionMainScreen({required this.id, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("This is direction screen: " + id.toString());

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
                  automaticallyImplyLeading: false,

                  title: Text('Chỉ đường'),
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

            body: DirectionMapFrame(id: id,),
            bottomSheet: BottomSheet(
              enableDrag: false,
              shape: AppShapeBorder.shapeBorder2,
              builder: (BuildContext context) {
                return DirectionBottomPanel(id: id,);
              },
              onClosing: () {  },
            )
        )
    );
  }
}
