import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/routes.dart';

class AppbarButtonFrame extends StatelessWidget {
  const AppbarButtonFrame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: AppSize.heightScreen / 7,
          left: AppNumber.h45,
          right: AppNumber.h45),
      child: Container(
          height: AppSize.heightScreen / 8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppNumber.h45),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.topUpMoneyMainScreen);
                    },
                    child: Column(
                      children: [
                        Icon(Icons.wallet_sharp, size: AppSize.heightScreen / 16, color: AppColor.primaryColor1,),
                        Text('Nạp tiền', style: AppText.mainButtonText,),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.buyComboMainScreen);
                    },
                    child: Column(
                      children: [
                        Icon(Icons.shopping_basket, size: AppSize.heightScreen / 16, color: AppColor.primaryColor1,),
                        Text('Mua gói', style: AppText.mainButtonText,),
                      ],
                    ),
                  ),

                  InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Icon(Icons.qr_code_2, size: AppSize.heightScreen / 16, color: AppColor.primaryColor1,),
                        Text('Đi nhẹ', style: AppText.mainButtonText,),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Icon(Icons.qr_code_2, size: AppSize.heightScreen / 16, color: AppColor.primaryColor1,),
                        Text('Đi nặng', style: AppText.mainButtonText,),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Icon(Icons.qr_code_2, size: AppSize.heightScreen / 16, color: AppColor.primaryColor1,),
                        Text('Đi tắm', style: AppText.mainButtonText,),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )
      ),
    );
  }
}
