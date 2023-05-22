import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:toiletmap/app/models/commonComment/common_comment.dart';
import 'package:toiletmap/app/repositories/common_comment_repository.dart';
import 'package:toiletmap/app/utils/constants.dart';

class RatingMainRatingFrame extends StatelessWidget {

  const RatingMainRatingFrame({Key? key}) : super(key: key);

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
                    print(rating);
                  },
                ),
              ],
            ),
            SizedBox(height: 20.h,),
            Text("Báo cáo nhà vệ sinh", style: AppText.blackText20,),
            SizedBox(height: 10.h,),
            FutureBuilder<List<CommonComment>?> (
                future: CommonCommentRepository().getCommonComments(),
                builder: (context, snapshot)  {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                            color: AppColor.primaryColor1,
                            strokeWidth: 2.0
                        )
                    );
                  }
                  if (snapshot.hasData) {
                    List<String> comments = [];
                    snapshot.data!.forEach((element) {
                      if (element.status == "Hiển thị") {
                        comments.add(element.name);
                      }
                    });

                    return GroupButton(
                        onSelected: (value, index, isSelected) {
                          print('index ne' + index.toString());
                        },
                        isRadio: false,
                        maxSelected: comments.length,
                        options: GroupButtonOptions(
                          selectedColor: AppColor.primaryColor2,
                          unselectedColor: Colors.white,
                          selectedBorderColor: AppColor.primaryColor1,
                          unselectedBorderColor: AppColor.primaryColor2,
                          borderRadius: BorderRadius.circular(10.r),
                          elevation: 0,
                          selectedShadow: [],
                          unselectedShadow: [],
                          mainGroupAlignment: MainGroupAlignment.start,
                          crossGroupAlignment: CrossGroupAlignment.center,
                          selectedTextStyle: AppText.blackText16,
                          groupingType: GroupingType.wrap,
                          unselectedTextStyle: AppText.blackText16,
                          runSpacing: 0,
                          spacing: 5.w,
                        ),

                        buttons: comments,
                      );
                  }
                  return Center(child: Text('Lỗi'));
                }),
            SizedBox(height: 20.h,),
            Text("Viết đánh giá", style: AppText.blackText20,),
            SizedBox(
              height: 100.h,
              child: TextField(
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
          ],
        ),
      ),
    );
  }
}
