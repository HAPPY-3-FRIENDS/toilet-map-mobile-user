import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toiletmap/app/main.dart';
import 'package:toiletmap/app/models/accessToken/access_token.dart';
import 'package:toiletmap/app/repositories/auth_repository.dart';
import 'package:toiletmap/app/repositories/shared_preferences_repository.dart';
import 'package:toiletmap/app/utils/routes.dart';

import '../../utils/constants.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({Key? key}) : super(key: key);

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  String ip = "";

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

                title: Text('Configuration'),
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
                        ip = value
                      }),
                      decoration: InputDecoration(
                        hintText: "IP Here...",
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
                            if (ip == "") {
                              AppDomain.appDomain1 = "http://172.16.17.36:8081";
                              AppString.appDomain = "http://172.16.17.36:8081";
                            } else {
                              AppDomain.appDomain1 = "http://" + ip + ":8081";
                              AppString.appDomain = "http://" + ip + ":8081";
                            }
                            AccessToken? token = await AuthRepository().authPhoneLogin();
                            if (token != null) {
                              Navigator.pushReplacementNamed(context, Routes.homeMainScreen);
                            } else {
                              Navigator.pushNamed(context, Routes.loginMainScreen);
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
      ),
    );
  }
}
