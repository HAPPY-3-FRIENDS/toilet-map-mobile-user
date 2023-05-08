import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toiletmap/app/repositories/shared_preferences_repository.dart';
import 'package:toiletmap/app/ui/home/home_main_appbar/widget_ver3/qr_code_builder.dart';
import 'package:toiletmap/app/utils/constants.dart';

class HomeAppbarQRCodeFrame extends StatelessWidget {
  final int accountId;

  const HomeAppbarQRCodeFrame({Key? key, required this.accountId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: 3.w,
          right: 3.w,
          top: 10.w,
          bottom: 3.w
      ),
      decoration: AppBoxDecoration.appBarQRCodeDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Mã thanh toán', style: AppText.appbarQRButtonText1,),
          Container(
            height: 120.h,
            padding: EdgeInsets.all(3.w),
            decoration: AppBoxDecoration.boxDecoration1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1.5.w, color: AppColor.primaryColor2),
                        )
                    ),
                    child: InkWell(
                      onTap: () => showDialog(
                          context: context,
                          builder: (_) => QRCodeBuilder(accountId: accountId,data: 'Đi vệ sinh (tiểu tiện)')
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.qr_code_2, size: 15.w),
                          Text('Tiểu tiện',style: TextStyle(
                              fontSize: 18.sp
                          ),),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1.5.w, color: AppColor.primaryColor2),
                        )
                    ),
                    child: InkWell(
                      onTap: () => showDialog(
                          context: context,
                          builder: (_) => QRCodeBuilder(accountId: accountId, data: 'Đi vệ sinh (đại tiện)')
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.qr_code_2, size: 15.w),
                          Text(' Đại tiện',style: TextStyle(
                              fontSize: 18.sp
                          ),),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: InkWell(
                      onTap: () => showDialog(
                          context: context,
                          builder: (_) => QRCodeBuilder(accountId: accountId,data: 'Đi tắm')
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.qr_code_2, size: 15.w),
                          Text(' Đi tắm',style: TextStyle(
                              fontSize: 18.sp
                          ),),
                        ],
                      ),
                    ),
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