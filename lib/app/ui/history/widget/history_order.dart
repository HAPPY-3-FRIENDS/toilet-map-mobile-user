import 'package:flutter/material.dart';
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
              Text(widget.dateTime, style: AppText.listText1,),
              Text('Mua gói ${widget.totalTurn} lượt', style: AppText.listText3,),
              Text(widget.paymentMethod, style: AppText.listText2,),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('- ${widget.totalPrice}', style: AppText.listText3),
            ],
          )
        ],
      ),
    );
  }
}
