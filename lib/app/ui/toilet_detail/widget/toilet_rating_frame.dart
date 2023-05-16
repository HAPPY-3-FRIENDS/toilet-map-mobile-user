import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toiletmap/app/models/toilet/toiletArgument2.dart';
import 'package:toiletmap/app/repositories/rating_repository.dart';
import 'package:toiletmap/app/ui/rating/widget/rating_frame_widget.dart';

import '../../../models/rating/rating.dart';
import '../../../utils/constants.dart';
import '../../../utils/routes.dart';

class ToiletRatingFrame extends StatelessWidget {
  //in this code we will use the widget rating frame from the rating folder ///

  final double ratingStar;
  final int toiletId;
  final String toiletName;
  final int ratingCount;
  //final List<Rating> ratings;

  ToiletRatingFrame({Key? key, required this.ratingStar, required this.toiletId, required this.ratingCount, required this.toiletName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            height: 100.h,
            padding: EdgeInsets.all(14.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(padding: EdgeInsets.only(left: 1.w), child: Text('Đánh giá nhà vệ sinh', style: AppText.blackText20Bold,),),
                    Row(
                      children: [
                        RatingBar.builder(
                          itemSize: 18.w,
                          initialRating: ratingStar,
                          ignoreGestures: true,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 1.w),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            '${ratingStar}/5.0 (${ratingCount} Đánh giá)',
                            style: AppText.greyText18,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.ratingListScreen, arguments: ToiletArgument2(toiletId, toiletName, ratingStar, ratingCount));
                  },
                  child: Text('Xem thêm', style: AppText.greyText18,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
