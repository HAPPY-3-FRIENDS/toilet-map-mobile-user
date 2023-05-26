import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';

import '../../../../models/commonComment/common_comment.dart';
import '../../../../repositories/common_comment_repository.dart';
import '../../../../utils/constants.dart';

class CommonCommentsFrame extends StatelessWidget {
  const CommonCommentsFrame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CommonComment>?> (
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
        });
  }
}
