import 'package:flutter/material.dart';
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
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    var code = "";

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png',
                width: 150,
                height: 150,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Xác nhận Số điện thoại",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                // defaultPinTheme: defaultPinTheme,
                // focusedPinTheme: focusedPinTheme,
                // submittedPinTheme: submittedPinTheme,

                showCursor: true,
                onCompleted: (pin) => print(pin),
                onChanged: (value) {
                  code = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: AppColor.primaryColor1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      try {
                        //PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: LoginMainScreen.verify, smsCode: code);

                        // Sign the user in (or link) with the credential
                        //await auth.signInWithCredential(credential);

                        final prefs = await SharedPreferences.getInstance();
                        prefs.setString("username", "0849666957");
                        prefs.setString("accessToken", "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI0IiwiaWF0IjoxNjgwNjg1NzE4LCJleHAiOjE2ODEyOTA1MTgsInVzZXJuYW1lIjoiMDg0OTY2Njk1NyIsInJvbGUiOiJVc2VyIiwiYXV0aG9yaXRpZXMiOlt7ImF1dGhvcml0eSI6IlJPTEVfVXNlciJ9XX0.BuL4Ni8BkrIXCK0lO1AgntOsLNYXego3yA8TS6i_YvVDfdKuSABzAuxbCgpNDD_T8AkM4_NZtbPKQ92qoEmKqg");

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
                              title: const Text('Chú ý'),
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
                    child: Text("Xác nhận")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
