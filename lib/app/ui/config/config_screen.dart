import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:toiletmap/app/main.dart';
import 'package:toiletmap/app/models/accessToken/access_token.dart';
import 'package:toiletmap/app/repositories/auth_repository.dart';
import 'package:toiletmap/app/repositories/shared_preferences_repository.dart';
import 'package:toiletmap/app/utils/routes.dart';

import '../../utils/constants.dart';
import '../home/home_main_screen.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({Key? key}) : super(key: key);

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  String ip = "";
  int choose = 0;

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(" IP", style: AppText.primary1Text24,),
                      SizedBox(height: 10.h,),
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
                      SizedBox(height: 40.h,),
                      Text(" Goong Account", style: AppText.primary1Text24,),
                      SizedBox(height: 10.h,),
                      GroupButton(
                        onSelected: (value, index, isSelected) {
                          print('index ne' + index.toString());
                          switch (index) {
                            case 0:
                              setState(() {
                                choose = 1;
                              });
                              break;
                            case 1:
                              setState(() {
                                choose = 2;
                              });
                              break;
                          }
                        },
                        isRadio: true,
                        options: GroupButtonOptions(
                          buttonWidth: 150.w,
                          selectedColor: Colors.white,
                          selectedBorderColor: AppColor.primaryColor1,
                          unselectedBorderColor: Colors.grey,
                          borderRadius: BorderRadius.circular(10.r),
                          mainGroupAlignment: MainGroupAlignment.center,
                          crossGroupAlignment: CrossGroupAlignment.center,
                          selectedTextStyle: AppText.blackText18,
                          groupingType: GroupingType.wrap,
                          unselectedTextStyle: AppText.blackText18,
                          unselectedShadow: [],
                          selectedShadow: []
                        ),

                        buttons: ['Goong 1','Goong 2'],
                      ),
                    ],
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
                            if (choose == 0 || choose == 1) {
                              AppDomain.apiKey = AppDomain.apiKey1;
                              AppString.styleString = 'https://tiles.goong.io/assets/goong_light_v2.json?api_key=Rx4uWeCguGjTpjupmAlqdMUJV9iKW1rLiiGLtfdt';
                            } else {
                              AppDomain.apiKey = AppDomain.apiKey2;
                              AppString.styleString = 'https://tiles.goong.io/assets/goong_light_v2.json?api_key=7c1L0Na5HyTqjoBruzEoJo9EaGWyVaG2pXxsUr66';
                            }
                            print("API xai: " + AppDomain.apiKey);
                            if (ip == "") {
                              AppDomain.appDomain1 = "http://192.168.137.1:8081";
                              AppString.appDomain = "http://192.168.137.1:8081";
                            } else {
                              AppDomain.appDomain1 = "http://" + ip + ":8081";
                              AppString.appDomain = "http://" + ip + ":8081";
                            }
                            HomeMainScreen.activeWebSocket = false;
                            AccessToken? token = await AuthRepository().authPhoneLogin();
                            if (token != null) {
                              Navigator.pushNamed(context, Routes.homeMainScreen);
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
