import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toiletmap/app/main.dart';
import 'package:toiletmap/app/models/accessToken/access_token.dart';
import 'package:toiletmap/app/repositories/auth_repository.dart';
import 'package:toiletmap/app/repositories/user_info_repository.dart';

import '../../utils/constants.dart';
import '../../utils/routes.dart';

class InformationChangeNameScreen extends StatefulWidget {
  const InformationChangeNameScreen({Key? key}) : super(key: key);

  @override
  State<InformationChangeNameScreen> createState() => _InformationChangeNameScreenState();
}

class _InformationChangeNameScreenState extends State<InformationChangeNameScreen> {
  String name = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

            title: Text('Thay đổi tên'),
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
          padding: EdgeInsets.all(
              25.w
          ),
          height: AppSize.heightScreen,
          width: AppSize.widthScreen,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                child: TextFormField(
                  onChanged: (value) => setState(() => {
                    name = value
                  }),
                  maxLength: 50,
                  decoration: InputDecoration(
                    hintText: "Nhập họ tên của bạn",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: AppColor.primaryColor1),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 60.h,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: AppColor.primaryColor2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r))),
                    onPressed: () async {
                      try {
                        if (name == "") {
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Chú ý'),
                                content: const Text('Vui lòng nhập tên!'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Xác nhận'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          await UserInfoRepository().patchUserInfoChangeName(name);
                          await Navigator.pushNamed(context, Routes.informationMainScreen);
                        }
                      } catch (e) {
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Chú ý'),
                              content: const Text('Đã có lỗi xảy ra!'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Xác nhận'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Text("Xác nhận", style: AppText.blackText20,)
                ),
              )
            ],
          )
      ),
    );
  }
}
