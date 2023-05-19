import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toiletmap/app/repositories/service_repository.dart';
import 'package:toiletmap/app/repositories/user_info_repository.dart';
import 'package:toiletmap/app/ui/login/login_main_screen.dart';
import 'package:toiletmap/app/utils/routes.dart';

import '../../models/service/service.dart';
import '../../models/userInfo/user_info.dart';
import '../../utils/constants.dart';
import '../login/login_otp_confirmation_screen.dart';

class InformationServicePriceScreen extends StatelessWidget {
  const InformationServicePriceScreen({Key? key}) : super(key: key);

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

                title: Text('Bảng giá dịch vụ'),
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

          body: FutureBuilder<List<Service>?> (
              future: ServiceRepository().getServices(),
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
                  List<Service> services = snapshot.data!;
                  return Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Table(
                        border: TableBorder.all(color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
                        columnWidths: {
                          0: FractionColumnWidth(0.5),
                          1: FractionColumnWidth(0.25),
                          2: FractionColumnWidth(0.25),
                        },
                        children: [
                          buildRow(['Dịch vụ', 'VNĐ/lần', 'Lượt/lần'], isHeader: true),
                          ...services.asMap().entries.map((e) {
                            return buildRow([e.value.name, NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(e.value.price), e.value.turn.toString()]);
                          })
                          //buildRow([snapshot!.data![0].service.name, NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(snapshot!.data![0].service.price), peoplenumber1.toString(), NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(snapshot!.data![0].service.price * peoplenumber1)]),
                          //buildRow([snapshot!.data![1].service.name, NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(snapshot!.data![1].service.price), peoplenumber2.toString(), NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(snapshot!.data![1].service.price * peoplenumber2)]),
                          //buildRow([snapshot!.data![2].service.name, NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(snapshot!.data![2].service.price), peoplenumber3.toString(), NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(snapshot!.data![2].service.price * peoplenumber3)]),
                          //buildRow([snapshot!.data![2].service.name, NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(snapshot!.data![2].service.price), peoplenumber3.toString(), NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(snapshot!.data![2].service.price * peoplenumber3)]),
                        ],
                      ),
                    );
                }
                return Center(child: Text('Lỗi'));
              }),
      ),
    );
  }

  TableRow buildRow(List<String> cells, {bool isHeader = false}) => TableRow(
    decoration: BoxDecoration(
      color: isHeader ? AppColor.primaryColor2 : Colors.white,
      borderRadius: BorderRadius.circular(10.r)
    ),
    children: cells.map((cell) {
      final style = TextStyle(
        fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        fontSize: 20.sp,
      );

      return Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 2.w, color: Color(0xFFF1F1F1)))
        ),
        height: 80.h,
        child: Center(child: Text(cell, style: style,),),
      );
    }).toList(),
  );
}
