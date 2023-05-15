import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:toiletmap/app/utils/constants.dart';

import '../../../models/rating/rating.dart';

class RatingFrameWidget extends StatelessWidget {
  final Rating rating;

  RatingFrameWidget({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      color: Colors.white,
      padding: EdgeInsets.all(20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
              child: CircleAvatar(
                radius: 20.w,
                backgroundImage: AssetImage('assets/default-avatar.png'),
              ),
          ),
          Expanded(
              flex: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(rating.fullName, style: AppText.listText1,),
                  RatingBar.builder(
                    itemSize: 18.w,
                    initialRating: double.parse(rating.star.toString()),
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
                  Text('Mua gói ${rating.comment} lượt', style: AppText.listText3,),
                  Text(rating.dateTime, style: AppText.listText4,),
                ],
              ),
          ),
          Expanded(
              flex: 1,
              child: Icon(Icons.more_horiz, size: 18.w,),
          ),
        ],
      ),
    );
  }
}
