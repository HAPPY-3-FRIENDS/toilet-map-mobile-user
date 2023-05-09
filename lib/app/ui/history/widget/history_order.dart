import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:toiletmap/app/utils/constants.dart';

class HistoryOrder extends StatefulWidget {
  int totalTurn;
  int totalPrice;
  String paymentMethod;
  String dateTime;

  HistoryOrder({Key? key, required this.totalTurn, required this.totalPrice, required this.paymentMethod, required this.dateTime}) : super(key: key);

  @override
  State<HistoryOrder> createState() => _HistoryHistoryOrderState();
}

class _HistoryHistoryOrderState extends State<HistoryOrder> {
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(widget.dateTime, style: AppText.listText1,),
              Text('Mua gói ${widget.totalTurn} lượt', style: AppText.listText3,),
              Text(widget.paymentMethod, style: AppText.listText4,),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('- ' + NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(widget.totalPrice) + " VNĐ", style: AppText.listText3),
            ],
          )
        ],
      ),
    );
  }
}
