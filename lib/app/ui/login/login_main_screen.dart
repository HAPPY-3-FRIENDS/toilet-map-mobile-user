import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toiletmap/app/ui/login/widget/login_main_appbar.dart';
import 'package:toiletmap/app/utils/constants.dart';

import '../../main.dart';
import '../../utils/routes.dart';

class LoginMainScreen extends StatefulWidget {
  const LoginMainScreen({Key? key}) : super(key: key);

  static String verify="";

  @override
  State<LoginMainScreen> createState() => _LoginMainScreenState();
}

class _LoginMainScreenState extends State<LoginMainScreen> {
  TextEditingController countryController = TextEditingController();
  var phone = "";

  @override
  void initState() {
    // TODO: implement initState
    countryController.text = "+84";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LoginAppbar(),
                SizedBox(
                  height: 80.h
                ),
                Text(
                  "Đăng nhập / Đăng ký bằng số điện thoại",
                  style: AppText.blackText22Bold,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                    height: 25.h
                ),
                Container(
                  height: 60.h,
                  margin: EdgeInsets.only(left: 25.w, right: 5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                              color: AppColor.primaryColor2
                            ),

                            child: Row(
                              children: [
                                SizedBox(
                                    width: 20.w
                                ),
                                SizedBox(
                                  width: 35.w,
                                  child: TextField(
                                    controller: countryController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                        fontSize: 20.sp
                                    ),
                                  ),
                                ),
                                Text(
                                  "|",
                                  style: TextStyle(fontSize: 20.h, color: Colors.grey),
                                ),
                                SizedBox(
                                    width: 15.w
                                ),
                                Expanded(
                                    child: TextField(
                                      onChanged: (value) {
                                        phone = value;
                                      },
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Nhập số điện thoại",
                                      ),
                                    ))
                              ],
                            ),
                          )
                      ),
                      IconButton(
                          onPressed: () async {
                            if (phone == "") {
                              showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Lỗi'),
                                    content: const Text('Vui lòng nhập số điện thoại'),
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
                                  sharedPreferences.setString("username", phone);
                                  print('loginmain ' +phone);
                                  Navigator.pushNamed(context, Routes.loginOTPConfirmationScreen);
                                },
                                codeAutoRetrievalTimeout: (String verificationId) {},
                              );
                            }
                          },
                          icon: Icon(Icons.arrow_forward_ios_outlined, color: AppColor.primaryColor1, size: 25.w, )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60.h
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 2.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(20.w),
                          )
                        ),
                      ),
                      SizedBox(
                          width: 10.w
                      ),
                      Text("Hoặc đăng nhập bằng", style: AppText.greyText18,),
                      SizedBox(
                          width: 10.w
                      ),
                      Container(
                        height: 2.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.all(Radius.circular(20.w),
                            )
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    height: 20.h
                ),
                IconButton(iconSize: 20.w ,onPressed: () {}, icon: Image.asset('assets/images/google-logo.png'),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

