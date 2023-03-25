import 'package:flutter/material.dart';
import 'package:toiletmap/app/ui/home/home_main_appbar/widget_ver3/home_appbar_action_frame.dart';

import '../../../utils/constants.dart';
import '../../../utils/routes.dart';

class HomeMainAppbarVer3 extends StatelessWidget {
  const HomeMainAppbarVer3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.heightScreen / 3.8,
      child: AppBar(
        shape: AppShapeBorder.shapeBorder1,
        elevation: 10,

        leading: InkWell(
          onTap: () => {
            Navigator.pushNamed(context, Routes.informationMainScreen),
          },
          child: Icon(Icons.person, size: AppSize.widthScreen / 15, color: Colors.white,),
        ),

        titleSpacing: 0,
        title: Text('Xin chào Pé Quân', style: TextStyle(fontSize: AppNumber.h45),),

        actions: [
          InkWell(
            onTap: () => {
              Navigator.pushNamed(context, Routes.historyMainScreen),
            },
            child: Icon(Icons.history, size: AppSize.widthScreen / 15, color: Colors.white,),
          ),
          Padding(padding: EdgeInsets.only(right: AppSize.widthScreen / 30))
        ],

        flexibleSpace: Container(
            decoration: AppBoxDecoration.boxDecorationWithGradient1
        ),


        bottom: PreferredSize(
            preferredSize: Size.fromHeight(AppSize.heightScreen / 4),
            child: Container(
              padding: EdgeInsets.only(
                left: AppSize.widthScreen / 40,
                right: AppSize.widthScreen / 40,
                bottom: AppSize.widthScreen / 30,
              ),
              child: ActionFrame(),
            ),
        ),
      ),
    );
  }
}