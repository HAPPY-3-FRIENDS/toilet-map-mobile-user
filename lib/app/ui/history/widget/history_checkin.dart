import 'package:flutter/material.dart';
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
              Text(widget.toiletName, style: AppText.listText3,),
              Text(widget.serviceName, style: AppText.listText2,),
            ],
          ),
          Column(
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
                  : '- ${widget.balance} VND'
                , style: AppText.listText3,),
            ],
          )
        ],
      ),
    );
  }
}
