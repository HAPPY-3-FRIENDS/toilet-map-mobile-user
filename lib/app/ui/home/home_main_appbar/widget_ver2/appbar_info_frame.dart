import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../utils/constants.dart';
import '../widget_ver3/payment_method_changing.dart';

class AppbarInfoFrame extends StatelessWidget {
  const AppbarInfoFrame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.heightScreen / 4.5,
      decoration: AppBoxDecoration.boxDecorationWithGradient1,
      child: Padding(padding: EdgeInsets.only(
          left: AppNumber.h35,
          right: AppNumber.h35,
          top: AppNumber.h20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Thanh toán bằng số lượt (Mặc định)', style: AppText.appbarText1,),
                    SizedBox(width: AppNumber.h80,),
                    FaIcon(FontAwesomeIcons.arrowsRotate, size: AppNumber.h45, color: AppColor.primaryColor2,),
                  ],
                ),
                SizedBox(height: AppNumber.h80,),
                Text('30 lượt', style: AppText.appbarText2,),
              ],
            ),
            FaIcon(FontAwesomeIcons.solidUser, size: AppNumber.h35, color: Colors.white,),
          ],
        ),
      ),
    );
  }
}
