import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toiletmap/app/main.dart';
import 'package:toiletmap/app/models/accessToken/access_token.dart';
import 'package:toiletmap/app/repositories/auth_repository.dart';

import '../../utils/constants.dart';
import '../../utils/routes.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  String name = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150.h),
          child: Container(
            decoration: AppBoxDecoration.boxDecorationWithGradientNoBorder1,
            padding: EdgeInsets.only(top: 50.h),
            child: AppBar(
              backgroundColor: Colors.transparent,
              toolbarHeight: 150.h,

              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.white,
                ),
              ),

              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nhập họ tên của bạn", style: AppText.whiteText35),
                  SizedBox(height: 10.h,),
                  Text("Họ tên không quá 50 ký tự", style: AppText.white70Text18,),
                ],
              ),
              titleSpacing: 0,

              elevation: 0,
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
                            await AuthRepository().createUserWithPhone(name);
                            await Navigator.pushReplacementNamed(context, Routes.homeMainScreen);
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
