import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:toiletmap/app/ui/home/home_main_bottom_panel/widget/panel_widget.dart';
import 'package:toiletmap/app/ui/home/home_main_bottom_panel/widget/panel_widget_search.dart';

import '../../../models/placeDetail/place_detail.dart';
import '../../../utils/constants.dart';

class SearchMapBottomPanel extends StatefulWidget {
  PlaceDetail placeDetail;

  SearchMapBottomPanel({Key? key, required this.placeDetail}) : super(key: key);

  @override
  State<SearchMapBottomPanel> createState() => _SearchMapBottomPanelState();
}

class _SearchMapBottomPanelState extends State<SearchMapBottomPanel> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        child: SlidingUpPanel(
          panelSnapping: true,
          renderPanelSheet: true,

          minHeight: 80.h,
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.transparent,
          backdropEnabled: true,
          panel: PanelWidgetSearch(placeDetail: widget.placeDetail),
          collapsed: Container(
            height: 80.h,
            decoration: AppBoxDecoration.boxDecorationWithGradient2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: 4.h,
                    width: 120.w,
                    decoration: AppBoxDecoration.boxDecoration2
                ),
                Center(
                  child: Text('Hiển thị danh sách nhà vệ sinh gần đây', style: AppText.titleText1,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    /*Container(
      child: SlidingUpPanel(
        color: Colors.transparent,
        //backdropEnabled: true,
        panel: PanelWidget(),
        collapsed: Container(
          height: 20,
          decoration: AppBoxDecoration.boxDecorationWithGradient2,
          child: Center(
            child: Text('Slide to more features'),
          ),
        ),
      ),
    );*/
  }
}
