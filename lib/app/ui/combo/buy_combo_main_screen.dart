import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';
import 'package:toiletmap/app/repositories/combo_repository.dart';
import 'package:toiletmap/app/repositories/order_repository.dart';
import 'package:toiletmap/app/utils/constants.dart';
import 'package:toiletmap/app/utils/routes.dart';

import '../../models/combo/combo.dart';
import '../../models/combo/comboArgument.dart';
import '../../models/order/order.dart';

class BuyComboMainScreen extends StatefulWidget {
  ComboArgument comboArgument;

  BuyComboMainScreen({Key? key, required this.comboArgument}) : super(key: key);

  @override
  State<BuyComboMainScreen> createState() => _BuyComboMainScreenState();
}

class _BuyComboMainScreenState extends State<BuyComboMainScreen> {
  late int money = 0;
  late TextEditingController _controller;
  late int _value = 1;
  late int comboId = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> buttonList = widget.comboArgument.buttonList;
    List<int> priceList = widget.comboArgument.priceList;

    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.h),
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 20.h),
            child: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: AppColor.primaryColor1,
                ),
              ),

              title: Text('Mua gói'),
              titleTextStyle: AppText.appbarTitleText2,
              centerTitle: true,
              toolbarHeight: 100.h,
              backgroundColor: Colors.white,
              elevation: 0,

              iconTheme: IconThemeData(
                  color: AppColor.primaryColor1
              ),
            ),
          ),
        ),
        backgroundColor: Color(0xFFF1F1F1),

        bottomSheet:  Container(
          height: 150.h,
          color: Colors.white,
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.symmetric(horizontal: 2.w),child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tổng tiền", style: AppText.blackText18,),
                  Text(NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(money) + " VNĐ", style: AppText.blackText18),
                ],
              ),),
              SizedBox(height: 15.h,),
              SizedBox(
                width: double.infinity,
                height: 60.h,
                child: ElevatedButton(
                  onPressed: () async {
                    if (comboId != 0) {
                      print("comboId: " + comboId.toString());
                      Order? order = await OrderRepository().postOrder(comboId);
                      if (order == null) {
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Chú ý'),
                              content: const Text('Mua gói thất bại!'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Xác nhận'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                      await Navigator.pushNamed(context, Routes.homeMainScreen);
                    } else {
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Chú ý'),
                            content: const Text('Vui lòng chọn gói mua!'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Xác nhận'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );

                    }
                  },
                  child: Text("Mua gói", style: AppText.white100Text20,),
                ),
              )
            ],
          ),
        ),

        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15.h,),
                          Padding(padding: EdgeInsets.only(left: 2.w),child: Text('Gói vệ sinh', style: AppText.blackText20),),
                          SizedBox(height: 10.h,),
                          (buttonList.length > 0)
                              ? GroupButton(
                            onSelected: (value, index, isSelected) {
                              print('index ne' + index.toString());
                              (money == priceList[index]) ?
                              setState(() {
                                money = 0;
                                comboId = 0;
                              }) : setState(() {
                                money = priceList[index];
                                comboId = index + 1;
                              });
                            },
                            maxSelected: 1,
                            enableDeselect: true,
                            options: GroupButtonOptions(
                              buttonWidth: 150.w,
                              selectedColor: AppColor.primaryColor2,
                              unselectedColor: Colors.white,
                              selectedBorderColor: AppColor.primaryColor1,
                              unselectedBorderColor: AppColor.primaryColor2,
                              borderRadius: BorderRadius.circular(10.r),
                              elevation: 0,
                              selectedShadow: [],
                              unselectedShadow: [],
                              mainGroupAlignment: MainGroupAlignment.center,
                              crossGroupAlignment: CrossGroupAlignment.center,
                              selectedTextStyle: AppText.blackText18,
                              groupingType: GroupingType.wrap,
                              unselectedTextStyle: AppText.blackText18,
                            ),

                            buttons: buttonList,
                          )
                              : Center(child: Text('Đã có lỗi xảy ra', style: AppText.blackText20,),),
                          SizedBox(height: 15.h,),
                        ],
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15.h,),
                          Padding(padding: EdgeInsets.only(left: 2.w),child: Text('Phương thức mua', style: AppText.blackText20),),
                          SizedBox(height: 10.h,),
                          Row(
                            children: [
                              Radio(value: 1, groupValue: _value, onChanged: (value) {
                                setState(() {
                                  _value = 1;
                                });
                              },),
                              SizedBox(width: 10.w,),
                              Text('Tổng tiền còn dư (${NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(widget.comboArgument.currentMoney) + " VNĐ"})', style: AppText.blackText18,),
                            ],
                          ),
                          SizedBox(height: 10.h,),
                        ],
                      ),
                    ),
                    Container(height: 150.h,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
