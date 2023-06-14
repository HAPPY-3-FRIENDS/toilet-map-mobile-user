import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:toiletmap/app/models/combo/comboArgument.dart';
import 'package:toiletmap/app/models/userInfo/user_info.dart';
import 'package:toiletmap/app/repositories/combo_repository.dart';
import 'package:toiletmap/app/repositories/user_info_repository.dart';
import 'package:toiletmap/app/utils/constants.dart';

import '../../../../models/combo/combo.dart';
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
      height: 170.h,
      decoration: AppBoxDecoration.boxDecoration1,
      child: Row(
        children: [
          Expanded(
              flex: 23,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 10.w,
                  top: 10.w,
                  bottom: 10.h,),
                child: FutureBuilder<UserInfo?> (
                    future: UserInfoRepository().getUserInfo(),
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
                              Expanded(child: Padding(
                                padding: EdgeInsets.only(left: 5.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Thanh toán bằng số lượt (Mặc định)',
                                        style: AppText.appbarText1,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      flex: 8,
                                    ),
                                    Expanded(
                                      child: PaymentMethodChanging(methodId: '0', accountTurn: snapshot.data!.accountTurn, accountBalance: snapshot.data!.accountBalance),
                                      flex: 1,
                                    )
                                  ],
                                ),
                              ), flex: 1),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 5.w),
                                  child: Text(
                                    '${snapshot.data!.accountTurn} lượt',
                                    style: AppText.appbarText2,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                flex: 1
                              ),
                              Expanded(child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 35.h,
                                    width: 100.w,
                                    child: ElevatedButton.icon(
                                      onPressed: () => {
                                        Navigator.pushNamed(context, Routes.topUpMoneyMainScreen)
                                      },
                                      icon: Icon(Icons.login, size: 20.w, color: Colors.white,),
                                      label: Text("Nạp tiền", style: TextStyle(
                                          fontSize: 16.sp
                                      ),),
                                      style: ElevatedButton.styleFrom(
                                        shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(20.r),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  SizedBox(
                                    height: 35.h,
                                    width: 100.w,
                                    child: ElevatedButton.icon(
                                      onPressed: () async {
                                        List<String> buttonList = [];
                                        List<int> priceList = [];
                                        List<Combo>? combo = await ComboRepository().getCombos();

                                        combo!.forEach((element) {
                                          buttonList.add(NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(element.price) + " VNĐ/" + element.totalTurn.toString() + " lượt");
                                          priceList.add(element.price);
                                        });

                                        ComboArgument comboArgument = ComboArgument(buttonList, priceList, snapshot.data!.accountBalance);
                                        await Navigator.pushNamed(context, Routes.buyComboMainScreen, arguments: comboArgument);
                                      },
                                      icon: Icon(Icons.add_shopping_cart, size: 20.w, color: Colors.white,),
                                      label: Text("Mua lượt", style: TextStyle(
                                          fontSize: 16.sp
                                      ),),
                                      style: ElevatedButton.styleFrom(
                                        shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(20.r),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ), flex: 1,),
                              Expanded(child: Padding(
                                padding: EdgeInsets.only(left: 2.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () => showDialog(
                                        barrierDismissible: true,
                                          context: context,
                                          builder: (_) => Center(
                                            child: Image(image: AssetImage('assets/logo-circle.png'), height: 250.w, width: 250.w,),
                                          ),
                                      ),
                                      child: Image(image: AssetImage('assets/logo-circle.png'), height: 15.w, width: 15.w,),
                                    ),
                                    Text(' : Ký hiệu Nhà vệ sinh', style: AppText.appbarText3,),
                                  ],
                                ),
                              ), flex: 1,)
                            ],
                          );
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Padding(
                                padding: EdgeInsets.only(left: 5.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Thanh toán bằng số tiền (Mặc định)',
                                        style: AppText.appbarText1,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      flex: 8,
                                    ),
                                    Expanded(
                                      child: PaymentMethodChanging(methodId: '1', accountTurn: snapshot.data!.accountTurn, accountBalance: snapshot.data!.accountBalance),
                                      flex: 1,
                                    )
                                  ],
                                ),
                              ), flex: 1),
                              Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 5.w),
                                    child: Text(
                                      NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(snapshot.data!.accountBalance) + ' VNĐ',
                                      style: AppText.appbarText2,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  flex: 1
                              ),
                              Expanded(child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 35.h,
                                    width: 100.w,
                                    child: ElevatedButton.icon(
                                      onPressed: () => {
                                        Navigator.pushNamed(context, Routes.topUpMoneyMainScreen)
                                      },
                                      icon: Icon(Icons.login, size: 20.w, color: Colors.white,),
                                      label: Text("Nạp tiền", style: TextStyle(
                                          fontSize: 16.sp
                                      ),),
                                      style: ElevatedButton.styleFrom(
                                        shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(20.r),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  SizedBox(
                                    height: 35.h,
                                    width: 100.w,
                                    child: ElevatedButton.icon(
                                      onPressed: () async {
                                        List<String> buttonList = [];
                                        List<int> priceList = [];
                                        List<Combo>? combo = await ComboRepository().getCombos();

                                        combo!.forEach((element) {
                                          buttonList.add(NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(element.price) + " VNĐ/" + element.totalTurn.toString() + " lượt");
                                          priceList.add(element.price);
                                        });

                                        ComboArgument comboArgument = ComboArgument(buttonList, priceList, snapshot.data!.accountBalance);
                                        await Navigator.pushNamed(context, Routes.buyComboMainScreen, arguments: comboArgument);
                                      },
                                      icon: Icon(Icons.add_shopping_cart, size: 20.w, color: Colors.white,),
                                      label: Text("Mua lượt", style: TextStyle(
                                          fontSize: 16.sp
                                      ),),
                                      style: ElevatedButton.styleFrom(
                                        shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(20.r),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ), flex: 1,)
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
            indent: 15.h,
            endIndent: 15.h,
          ),
          FutureBuilder<int?> (
              future: SharedPreferencesRepository().getAccountId(),
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
                  return Expanded(
                    flex: 10,
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: 5.w,
                        top: 5.w,
                        bottom: 5.w,),
                      child: HomeAppbarQRCodeFrame(accountId: snapshot.data!),
                    ),
                  );
                }
                return Center(child: Text('Lỗi'));
              }),
        ],
      ),
    );
  }
}
