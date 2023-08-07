import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:toiletmap/app/utils/constants.dart';

class HistoryTransaction extends StatefulWidget {
  int total;
  String method;
  String createdDate;

  HistoryTransaction({Key? key, required this.total, required this.method, required this.createdDate}) : super(key: key);

  @override
  State<HistoryTransaction> createState() => _HistoryTransactionState();
}

class _HistoryTransactionState extends State<HistoryTransaction> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      padding: EdgeInsets.all(10.w),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(widget.createdDate, style: AppText.listText1,),
              Text("Nạp tiền vào tài khoản", style: AppText.listText3,),
              Text(widget.method, style: AppText.listText4,),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('+ ' + NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(widget.total) + " VNĐ", style: AppText.listText3),
            ],
          )
        ],
      ),
    );
  }
}
