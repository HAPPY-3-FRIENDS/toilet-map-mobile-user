import 'package:flutter/material.dart';

class UIConstant {
  static const String appName = "Toilet Map - Nhà Vệ Sinh Công Cộng";
}

class AppColor {
  static const Color primaryColor1 = Color(0xFF0B79D9);
  static const Color primaryColor2 = Color(0xFFD8E9F9);
  static const Color gradientColor1 = Color(0xFF0B63B0);
  static const Color gradientColor2 = Color(0xFF29ABE2);
}

class AppString {
  static const String loginSuccessfully = "Đăng nhập thành công";
}

class AppText {
  static const sampleText = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 26,
      fontStyle: FontStyle.normal,
      color: AppColor.primaryColor1);

  static const alertText = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 16,
      fontStyle: FontStyle.normal,
      color: Colors.black,
  );
}