import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toiletmap/app/models/jwt/jwt.dart';
import 'package:toiletmap/app/repositories/auth_repository.dart';
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

class _LoginMainScreenState extends State<LoginMainScreen> with TickerProviderStateMixin {
  TextEditingController countryController = TextEditingController();
  var phone = "";

  late AnimationController _controller2;
  late AnimationController _controller1;
  late AnimationController _controller3;
  late Animation<double> _animation2;
  late Animation<double> _animation1;
  late Animation<double> _animation3;
  double boxX = 0;
  double boxY = 0.2;

  void _moveBox() {
    setState(() {
      boxX = 0;
      boxY = -0.7;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    countryController.text = "+84";
    super.initState();

    _controller1 = AnimationController(vsync: this,
        duration: Duration(milliseconds: 1500)
    );

    _animation1 = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller1);

    Future.delayed(Duration(microseconds: 0)).then((value) => {
      _controller1!.forward()
    });

    Future.delayed(Duration(microseconds: 1000)).then((value) => {
      _moveBox()
    });

    _controller2 = AnimationController(vsync: this,
        duration: Duration(milliseconds: 800)
    );

    _animation2 = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(_controller2);

    Future.delayed(Duration(milliseconds: 6000)).then((value) => {
      _controller2!.forward()
    });

    Future.delayed(Duration(milliseconds: 7000)).then((value) async {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.loading,
        title: 'Đang tải dữ liệu',
      );

        final prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('accessToken');

        Map<String, dynamic> load = Jwt.parseJwt(token!);
        JWT jwt = JWT.fromJson(load);
        int tokenDate = jwt.exp;
        int nowDate = (DateTime.now().toUtc().millisecondsSinceEpoch / 1000).ceil();

        print("token Date" + tokenDate.toString());
        print("nơ Date" + nowDate.toString());

        if (nowDate > tokenDate) {
          token = null;
          await prefs.clear();
        }

        Navigator.pop(context);

        print('cho nay in ra token: ' + token!);
        if (token != null) {
          Navigator.pushNamed(context, Routes.homeMainScreen);
        }
    });

    _controller3 = AnimationController(vsync: this,
        duration: Duration(milliseconds: 1500)
    );

    _animation3 = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller3);

    Future.delayed(Duration(milliseconds: 7000)).then((value) => {
      _controller3!.forward()
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller2.dispose();
    _controller1.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
            body: Stack(
              children: [
                FadeTransition(
                  opacity: _animation1,
                  child: FadeTransition(
                    opacity: _animation2,
                    child: Center(
                      child: AnimatedContainer(
                        child: Container(
                          width: 170.w,
                          height: 170.w,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/logo.png"),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all( Radius.circular(85.w)),
                          ),
                        ),
                        duration: Duration(milliseconds: 2500),
                        alignment: Alignment(boxX, boxY),
                      ),
                    ),
                  ),
                ),
                FadeTransition(opacity: _animation3,
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
                  ),),
              ],
            )
        )
    );
  }
}