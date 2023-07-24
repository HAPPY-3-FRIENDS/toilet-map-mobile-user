import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:toiletmap/app/models/vnpayJson/vnpay_json.dart';
import 'package:toiletmap/app/utils/routes.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/constants.dart';

class VNPayScreen extends StatefulWidget {
  String url;
  VNPayScreen({Key? key, required this.url}) : super(key: key);

  @override
  State<VNPayScreen> createState() => _VNPayScreenState();
}

class _VNPayScreenState extends State<VNPayScreen> {
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController controller) {
            _controller = controller;
          },
          onPageFinished: (String url) async {
            final String json = await _controller.evaluateJavascript('document.body.innerText');
            print("vnpay: " + json);

            if (isJSON(json)) {
              final decoded = jsonDecode(json);
              print ('decoded: ' + decoded.toString());

              try {
                print('try try try');
                VNPayJson vnPayJson = VNPayJson.fromJson(jsonDecode(decoded));
                print("vnPayJson status: " + vnPayJson.status.toString());

                if (vnPayJson.status == 200) {
                  Navigator.pushReplacementNamed(context, Routes.homeMainScreen);
                  AwesomeDialog(
                      context: context,
                      dialogType: DialogType.success,
                      animType: AnimType.topSlide,
                      dismissOnBackKeyPress: true,
                      autoDismiss: true,
                      dismissOnTouchOutside: true,
                      showCloseIcon: true,
                      body: Container(
                          height: 100.h,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(16.w),
                            child: RichText(
                              text: TextSpan(
                                  text: 'Tài khoản của bạn đã được nạp thành công ',
                                  style: TextStyle(fontSize: 16.sp, color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(vnPayJson.data.total) + " VNĐ",
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        color: AppColor.primaryColor1,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ]
                              ),
                            ),
                          )
                      ),
                  ).show();
                } else {
                  Navigator.pushReplacementNamed(context, Routes.homeMainScreen);
                  showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Chú ý'),
                        content: Text('Đã có lỗi xảy ra!'),
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
              } catch (e) {
                e.toString();
              }
            }
          },

        )
      ),
    );
  }
}

bool isJSON(str) {
  try {
    jsonDecode(str);
  } catch (e) {
    return false;
  }
  return true;
}