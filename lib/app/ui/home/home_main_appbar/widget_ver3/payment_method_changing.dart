import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';
import 'package:toiletmap/app/repositories/user_info_repository.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/routes.dart';

class PaymentMethodChanging extends StatefulWidget {
  String methodId;
  int accountTurn;
  int accountBalance;

  PaymentMethodChanging({Key? key, required this.methodId, required this.accountTurn, required this.accountBalance}) : super(key: key);

  @override
  State<PaymentMethodChanging> createState() => _PaymentMethodChangingState();
}

class _PaymentMethodChangingState extends State<PaymentMethodChanging> {
  late String _service;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _service = widget.methodId;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          AwesomeDialog(
              context: context,
              dialogType: DialogType.info,
              animType: AnimType.topSlide,
              btnOkText: 'Xác nhận',
              btnOkColor: AppColor.primaryColor1,
              showCloseIcon: true,
              body: Container(
                height: 120.h,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Chọn phương thức thanh toán',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    GroupButton(
                      controller: (widget.methodId == '0') ?
                      GroupButtonController(selectedIndex: 0) :
                      GroupButtonController(selectedIndex: 1),
                      onSelected: (value, index, isSelected) {
                        print('index ne' + index.toString());
                        switch (index) {
                          case 0:
                            setService('0');
                            break;
                          case 1:
                            setService('1');
                            break;
                        }
                      },
                      isRadio: true,
                      options: GroupButtonOptions(
                        textAlign: TextAlign.center,
                        buttonHeight: 50.h,
                        buttonWidth: 120.w,
                        selectedColor: AppColor.primaryColor1,
                        selectedBorderColor: AppColor.primaryColor1,
                        borderRadius: BorderRadius.circular(10.r),
                        unselectedBorderColor: AppColor.primaryColor1,
                        mainGroupAlignment: MainGroupAlignment.center,
                        crossGroupAlignment: CrossGroupAlignment.center,
                        selectedTextStyle: AppText.white100Text18,
                        groupingType: GroupingType.wrap,
                        unselectedTextStyle: AppText.blue1Text18,
                      ),

                      buttons: ['Số lượt\n(${widget.accountTurn} lượt)','Số tiền\n(${NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(widget.accountBalance)} VNĐ)'],
                    ),
                  ],
                ),
              ),
              btnOkOnPress: () async {
                if (widget.methodId != _service) {
                  await UserInfoRepository().patchUserInfoChangePaymentMethod();
                }
                Navigator.pushNamed(context, Routes.homeMainScreen);
              }
          ).show();
        },
        child: Icon(Icons.compare_arrows_sharp, color: Colors.black, size: 15.w,)
    );
  }

  void setService(String? value) {
    if (!mounted) return;
    setState(() {
      _service = value!;
    });
    print(_service);
  }
}