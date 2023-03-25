import 'package:flutter/material.dart';
import 'package:toiletmap/app/utils/constants.dart';

class HomeAppbarQRCodeFrame extends StatelessWidget {
  const HomeAppbarQRCodeFrame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSize.widthScreen / 100),
      decoration: AppBoxDecoration.appBarQRCodeDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Mã thanh toán', style: AppText.appbarQRButtonText1,),
          Container(
            padding: EdgeInsets.all(AppSize.widthScreen / 100),
            decoration: AppBoxDecoration.boxDecoration1,
            child: Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.qr_code_2, size: AppNumber.h40),
                      Text(' Tiểu tiện',style: TextStyle(
                        fontSize: AppNumber.h52
                      ),),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: AppColor.primaryColor2,
                ),
                InkWell(
                  onTap: () {},
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.qr_code_2, size: AppNumber.h40),
                      Text(' Đại tiện',style: TextStyle(
                          fontSize: AppNumber.h52
                      ),),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: AppColor.primaryColor2,
                ),
                InkWell(
                  onTap: () {},
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.qr_code_2, size: AppNumber.h40),
                      Text(' Đi tắm',style: TextStyle(
                          fontSize: AppNumber.h52
                      ),),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
