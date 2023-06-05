import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toiletmap/app/models/announcement/announcement.dart';

import '../../utils/constants.dart';

class AnnouncementMainScreen extends StatelessWidget {
  Announcement announcement;

  AnnouncementMainScreen({Key? key, required this.announcement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
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

              title: Text('Thông báo'),
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
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                    imageUrl: announcement.imageSource,
                    placeholder: (context, url) => SizedBox(
                      child: Center(
                          child: CircularProgressIndicator()
                      ),
                      height: 20.w,
                      width: 20.w,
                    ),
                    errorWidget: (context, url, error) => Container(
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
                      height: 250.h,
                      width: AppSize.widthScreen,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                ),
                Padding(padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(announcement.title, style: AppText.primary1Text28,),
                    SizedBox(height: 15.w,),
                    Text(announcement.description!, style: AppText.blackText20,),
                    SizedBox(height: 15.w,),
                    Text('Thời gian áp dụng: ', style: AppText.primary1Text24),
                    SizedBox(height: 5.w,),
                    Text('Từ ngày ' + announcement.startDate! + " - " + announcement.endDate!, style: AppText.blackText20)
                  ],
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
