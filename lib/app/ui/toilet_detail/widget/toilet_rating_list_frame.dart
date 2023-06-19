import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toiletmap/app/repositories/rating_repository.dart';
import 'package:toiletmap/app/ui/rating/widget/rating_frame_widget.dart';

import '../../../models/rating/rating.dart';
import '../../../models/rating/rating_response.dart';
import '../../../utils/constants.dart';

class ToiletRatingListFrame extends StatelessWidget {
  //in this code we will use the widget rating frame from the rating folder ///

  final List<RatingResponse> ratings;

  ToiletRatingListFrame({Key? key, required this.ratings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: ratings.length,
            itemBuilder: (BuildContext context, int index) {
              RatingResponse rating = ratings[index];
              return Container(
                padding: EdgeInsets.only(top: 2.h),
                child: RatingFrameWidget(rating: rating,),
              );
            },
          ),
        ],
      );
  }
}
