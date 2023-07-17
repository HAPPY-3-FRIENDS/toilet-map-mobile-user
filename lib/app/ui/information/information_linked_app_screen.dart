import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/constants.dart';

class InformationLinkedAppScreen extends StatelessWidget {
  const InformationLinkedAppScreen({Key? key}) : super(key: key);

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

                title: Text('Tiện ích'),
                titleTextStyle: AppText.appbarTitleText2,
                centerTitle: true,
                toolbarHeight: 100.h,
                backgroundColor: Colors.white,
                elevation: 0,

                iconTheme: IconThemeData(
                    color: AppColor.primaryColor1
                ),
              ),
            ),
          ),

          body: Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: GridView(
                  children: [
                    /*InkWell(
                      onTap: () {
                        final url = Uri.parse('market://details?id=com.facebook.katana');
                        launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: CachedNetworkImage(
                          imageUrl: 'https://scontent.fsgn8-3.fna.fbcdn.net/v/t39.30808-6/352000788_655738609902238_7871671301543095833_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=730e14&_nc_ohc=vucElWywBCwAX-OMCUi&_nc_ht=scontent.fsgn8-3.fna&oh=00_AfDNC0wBckIM0-Y03oBMJSqkuJvS1g3-p-6ZDxAEgXWU4Q&oe=6483C720',
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
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        final url = Uri.parse('market://details?id=com.instagram.android');
                        launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: CachedNetworkImage(
                          imageUrl: 'https://scontent.fsgn8-4.fna.fbcdn.net/v/t39.30808-6/351809798_678204167479571_5816338215040382418_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=730e14&_nc_ohc=qNfbknJ9NjEAX9Jbqn5&_nc_ht=scontent.fsgn8-4.fna&oh=00_AfBTRI-tYTbscyq11MI1f6vz_jmPe53ZWzW-MW_iispyiQ&oe=64834162',
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
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                      ),
                    ),*/
                    InkWell(
                      onTap: () {
                        final url = Uri.parse('https://dichvucongichquan1.com/san-pham/chat-thai-sinh-hoat/');
                        launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: CachedNetworkImage(
                          imageUrl: 'https://dichvucongichquan1.com/wp-content/uploads/2021/04/sp11-1.png',
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  height: 60.h,
                                  width: 60.w,
                                ),
                                SizedBox(height: 5.h,),
                                Text('Thu Gom Chất Thải Sinh Hoạt', textAlign: TextAlign.center, style: TextStyle(
                                  color: Colors.green, fontSize: 18.sp
                                ),),
                              ],
                            ),
                          )
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        final url = Uri.parse('https://dichvucongichquan1.com/san-pham/chat-thai-nguy-hai/');
                        launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: CachedNetworkImage(
                          imageUrl: 'https://dichvucongichquan1.com/wp-content/uploads/2021/04/sp10.png',
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  height: 60.h,
                                  width: 60.w,
                                ),
                                SizedBox(height: 5.h,),
                                Text('Thu Gom Chất Thải Nguy Hại', textAlign: TextAlign.center, style: TextStyle(
                                    color: Colors.green, fontSize: 18.sp
                                ),),
                              ],
                            ),
                          )
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        final url = Uri.parse('https://dichvucongichquan1.com/san-pham/cong-vien-cay-xanh/');
                        launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: CachedNetworkImage(
                          imageUrl: 'https://dichvucongichquan1.com/wp-content/uploads/2021/04/sp9.png',
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  height: 60.h,
                                  width: 60.w,
                                ),
                                SizedBox(height: 5.h,),
                                Text('Công Viên - Cây Xanh', textAlign: TextAlign.center, style: TextStyle(
                                    color: Colors.green, fontSize: 18.sp
                                ),),
                              ],
                            ),
                          )
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        final url = Uri.parse('https://dichvucongichquan1.com/san-pham/thoat-nuoc-do-thi/');
                        launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: CachedNetworkImage(
                          imageUrl: 'https://dichvucongichquan1.com/wp-content/uploads/2021/04/sp7.png',
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  height: 60.h,
                                  width: 60.w,
                                ),
                                SizedBox(height: 5.h,),
                                Text('Thoát Nước Đô Thị', textAlign: TextAlign.center, style: TextStyle(
                                    color: Colors.green, fontSize: 18.sp
                                ),),
                              ],
                            ),
                          )
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        final url = Uri.parse('https://dichvucongichquan1.com/san-pham/nha-ve-sinh-luu-dong/');
                        launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: CachedNetworkImage(
                          imageUrl: 'https://dichvucongichquan1.com/wp-content/uploads/2021/04/sp8.png',
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  height: 60.h,
                                  width: 60.w,
                                ),
                                SizedBox(height: 5.h,),
                                Text('Nhà Vệ Sinh Lưu Động', textAlign: TextAlign.center, style: TextStyle(
                                    color: Colors.green, fontSize: 18.sp
                                ),),
                              ],
                            ),
                          )
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        final url = Uri.parse('https://dichvucongichquan1.com/san-pham/hut-ham-cau/');
                        launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: CachedNetworkImage(
                          imageUrl: 'https://dichvucongichquan1.com/wp-content/uploads/2021/04/sp6.png',
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  height: 60.h,
                                  width: 60.w,
                                ),
                                SizedBox(height: 5.h,),
                                Text('Hút Hầm Cầu', textAlign: TextAlign.center, style: TextStyle(
                                    color: Colors.green, fontSize: 18.sp
                                ),),
                              ],
                            ),
                          )
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        final url = Uri.parse('https://dichvucongichquan1.com/san-pham/quan-ly-nha/');
                        launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: CachedNetworkImage(
                          imageUrl: 'https://dichvucongichquan1.com/wp-content/uploads/2021/04/sp5.png',
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  height: 60.h,
                                  width: 60.w,
                                ),
                                SizedBox(height: 5.h,),
                                Text('Quản Lý Nhà', textAlign: TextAlign.center, style: TextStyle(
                                    color: Colors.green, fontSize: 18.sp
                                ),),
                              ],
                            ),
                          )
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        final url = Uri.parse('https://dichvucongichquan1.com/san-pham/thu-gom-van-chuyen-rac/');
                        launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: CachedNetworkImage(
                          imageUrl: 'https://dichvucongichquan1.com/wp-content/uploads/2021/04/sp4.png',
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  height: 60.h,
                                  width: 60.w,
                                ),
                                SizedBox(height: 5.h,),
                                Text('Phục Vụ Vệ Sinh Sự Kiện Lễ Hội', textAlign: TextAlign.center, style: TextStyle(
                                    color: Colors.green, fontSize: 18.sp
                                ),),
                              ],
                            ),
                          )
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        final url = Uri.parse('https://dichvucongichquan1.com/san-pham/thu-gom-xa-ban/');
                        launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: CachedNetworkImage(
                          imageUrl: 'https://dichvucongichquan1.com/wp-content/uploads/2021/04/sp2.png',
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  height: 60.h,
                                  width: 60.w,
                                ),
                                SizedBox(height: 5.h,),
                                Text('Thu Gom Chất Thải Sinh Hoạt', textAlign: TextAlign.center, style: TextStyle(
                                    color: Colors.green, fontSize: 18.sp
                                ),),
                              ],
                            ),
                          )
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        final url = Uri.parse('https://dichvucongichquan1.com/san-pham/thu-gom-xa-ban/');
                        launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: CachedNetworkImage(
                          imageUrl: 'https://dichvucongichquan1.com/wp-content/uploads/2021/04/sp2.png',
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  height: 60.h,
                                  width: 60.w,
                                ),
                                SizedBox(height: 5.h,),
                                Text('Thu Gom Xà Bần', textAlign: TextAlign.center, style: TextStyle(
                                    color: Colors.green, fontSize: 18.sp
                                ),),
                              ],
                            ),
                          )
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        final url = Uri.parse('https://dichvucongichquan1.com/san-pham/kinh-doanh-thung-rac-composite/');
                        launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: CachedNetworkImage(
                          imageUrl: 'https://dichvucongichquan1.com/wp-content/uploads/2021/04/sp1.png',
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  height: 60.h,
                                  width: 60.w,
                                ),
                                SizedBox(height: 5.h,),
                                Text('Kinh Doanh Thùng Rác Composite', textAlign: TextAlign.center, style: TextStyle(
                                    color: Colors.green, fontSize: 18.sp
                                ),),
                              ],
                            ),
                          )
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        final url = Uri.parse('https://dichvucongichquan1.com/san-pham/thu-tien-rac-sinh-hoat-tien-nha-snhh/');
                        launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: CachedNetworkImage(
                          imageUrl: 'https://dichvucongichquan1.com/wp-content/uploads/2021/05/icon-thu-tien-rac-01.png',
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  height: 60.h,
                                  width: 60.w,
                                ),
                                SizedBox(height: 5.h,),
                                Text('Thu Tiền Rác Sinh Hoạt & Tiền Nhà SHNN', textAlign: TextAlign.center, style: TextStyle(
                                    color: Colors.green, fontSize: 18.sp
                                ),),
                              ],
                            ),
                          )
                      ),
                    ),
                  ],
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 20.w, crossAxisSpacing: 15.w),
                ),
              )
          )
      ),
    );
  }
}
