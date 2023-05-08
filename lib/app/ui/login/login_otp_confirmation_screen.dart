import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toiletmap/app/models/accessToken/access_token.dart';
import 'package:toiletmap/app/repositories/auth_repository.dart';
import 'package:toiletmap/app/ui/login/login_main_screen.dart';
import 'package:toiletmap/app/utils/constants.dart';

import '../../utils/routes.dart';

class LoginOTPConfirmationScreen extends StatefulWidget {
  const LoginOTPConfirmationScreen({Key? key}) : super(key: key);

  @override
  State<LoginOTPConfirmationScreen> createState() => _LoginOTPConfirmationScreenState();
}

class _LoginOTPConfirmationScreenState extends State<LoginOTPConfirmationScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final AuthRepository authRepository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50.w,
      height: 60.h,
      textStyle: TextStyle(
          fontSize: 24.sp,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w400),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(10.r),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(10.r),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    var code = "";

    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        extendBodyBehindAppBar: false,
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
                  Text("Nhập mã OTP", style: AppText.whiteText35),
                  SizedBox(height: 10.h,),
                  Text("Mã OTP được gửi về điện thoại của bạn", style: AppText.white70Text18,),
                ],
              ),
              titleSpacing: 0,

              elevation: 0,
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(25.w),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Pinput(
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,

                  showCursor: true,
                  onCompleted: (pin) => print(pin),
                  onChanged: (value) {
                    code = value;
                  },
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
                          //open 2 code to build apk
                          //PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: LoginMainScreen.verify, smsCode: code);

                          // Sign the user in (or link) with the credential
                          //await auth.signInWithCredential(credential);

                          //Close 3 code to build apk
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setString("username", "0849666957");
                          prefs.setString("accessToken", "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI2IiwiaWF0IjoxNjgzNDUxNDA1LCJleHAiOjE2ODQwNTYyMDUsInVzZXJuYW1lIjoiMDg0OTY2Njk1NyIsInJvbGUiOiJVc2VyIiwiYXV0aG9yaXRpZXMiOlt7ImF1dGhvcml0eSI6IlJPTEVfVXNlciJ9XX0.MXaIePMIPp2V4tJlYVIj-eMJXZ23cREBYnIs4tnzp1RpoE7nZ5bhddQs9KH-Jtg3iMBA4KvRqlKTQMnEA8LdvA");

                          AccessToken? accessToken = await AuthRepository().authPhoneLogin();
                          if (accessToken == null ) {
                            Navigator.pushNamed(context, Routes.createAccountScreen);
                          } else {
                            Navigator.pushNamed(context, Routes.homeMainScreen);
                          }
                        } catch (e) {
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Chú ý!'),
                                content: const Text('Mã xác nhận không khớp'),
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
                      child: Text("Xác nhận", style: AppText.blackText20,)),
                ),
              ],
            ),
        ),
      ),
    );
  }
}
