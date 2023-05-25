import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toiletmap/app/repositories/rating_repository.dart';
import 'package:toiletmap/app/ui/rating/widget/rating_frame_widget.dart';
import 'package:toiletmap/app/models/toilet/toiletArgument2.dart';
import 'package:toiletmap/app/ui/rating/widget/rating_main_information_frame.dart';
import 'package:toiletmap/app/ui/rating/widget/rating_main_rating_frame.dart';

import '../../models/checkin/checkin.dart';
import '../../models/rating/rating.dart';
import '../../utils/constants.dart';

class RatingMainScreen extends StatefulWidget {
  Checkin checkin;

  RatingMainScreen({Key? key, required this.checkin}) : super(key: key);

  @override
  State<RatingMainScreen> createState() => _RatingMainScreenState();
}

class _RatingMainScreenState extends State<RatingMainScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.h),
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 20.h),
              child: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: AppColor.primaryColor1,
                  ),
                ),

                title: Text('Đánh giá'),
                titleTextStyle: AppText.appbarTitleText2,
                centerTitle: true,
                toolbarHeight: 100.h,
                backgroundColor: Colors.white,
                elevation: 1,

                iconTheme: IconThemeData(
                    color: AppColor.primaryColor1
                ),
              ),
            ),
          ),

          body: SingleChildScrollView(
            child: Column(
              children: [
                RatingMainInformationFrame(toiletId: widget.checkin.toiletId),
                Container(height: 5.h, color: Color(0xFFF1F1F1),),
                RatingMainRatingFrame(checkin: widget.checkin),
              ],
            ),
          ),
      ),
    );
  }
}

