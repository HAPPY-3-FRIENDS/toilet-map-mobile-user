import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:toiletmap/app/models/commonComment/common_comment.dart';
import 'package:toiletmap/app/repositories/common_comment_repository.dart';
import 'package:toiletmap/app/ui/rating/widget/rating_main_rating_frame_widget/common_comments_frame.dart';
import 'package:toiletmap/app/utils/constants.dart';

import '../../../models/checkin/checkin.dart';
import '../../../models/rating/rating.dart';
import '../../../repositories/rating_repository.dart';
import '../../../utils/routes.dart';

class RatingMainRatingFrame extends StatefulWidget {
  Checkin checkin;

  RatingMainRatingFrame({Key? key, required this.checkin}) : super(key: key);

  @override
  State<RatingMainRatingFrame> createState() => _RatingMainRatingFrameState();
}

class _RatingMainRatingFrameState extends State<RatingMainRatingFrame> {
  String comment = '';
  int star = 0;
  List<String> imageSources = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Đánh giá", style: AppText.blackText20,),
                SizedBox(width: 30.w,),
                RatingBar.builder(
                  itemSize: 25.w,
                  initialRating: 0,
                  ignoreGestures: false,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 1.w),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    star = rating.toInt();
                    print(rating);
                  },
                ),
              ],
            ),
            SizedBox(height: 20.h,),
            Text("Báo cáo nhà vệ sinh", style: AppText.blackText20,),
            SizedBox(height: 10.h,),
            const CommonCommentsFrame(),
            SizedBox(height: 20.h,),
            Text("Viết đánh giá", style: AppText.blackText20,),
            SizedBox(
              height: 100.h,
              child: TextField(
                onChanged: (value) => setState(() => {
                  comment = value
                }),
                maxLines: null,
                expands: true, // and this
                keyboardType: TextInputType.multiline,
                maxLength: 500,
              ),
            ),
            SizedBox(height: 20.h,),
            Text("Thêm ảnh", style: AppText.blackText20,),
            SizedBox(height: 20.h,),
            Container(
              height: 80.w,
              width: 80.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: Color(0xFFF1F1F1), width: 2.w),
                  color: Color(0xFFF1F1F1)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.add_circle_outline_rounded, size: 20.w, color: Colors.black54,)
                ],
              ),
            ),
            SizedBox(height: 20.h,),
            Align(
              alignment: Alignment.center,
              child: FloatingActionButton.extended(
                foregroundColor: Colors.black,
                backgroundColor: AppColor.primaryColor2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.r),)
                ),
                label: Text("Đánh giá"),
                onPressed: () async {
                  print(widget.checkin.id);
                  Rating? rating = await RatingRepository().postRating(widget.checkin.toiletId, star, comment, widget.checkin.id, imageSources);
                  if (rating != null) {
                    Navigator.pushNamed(context, Routes.homeMainScreen);
                  }
                  },
                elevation: 0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
