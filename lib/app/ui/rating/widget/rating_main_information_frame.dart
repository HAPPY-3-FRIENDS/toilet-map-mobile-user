import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toiletmap/app/repositories/toilet_repository.dart';

import '../../../models/toilet/toilet.dart';
import '../../../utils/constants.dart';

class RatingMainInformationFrame extends StatelessWidget {
  int toiletId;

  RatingMainInformationFrame({Key? key, required this.toiletId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(15.w),
      height: 150.h,
      child: FutureBuilder<Toilet?> (
          future: ToiletRepository().getToiletByToiletId(toiletId),
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
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: CachedNetworkImage(
                      imageUrl: snapshot.data!.toiletImageSources[0]!,
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
                        child: Text(snapshot.data!.toiletName, style: AppText.blackText22,
                          overflow: TextOverflow.ellipsis, maxLines: 1,),
                        flex: 1,),
                      Expanded(
                        child: Text(snapshot.data!.address + ", " + snapshot.data!.ward + ", " + snapshot.data!.district + ", " + snapshot.data!.province, style: AppText.greyText18,
                            overflow: TextOverflow.ellipsis, maxLines: 2),
                        flex: 2,),
                    ],
                  ), flex: 3,)
                ],
              );
            }
            return Center(child: Text('Lỗi'));
          }),
    );
  }
}
