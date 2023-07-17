import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toiletmap/app/ui/search/search_map_screen_widget/search_map_bottom_panel.dart';
import 'package:toiletmap/app/ui/search/search_map_screen_widget/search_map_map.dart';
import 'package:toiletmap/app/utils/routes.dart';

import '../../models/placeDetail/place_detail.dart';
import '../../utils/constants.dart';

class SearchMapScreen extends StatefulWidget {
  PlaceDetail placeDetail;

  SearchMapScreen({Key? key, required this.placeDetail}) : super(key: key);

  @override
  State<SearchMapScreen> createState() => _SearchMapScreenState();
}

class _SearchMapScreenState extends State<SearchMapScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(170.h),
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 20.h),
              child: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: AppColor.primaryColor1,
                  ),
                ),

                title: Text('Tìm kiếm'),
                titleTextStyle: AppText.appbarTitleText2,
                centerTitle: true,
                toolbarHeight: 170.h,
                backgroundColor: Colors.white,
                elevation: 1,

                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Routes.homeMainScreen);
                    },
                    icon: Icon(
                      Icons.home_rounded,
                      color: AppColor.primaryColor1,
                    ),
                  ),
                ],

                iconTheme: IconThemeData(
                    color: AppColor.primaryColor1
                ),

                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(70.h),
                  child: Container(
                    padding: EdgeInsets.all(10.w),
                    child: Expanded(
                      child: RichText(
                        maxLines: 3,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,

                        text: TextSpan(
                          children: [
                            TextSpan(text: 'Địa điểm tìm kiếm: ', style: AppText.blackText16Bold),
                            TextSpan(text: widget.placeDetail.result.name + ", " + widget.placeDetail.result.formatted_address, style: AppText.blackText16)
                          ]
                        ),
                      )
                    )
                  ),
                ),
              ),
            ),
          ),
            body: Stack(
              children: [
                SearchMapMap(placeDetail: widget.placeDetail,),
                SearchMapBottomPanel(placeDetail: widget.placeDetail),
              ],
            )
        ),
    );
  }
}
