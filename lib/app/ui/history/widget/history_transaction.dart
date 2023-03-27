import 'package:flutter/material.dart';
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
      height: AppNumber.h15,
      margin: EdgeInsets.all(AppSize.widthScreen / 40),
      decoration: AppBoxDecoration.boxDecoration1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.createdDate, style: AppText.listText1,),
              Text("Nạp tiền vào tài khoản", style: AppText.listText3,),
              Text(widget.method, style: AppText.listText2,),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('+ ${widget.total}', style: AppText.listText3),
            ],
          )
        ],
      ),
    );
  }
}
