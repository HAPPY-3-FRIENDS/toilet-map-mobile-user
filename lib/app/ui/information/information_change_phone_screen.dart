import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toiletmap/app/main.dart';
import 'package:toiletmap/app/models/accessToken/access_token.dart';
import 'package:toiletmap/app/repositories/auth_repository.dart';
import 'package:toiletmap/app/repositories/user_info_repository.dart';
import 'package:toiletmap/app/ui/home/home_main_screen.dart';

import '../../utils/constants.dart';
import '../../utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../login/login_main_screen.dart';

class InformationChangePhoneScreen extends StatefulWidget {
  const InformationChangePhoneScreen({Key? key}) : super(key: key);

  @override
  State<InformationChangePhoneScreen> createState() => _InformationChangePhoneScreenState();
}

class _InformationChangePhoneScreenState extends State<InformationChangePhoneScreen> {
  TextEditingController countryController = TextEditingController();
  String phone = '';

  @override
  void initState() {
    // TODO: implement initState
    countryController.text = "+84";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LoginMainScreen.verify = "";

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

            title: Text('Thay đổi số điện thoại'),
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
                    phone = value
                  }),
                  maxLength: 10,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "Nhập số điện thoại của bạn",
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
                        if (phone == "") {
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Chú ý'),
                                content: const Text('Vui lòng nhập số điện thoại!'),
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
                          sharedPreferences = await SharedPreferences.getInstance();

                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: '${countryController.text + phone}',
                            verificationCompleted: (PhoneAuthCredential credential) {},
                            verificationFailed: (FirebaseAuthException e) {
                              showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Lỗi'),
                                    content: const Text('Số điện thoại không hợp lệ'),
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
                            },
                            codeSent: (String verificationId, int? resendToken) {
                              LoginMainScreen.verify = verificationId;
                              if (phone[0] != '0') {
                                phone = '0' + phone;
                              }
                              print('change pphone ' + phone);
                              Navigator.pushNamed(context, Routes.informationChangePhoneConfirmScreen, arguments: phone);
                            },
                            codeAutoRetrievalTimeout: (String verificationId) {},
                          );
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
