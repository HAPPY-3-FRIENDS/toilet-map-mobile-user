import 'package:flutter/material.dart';
import 'package:toiletmap/app/utils/constants.dart';

class TopUpMoneyMainScreen extends StatefulWidget {
  const TopUpMoneyMainScreen({Key? key}) : super(key: key);

  @override
  State<TopUpMoneyMainScreen> createState() => _TopUpMoneyMainScreenState();
}

class _TopUpMoneyMainScreenState extends State<TopUpMoneyMainScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Nạp tiền'),
            titleTextStyle: AppText.appbarTitleText1,
            centerTitle: true,
            toolbarHeight: AppSize.heightScreen / 12,
            backgroundColor: Colors.transparent,

            flexibleSpace: Container(
              height: AppSize.heightScreen / 12,
              decoration: AppBoxDecoration.boxDecorationWithGradientNoBorder1,
            ),
          ),

          body: Center(
            child: Container(
              padding: EdgeInsets.all(AppSize.heightScreen/45),
              width: AppSize.widthScreen * 0.9,
              height: AppSize.heightScreen * 0.6,
              decoration: AppBoxDecoration.boxDecoration2,
              child: Column(
                children: [
                  Text("Hướng dẫn nạp tiền vào tài khoản", style: AppText.detailText1),
                  SizedBox(height: AppNumber.h40,),
                  Text("Quỷ khách vui lòng chuyển khoản vào Số tài khoản với nội dung bên dưới"),
                  SizedBox(height: AppNumber.h40,),
                  Container(
                    padding: EdgeInsets.all(AppNumber.h60),
                    height: AppSize.heightScreen * 0.25,
                    width: AppSize.widthScreen * 0.75,
                      decoration: AppBoxDecoration.boxDecoration1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('CÔNG TY TNHH BA THÀNH VIÊN HAPPY 3 FRIENDS', style: AppText.bankingInfoText1),
                          Text('STK: 0123456789999', style: AppText.bankingInfoText2),
                          Text('Ngân hàng Sacombank (SCB)', style: AppText.bankingInfoText2),
                          Text('Chi nhánh Thủ Đức, Thành phố Hồ Chí Minh', style: AppText.bankingInfoText2),
                        ],
                      ),
                    ),
                  SizedBox(height: AppNumber.h40,),
                  Text('Nội dung chuyển khoản: ', style: AppText.bankingInfoText2,),
                  Text('[Số điện thoại tài khoản] - Nạp tiền', style: AppText.bankingInfoText2),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
