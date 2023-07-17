import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';
import 'package:toiletmap/app/repositories/money_repository.dart';
import 'package:toiletmap/app/utils/constants.dart';
import 'package:toiletmap/app/utils/routes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TopUpMoneyMainScreen extends StatefulWidget {
  const TopUpMoneyMainScreen({Key? key}) : super(key: key);

  @override
  State<TopUpMoneyMainScreen> createState() => _TopUpMoneyMainScreenState();
}

class _TopUpMoneyMainScreenState extends State<TopUpMoneyMainScreen> {
  late int money1;
  late int money2;
  late TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    money1 = 0;
    money2 = 0;
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


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

                title: Text('Nạp tiền'),
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
                    Text("Số tiền nạp", style: AppText.blackText18,),
                    (money1 != 0)
                    ? Text(NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(money1) + " VNĐ", style: AppText.blackText18)
                        : Text(NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(money2) + " VNĐ", style: AppText.blackText18)
                    ,
                  ],
                ),),
                SizedBox(height: 15.h,),
                SizedBox(
                  width: double.infinity,
                  height: 60.h,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (money1 != 0) {
                        String? paymentUrl = await MoneyRepository().postVNPay(money1);
                        final url = Uri.parse(paymentUrl!);
                        launchUrl(
                          url,
                          mode: LaunchMode.inAppWebView,
                        );
                      } else if (money2 != 0) {
                        String? paymentUrl = await MoneyRepository().postVNPay(money2);
                        /*final url = Uri.parse(paymentUrl!);
                        launchUrl(
                          url,
                          mode: LaunchMode.inAppWebView,
                        );*/
                        Navigator.pushNamed(context, Routes.VNPayView, );
                      } else {
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Chú ý'),
                              content: const Text('Vui lòng chọn số tiền!'),
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
                    child: Text("Nạp tiền", style: AppText.white100Text20,),
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
                              Padding(padding: EdgeInsets.only(left: 2.w),child: Text('Số tiền nạp (VNĐ)', style: AppText.blackText20),),
                              SizedBox(height: 10.h,),
                              GroupButton(

                                onSelected: (value, index, isSelected) {
                                  print('index ne' + index.toString());
                                  switch (index) {
                                    case 0:
                                      (money1 == 10000) ?
                                      setState(() {
                                        money1 = 0;
                                      }) : setState(() {
                                        money1 = 10000;
                                      });
                                      break;
                                    case 1:
                                      (money1 == 20000) ?
                                      setState(() {
                                        money1 = 0;
                                      }) : setState(() {
                                        money1 = 20000;
                                      });
                                      break;
                                    case 2:
                                      (money1 == 50000) ?
                                      setState(() {
                                        money1 = 0;
                                      }) : setState(() {
                                        money1 = 50000;
                                      });
                                      break;
                                    case 3:
                                      (money1 == 100000) ?
                                      setState(() {
                                        money1 = 0;
                                      }) : setState(() {
                                        money1 = 100000;
                                      });
                                      break;
                                    case 4:
                                      (money1 == 200000) ?
                                      setState(() {
                                        money1 = 0;
                                      }) : setState(() {
                                        money1 = 200000;
                                      });
                                      break;
                                    case 5:
                                      (money1 == 500000) ?
                                      setState(() {
                                        money1 = 0;
                                      }) : setState(() {
                                        money1 = 500000;
                                      });
                                      break;
                                  }
                                },
                                maxSelected: 1,
                                enableDeselect: true,
                                options: GroupButtonOptions(
                                  buttonWidth: 100.w,
                                  selectedColor: (money1 != 0) ? AppColor.primaryColor2 : Colors.white,
                                  unselectedColor: Colors.white,
                                  selectedBorderColor: (money1 != 0) ? AppColor.primaryColor1 : AppColor.primaryColor2,
                                  unselectedBorderColor: AppColor.primaryColor2,
                                  borderRadius: BorderRadius.circular(10.r),
                                  elevation: 0,
                                  selectedShadow: [],
                                  unselectedShadow: [],
                                  mainGroupAlignment: MainGroupAlignment.center,
                                  crossGroupAlignment: CrossGroupAlignment.center,
                                  selectedTextStyle: AppText.blackText20,
                                  groupingType: GroupingType.wrap,
                                  unselectedTextStyle: AppText.blackText20,
                                ),

                                buttons: ['10,000','20,000','50,000','100,000','200,000','500,000'],
                              ),
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
                              Padding(padding: EdgeInsets.only(left: 2.w),child: Text('Nhập số tiền khác', style: AppText.blackText20),),
                              SizedBox(height: 10.h,),
                              Container(
                                height: 50.h,
                                child: Form(
                                  child: TextFormField(
                                    onChanged: (value) => setState(() => {
                                      money1 = 0,
                                      money2 = int.parse(value)
                                    }),
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.right,
                                    decoration: InputDecoration(
                                      hintText: "Nhập số tiền",
                                      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                                      alignLabelWithHint: true,
                                      suffix: Text(' VNĐ', style: AppText.greyText18),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.r),
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.r),
                                        borderSide: BorderSide(color: AppColor.primaryColor1),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h,),
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
                              Padding(padding: EdgeInsets.only(left: 2.w),child: Text('Phương thức nạp', style: AppText.blackText20),),
                              SizedBox(height: 10.h,),
                              RadioListTile(
                                title: Text("VNPAY", style: AppText.blackText18,),
                                contentPadding: EdgeInsets.zero,

                                value: "VNPAY", groupValue: "VNPAY", onChanged: (value) {
                                setState(() {});
                              },),
                              SizedBox(height: 10.h,),
                            ],
                          ),
                        ),
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
