import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toiletmap/app/models/userInfo/user_info.dart';
import 'package:toiletmap/app/repositories/user_info_repository.dart';

import '../../utils/constants.dart';

class InformationChangeMainScreen extends StatelessWidget {
  const InformationChangeMainScreen({Key? key}) : super(key: key);

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

                title: Text('Thiết lập thông tin'),
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
            color: Color(0xFFF1F1F1),
            child: FutureBuilder<UserInfo?> (
                future: UserInfoRepository().getUserInfo(),
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
                    String phone = '********' + snapshot!.data!.phone!.substring(7,9);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            color: Colors.white,
                            height: 180.h,
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: (snapshot!.data!.avatar != null)
                                ? Center(
                                  child: CircleAvatar(
                                    radius: 60.w,
                                    backgroundImage: NetworkImage(snapshot!.data!.avatar!),
                                  ),
                                )
                                : Center(
                                  child: CircleAvatar(
                                    radius: 60.w,
                                    backgroundImage: AssetImage('assets/default-avatar.png'),
                                  ),
                                )
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5.h,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  height: 60.h,
                                  width: double.infinity,
                                  color: Colors.white,
                                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.phone, color: AppColor.primaryColor1, size: 20.w,),
                                              SizedBox(width: 10.w),
                                              Text("Số điện thoại", style: AppText.titleText2,),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(phone, style: AppText.titleText4,),
                                              SizedBox(width: 10.w),
                                              Icon(Icons.arrow_forward_ios_outlined, size: 17.w, color: Colors.black38,),
                                            ],
                                          ),
                                        ],
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      )
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  height: 60.h,
                                  width: double.infinity,
                                  color: Colors.white,
                                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.perm_identity, color: AppColor.primaryColor1, size: 20.w,),
                                              SizedBox(width: 10.w),
                                              Text("Họ tên", style: AppText.titleText2,),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(snapshot!.data!.fullName, style: AppText.titleText4,),
                                              SizedBox(width: 10.w),
                                              Icon(Icons.arrow_forward_ios_outlined, size: 17.w, color: Colors.black38,),
                                            ],
                                          ),
                                        ],
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      )
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return Center(child: Text('Lỗi'));
                }
            ),
          )
      ),
    );
  }
}
