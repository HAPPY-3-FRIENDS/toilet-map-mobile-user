import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants.dart';

class RatingMainInformationFrame extends StatelessWidget {
  const RatingMainInformationFrame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(15.w),
      height: 150.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: CachedNetworkImage(
              imageUrl: 'https://nhavesinhdidonggiare.com/upload/images/thue-nha-ve-sinh-cong-cong-tp-hcm-1631894129.jpg',
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Container(
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
                    Text("Lỗi tải ảnh", style: AppText.detailText3,),
                    SizedBox(height: 20.h,),
                    Icon(Icons.error_outline_rounded, size: 20.w, color: Colors.black54,)
                  ],
                ),
              ),
              imageBuilder: (context, imageProvider) => Container(
                height: 80.h,
                width: 80.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                  ),
                ),
              )
          ), flex: 1,),
          SizedBox(width: 20.w,),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20.h,),
              Expanded(
                child: Text("Nhà vệ sinh Nguyễn Huệ", style: AppText.blackText22,
                    overflow: TextOverflow.ellipsis, maxLines: 1,),
              flex: 1,),
              Expanded(
                child: Text("42 Đường Nguyễn Huệ, Phường Bến Nghé, Quận 1, TP. Hồ Chí Minh", style: AppText.greyText18,
                    overflow: TextOverflow.ellipsis, maxLines: 2),
              flex: 2,),
            ],
          ), flex: 3,)
        ],
      ),
    );
  }
}
