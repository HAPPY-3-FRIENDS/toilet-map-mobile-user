import 'package:flutter/material.dart';

//App size
class AppSize {
  static double heightScreen = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
  static double widthScreen = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
}

class AppDomain {
  static const String appDomain1 = 'https://toilet-map.azurewebsites.net';
  static const String appDomain2 = 'https://toiletmap.azurewebsites.net';
}

//App color
class AppColor {
  static const Color primaryColor1 = Color(0xFF0B79D9);
  static const Color primaryColor2 = Color(0xFFD8E9F9);
  static const Color gradientColor1 = Color(0xFF0B63B0);
  static const Color gradientColor2 = Color(0xFF29ABE2);
}

//App string
class AppString {
  static const String appName = "Toilet Map - Nhà Vệ Sinh Công Cộng";
  static const String appDomain = "https://toilet-map.azurewebsites.net";
  static const String loginSuccessfully = "Đăng nhập thành công";
}

//App decoration
class AppBoxDecoration {
  static var boxDecoration1 = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(AppSize.heightScreen / 80)),
    color: Colors.white,
  );

  static var boxDecoration2 = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(AppSize.heightScreen / 80)),
    color: AppColor.primaryColor2,
  );

  static var boxDecoration3 = BoxDecoration(
    borderRadius: BorderRadius.only(
        topRight: Radius.circular(AppSize.heightScreen / 60),
        topLeft: Radius.circular(AppSize.heightScreen / 60)
    ),
    color: AppColor.primaryColor2,
  );

  static var boxDecoration4 = BoxDecoration(
    borderRadius: BorderRadius.only(
        topRight: Radius.circular(AppSize.heightScreen / 60),
        topLeft: Radius.circular(AppSize.heightScreen / 60)
    ),
    color: Colors.white,
  );

  static var appBarQRCodeDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(AppSize.heightScreen / 80)),
    color: AppColor.primaryColor1,
  );

  static var boxDecorationWithGradient1 = BoxDecoration(
    borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(AppSize.heightScreen / 60),
        bottomRight: Radius.circular(AppSize.heightScreen / 60)
    ),
    gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[AppColor.gradientColor1, AppColor.gradientColor2]
    ),
  );

  static var boxDecorationWithGradient2 = BoxDecoration(
    borderRadius: BorderRadius.only(
        topRight: Radius.circular(AppSize.heightScreen / 60),
        topLeft: Radius.circular(AppSize.heightScreen / 60)
    ),
    gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[AppColor.gradientColor2, AppColor.gradientColor1]
    ),
  );
}

class AppShapeBorder {
  static var shapeBorder1 =  RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppSize.heightScreen / 60),
          bottomRight: Radius.circular(AppSize.heightScreen / 60)
      )
  );
}

//App text
class AppText {
  static const alertText = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    fontStyle: FontStyle.normal,
    color: Colors.black,
  );

  static var detailText1 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: AppNumber.h40,
    fontStyle: FontStyle.normal,
    color: AppColor.primaryColor1,
  );

  static var detailText2 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: AppNumber.h45,
    fontStyle: FontStyle.normal,
    color: Colors.black,
  );

  static var detailText3 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: AppNumber.h50,
    fontStyle: FontStyle.normal,
    color: Colors.black,
  );

  static var detailText4 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: AppNumber.h50,
    fontStyle: FontStyle.normal,
    color: Colors.black,
  );

  static var titleText1 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: AppNumber.h40,
    fontStyle: FontStyle.normal,
    color: Colors.white,
  );

  static var titleText2 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: AppNumber.h40,
    fontStyle: FontStyle.normal,
    color: Colors.black,
  );

  static var mainButtonText = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: AppNumber.h52,
    fontStyle: FontStyle.normal,
    color: AppColor.primaryColor1,
  );

  static var appbarText1 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: AppNumber.h60,
    fontStyle: FontStyle.normal,
    color: Colors.black,
  );

  static var appbarText2 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: AppNumber.h30,
    fontStyle: FontStyle.normal,
    color: Colors.black,
  );

  static var appbarQRButtonText1 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: AppNumber.h52,
    fontStyle: FontStyle.normal,
    color: Colors.white,
  );
}

//App number
class AppNumber {
  static double h10 = AppSize.heightScreen / 10;
  static double h12 = AppSize.heightScreen / 12;
  static double h15 = AppSize.heightScreen / 15;
  static double h20 = AppSize.heightScreen / 20;
  static double h25 = AppSize.heightScreen / 25;
  static double h30 = AppSize.heightScreen / 30;
  static double h35 = AppSize.heightScreen / 35;
  static double h40 = AppSize.heightScreen / 40;
  static double h45 = AppSize.heightScreen / 45;
  static double h50 = AppSize.heightScreen / 50;
  static double h52 = AppSize.heightScreen / 52;
  static double h60 = AppSize.heightScreen / 60;
  static double h80 = AppSize.heightScreen / 80;
  static double h100 = AppSize.heightScreen / 100;
  static double h200 = AppSize.heightScreen / 200;
  static double h300 = AppSize.heightScreen / 300;
  static double h400 = AppSize.heightScreen / 400;

  static double w10 = AppSize.widthScreen / 10;
  static double w20 = AppSize.widthScreen / 20;
  static double w30 = AppSize.widthScreen / 30;
  static double w40 = AppSize.widthScreen / 40;
}