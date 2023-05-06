import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants.dart';

class LoginAppbar extends StatelessWidget {
  const LoginAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 200.h,
            decoration: AppBoxDecoration.boxDecorationWithGradientLogin1,
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            shape: AppShapeBorder.shapeBorder3
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 100.h),
          child: Container(
            width: 170.w,
            height: 170.w,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/logo.png"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all( Radius.circular(85.w)),
              border: Border.all(
                color: Colors.white,
                width: 5.w,
              ),
            ),
          ),
        )
      ],
    );
  }
}
