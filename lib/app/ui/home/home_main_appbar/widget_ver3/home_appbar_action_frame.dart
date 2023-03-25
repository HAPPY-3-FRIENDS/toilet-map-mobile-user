import 'package:flutter/material.dart';
import 'package:toiletmap/app/utils/constants.dart';

import '../../../../utils/routes.dart';
import '../widget/payment_method_changing.dart';
import 'home_appbar_qr_code_frame.dart';

class ActionFrame extends StatefulWidget {
  const ActionFrame({Key? key}) : super(key: key);

  @override
  State<ActionFrame> createState() => _ActionFrameState();
}

class _ActionFrameState extends State<ActionFrame> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      height: AppSize.heightScreen / 6,
      decoration: AppBoxDecoration.boxDecoration1,
      child: Row(
        children: [
          Expanded(
              flex: 23,
              child: Padding(
                padding: EdgeInsets.only(
                  left: AppSize.widthScreen / 35,
                  top: AppSize.widthScreen / 35,
                  bottom: AppSize.widthScreen / 35,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Thanh toán bằng số lượt (Mặc định)', style: AppText.appbarText1,),
                        GestureDetector(
                            onTap: () {},
                            child: Icon(Icons.compare_arrows_sharp, color: Colors.black, size: AppNumber.h40,)
                        ),
                      ],
                    ),
                    Text('30 lượt', style: AppText.appbarText2),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: AppNumber.h25,
                          width: AppSize.widthScreen / 3.7,
                          child: ElevatedButton.icon(
                            onPressed: () => {
                              Navigator.pushNamed(context, Routes.topUpMoneyMainScreen)
                            },
                            icon: Icon(Icons.login, size: AppNumber.h40, color: Colors.white,),
                            label: Text("Nạp tiền", style: TextStyle(
                                fontSize: AppNumber.h60
                            ),),
                            style: ElevatedButton.styleFrom(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(AppNumber.h45),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: AppSize.widthScreen / 40,
                        ),
                        SizedBox(
                          height: AppNumber.h25,
                          width: AppSize.widthScreen / 3.7,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.buyComboMainScreen);
                            },
                            icon: Icon(Icons.add_shopping_cart, size: AppNumber.h40, color: Colors.white,),
                            label: Text("Mua lượt", style: TextStyle(
                                fontSize: AppNumber.h60
                            ),),
                            style: ElevatedButton.styleFrom(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(AppNumber.h45),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
          ),
          VerticalDivider(
            color: AppColor.primaryColor2,
            thickness: 1,
            indent: AppSize.widthScreen / 35,
            endIndent: AppSize.widthScreen / 35,
          ),
          Expanded(
              flex: 10,
            child: Padding(
              padding: EdgeInsets.only(
                right: AppSize.widthScreen / 100,
                top: AppSize.widthScreen / 100,
                bottom: AppSize.widthScreen / 100,),
              child: HomeAppbarQRCodeFrame(),
            ),
          ),
        ],
      ),
    );
  }
}
