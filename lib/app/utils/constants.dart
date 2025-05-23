import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//App size
class AppSize {
  static double heightScreen = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
  static double widthScreen = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
}

class AppDomain {
  static  String appDomain1 = "http://192.168.137.1:8081";
  static String apiKey = 'OnwCCr1HHOeOCqofMVaXBaf9t82lC25Vqsm6iJJa';
  static const String apiKey1 = 'OnwCCr1HHOeOCqofMVaXBaf9t82lC25Vqsm6iJJa';
  //static const String apiKey2 = 'AbbqpehNgoWQ49P9hjoVNBOGcMEsP9FeNa4i9kfv';
  static const String apiKey2 = 'YdFnx52vK8r2fTnkCI3uCFVYJJhcdNvUuWOXAoBz';
  static const String apiKey3 = 'mzd7gQKio5kfmWwb5GObNLAPwPorelBIHNarCAN3';
}

//App color
class AppColor {
  static const Color primaryColor1 = Color(0xFF0B79D9);
  static const Color primaryColor2 = Color(0xFFD8E9F9);
  static const Color gradientColor1 = Color(0xFF0B63B0);
  static const Color gradientColor2 = Color(0xFF29ABE2);
  static const Color gradientColor3 = Color(0xFF004886);
  static const Color gradientColor4 = Color(0xFF68B2F4);
  static const Color appBackground = Color(0xFFF1F1F1);
}

//App string
class AppString {
  static const String appName = "Toilet Map - Nhà Vệ Sinh Công Cộng";
  static String appDomain = "http://192.168.137.1:8081";
  static const String loginSuccessfully = "Đăng nhập thành công";
  static String styleString = "https://tiles.goong.io/assets/goong_light_v2.json?api_key=Rx4uWeCguGjTpjupmAlqdMUJV9iKW1rLiiGLtfdt";
}

//App decoration
class AppBoxDecoration {
  static var boxDecoration1 = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(10.r)),
    color: Colors.white,
  );

  static var boxDecoration2 = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(10.r)),
    color: AppColor.primaryColor2,
  );

  static var boxDecoration3 = BoxDecoration(
    borderRadius: BorderRadius.only(
        topRight: Radius.circular(10.r),
        topLeft: Radius.circular(10.r)
    ),
    color: AppColor.primaryColor2,
  );

  static var boxDecoration4 = BoxDecoration(
    borderRadius: BorderRadius.only(
        topRight: Radius.circular(10.r),
        topLeft: Radius.circular(10.r)
    ),
    color: Colors.white,
  );

  static var boxDecoration5 = BoxDecoration(
    borderRadius: BorderRadius.only(
        topRight: Radius.circular(10.r),
        topLeft: Radius.circular(10.r)
    ),
    color: Colors.white,
  );

  static var appBarQRCodeDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(10.r)),
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
        topRight: Radius.circular(10.r),
        topLeft: Radius.circular(10.r)
    ),
    gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[AppColor.gradientColor2, AppColor.gradientColor1]
    ),
  );

  static const boxDecorationWithGradientNoBorder1 = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[AppColor.gradientColor1, AppColor.gradientColor4]
    ),
  );

  static final boxDecorationWithGradientLogin1 = BoxDecoration(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.elliptical(1000.h, 100.w),
      bottomRight: Radius.elliptical(1000.h, 100.w),
    ),
    gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[AppColor.gradientColor1, AppColor.gradientColor4]
    ),
  );
}

class AppShapeBorder {
  static var shapeBorder1 =  RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.w),
          bottomRight: Radius.circular(20.w)
      )
  );

  static var shapeBorder2 =  RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSize.heightScreen / 60),
          topRight: Radius.circular(AppSize.heightScreen / 60)
      )
  );

  static var shapeBorder3 =  RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.elliptical(1000.h, 100.w),
        bottomRight: Radius.elliptical(1000.h, 100.w),
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
    fontSize: 20.sp,
    color: AppColor.primaryColor1,
  );

  static var detailText2 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 20.sp,
    color: Colors.black,
  );

  static var detailText3 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 18.sp,
    color: Colors.black,
  );

  static var detailText4 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 18.sp,
    color: Colors.black,
  );

  static var titleText1 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18.sp,
    color: Colors.white,
  );

  static var titleText2 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 20.sp,
    color: Colors.black,
  );

  static var titleText4 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 20.sp,
    color: Colors.black38,
  );

  static var titleText3 = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 20.sp,
      color: AppColor.primaryColor1
  );

  static var mainButtonText = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: AppNumber.h52,
    fontStyle: FontStyle.normal,
    color: AppColor.primaryColor1,
  );

  static var appbarText1 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
    color: Colors.black,
  );

  static var appbarText2 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 32.sp,
    color: Colors.black,
  );

  static var appbarText3 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
    color: Colors.black,
    fontStyle: FontStyle.italic,
  );

  static var appbarQRButtonText1 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 18.sp,
    color: Colors.white,
  );

  //Fake for Phuong phone appbarQRButtonText1
  static var appbarQRButtonText2 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
    color: Colors.white,
  );

  static var appbarTitleText1 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 30.sp,
    color: Colors.white,
  );

  static var appbarTitleText2 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 30.sp,
    color: AppColor.primaryColor1,
  );

  static var bankingInfoText1 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: AppNumber.h40,
    fontStyle: FontStyle.normal,
    color: Colors.black,
  );

  static var bankingInfoText2 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: AppNumber.h45,
    fontStyle: FontStyle.normal,
    color: Colors.black,
  );

  static var listText1 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
    color: Colors.grey,
  );

  static var listText2 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 18.sp,
    color: Colors.black,
  );

  static var listText3 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 22.sp,
    color: Colors.black,
  );

  //Phuong phone listText3
  static var listText32 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18.sp,
    color: Colors.black,
  );

  static var listText4 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 18.sp,
    color: AppColor.primaryColor1,
  );

  static var toiletInfoText1 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 28.sp,
    color: AppColor.primaryColor1,
  );

  static var toiletInfoText2 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 18.sp,
    color: Colors.black,
  );

  static var bottomSheetToiletInfo1 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 24.sp,
    color: AppColor.primaryColor1,
  );

  static var bottomSheetToiletInfo2 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 18.sp,
    color: Colors.black,
  );

  static var greyText18 = TextStyle(
    fontSize: 18.sp,
    fontStyle: FontStyle.normal,
    color: Colors.black38,
  );

  static var blackText22Bold = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  static var blackText20Bold = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static var whiteText35 = TextStyle(fontSize: 35.sp, color: Colors.white);

  static var white100Text12 = TextStyle(fontSize: 12.sp, color: Colors.white);

  static var white70Text18 = TextStyle(fontSize: 18.sp, color: Colors.white70);

  static var white100Text18 = TextStyle(fontSize: 18.sp, color: Colors.white);

  static var white100Text20 = TextStyle(fontSize: 20.sp, color: Colors.white);

  static var blue1Text18 = TextStyle(fontSize: 18.sp, color: AppColor.primaryColor1);

  static var greyText14 = TextStyle(fontSize: 14.sp, color: Colors.grey);

  static var greyText16 = TextStyle(fontSize: 16.sp, color: Colors.grey);

  static var blackText16 = TextStyle(fontSize: 16.sp, color: Colors.black);

  static var blackText16Bold = TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.w700);

  static var blackText18 = TextStyle(fontSize: 18.sp, color: Colors.black);

  static var blackText18Bold = TextStyle(fontSize: 18.sp, color: Colors.black, fontWeight: FontWeight.w700,);

  static var blackText20 = TextStyle(fontSize: 20.sp, color: Colors.black54);

  static var black100Text20 = TextStyle(fontSize: 20.sp, color: Colors.black);

  static var blackText22 = TextStyle(fontSize: 22.sp, color: Colors.black);

  static var primary1Text18 = TextStyle(fontSize: 18.sp, color: AppColor.primaryColor1);

  static var primary1Text20 = TextStyle(fontSize: 20.sp, color: AppColor.primaryColor1);

  static var primary1Text24 = TextStyle(fontSize: 24.sp, color: AppColor.primaryColor1);

  static var primary1Text28 = TextStyle(fontSize: 28.sp, color: AppColor.primaryColor1, fontWeight: FontWeight.w500);
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