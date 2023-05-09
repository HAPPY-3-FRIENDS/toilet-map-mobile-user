import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:toiletmap/app/utils/constants.dart';

class HistoryCheckin extends StatefulWidget {
  String toiletName;
  String dateTime;
  String serviceName;
  int? turn;
  int? balance;

  HistoryCheckin({Key? key, required this.toiletName, required this.dateTime, required this.serviceName, this.balance, this.turn}) : super(key: key);

  @override
  State<HistoryCheckin> createState() => _HistoryCheckinState();
}

class _HistoryCheckinState extends State<HistoryCheckin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      padding: EdgeInsets.all(10.w),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.dateTime, style: AppText.listText1,),
                  Expanded(
                    child: Text(widget.toiletName, style: AppText.listText3, maxLines: 2, overflow: TextOverflow.ellipsis),),
                  Text(widget.serviceName, style: AppText.listText2,),
                ],
              ),),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.all(AppSize.widthScreen / 60),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: AppColor.primaryColor1,
                  ),
                  child: Text("Đánh giá", style: AppText.appbarQRButtonText1,),
                ),
                Text((widget.turn != null)
                    ? '- ${widget.turn} lượt'
                    : '- ' + NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(widget.balance) + " VNĐ"
                  , style: AppText.listText3,),
              ],
            ),),
        ],
      ),
    );
  }
}
