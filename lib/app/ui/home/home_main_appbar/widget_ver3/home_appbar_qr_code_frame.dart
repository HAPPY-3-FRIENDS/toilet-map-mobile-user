import 'package:flutter/material.dart';
import 'package:toiletmap/app/repositories/shared_preferences_repository.dart';
import 'package:toiletmap/app/ui/home/home_main_appbar/widget_ver3/qr_code_builder.dart';
import 'package:toiletmap/app/utils/constants.dart';

class HomeAppbarQRCodeFrame extends StatelessWidget {
  final int accountId;

  const HomeAppbarQRCodeFrame({Key? key, required this.accountId}) : super(key: key);

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
                  onTap: () => showDialog(
                      context: context,
                      builder: (_) => QRCodeBuilder(accountId: accountId,data: 'Đi vệ sinh (tiểu tiện)')
                  ),
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
                  onTap: () => showDialog(
                      context: context,
                      builder: (_) => QRCodeBuilder(accountId: accountId, data: 'Đi vệ sinh (đại tiện)')
                  ),
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
                  onTap: () => showDialog(
                      context: context,
                      builder: (_) => QRCodeBuilder(accountId: accountId,data: 'Đi tắm')
                  ),
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
