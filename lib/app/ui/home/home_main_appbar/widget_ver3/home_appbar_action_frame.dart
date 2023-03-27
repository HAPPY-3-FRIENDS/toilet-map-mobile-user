import 'package:flutter/material.dart';
import 'package:toiletmap/app/models/userInfo/user_info.dart';
import 'package:toiletmap/app/repositories/user_info_repository.dart';
import 'package:toiletmap/app/utils/constants.dart';

import '../../../../repositories/shared_preferences_repository.dart';
import '../../../../utils/routes.dart';
import 'payment_method_changing.dart';
import 'home_appbar_qr_code_frame.dart';

class ActionFrame extends StatefulWidget {
  const ActionFrame({Key? key}) : super(key: key);

  @override
  State<ActionFrame> createState() => _ActionFrameState();
}

class _ActionFrameState extends State<ActionFrame> {
  late String defaultPayment;

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
                child: FutureBuilder<UserInfo?> (
                    future: UserInfoRepository().getUserInfoByAccountId(),
                    builder: (context, snapshot)  {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator(
                                color: AppColor.primaryColor1,
                                strokeWidth: 2.0
                            )
                        );
                      }
                      if (snapshot.hasData) {
                        if (snapshot.data!.defaultPayment == "Số lượt") {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Thanh toán bằng số lượt (Mặc định)', style: AppText.appbarText1,),
                                  GestureDetector(
                                      onTap: () => showDialog(
                                          context: context,
                                          builder: (_) => PaymentMethodChanging(methodId: '0', accountTurn: snapshot.data!.accountTurn, accountBalance: snapshot.data!.accountBalance),
                                      ),
                                      child: Icon(Icons.compare_arrows_sharp, color: Colors.black, size: AppNumber.h40,)
                                  ),
                                ],
                              ),
                              Text('${snapshot.data!.accountTurn} lượt', style: AppText.appbarText2),

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
                          );
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Thanh toán bằng số dư (Mặc định)', style: AppText.appbarText1,),
                                  GestureDetector(
                                      onTap: () => showDialog(
                                          context: context,
                                        builder: (_) => PaymentMethodChanging(methodId: '1', accountTurn: snapshot.data!.accountTurn, accountBalance: snapshot.data!.accountBalance),
                                      ),
                                      child: Icon(Icons.compare_arrows_sharp, color: Colors.black, size: AppNumber.h40,)
                                  ),
                                ],
                              ),
                              Text('${snapshot.data!.accountBalance} VND', style: AppText.appbarText2),

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
                          );
                        }
                      }
                      return Center(child: Text('Lỗi'));
                    }),

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
