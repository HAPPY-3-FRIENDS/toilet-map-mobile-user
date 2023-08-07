import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:toiletmap/app/utils/constants.dart';
import 'package:toiletmap/app/utils/routes.dart';

import '../../../models/checkin/checkin.dart';

class HistoryCheckin extends StatefulWidget {
  Checkin checkin;

  HistoryCheckin({Key? key, required this.checkin}) : super(key: key);

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
                  Expanded(
                      flex: 1,
                      child: Text(widget.checkin.dateTime!, style: AppText.listText1,),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(widget.checkin.toiletName, style: AppText.listText3, maxLines: 1, overflow: TextOverflow.ellipsis),),
                  Expanded(
                      flex: 1,
                      child: Text(widget.checkin.serviceName, style: AppText.listText4,),
                  ),
                ],
              ),),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                (widget.checkin.status == "Chưa đánh giá") ?
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.ratingMainScreen, arguments: widget.checkin).then((_) => setState(() {widget.checkin.status!;}));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      color: AppColor.primaryColor1,
                    ),
                    child: Text("Đánh giá", style: AppText.appbarQRButtonText1,),
                  ),
                )
                    : ((widget.checkin.status == "Đã đánh giá")
                ? Text(widget.checkin.status!, style: AppText.primary1Text20,)
                : Text("Đã hoàn tất", style: AppText.primary1Text20,)),
                Text((widget.checkin.turn != null)
                    ? '- ${widget.checkin.turn} lượt'
                    : '- ' + NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(widget.checkin.balance) + " VNĐ"
                  , style: AppText.listText32,),
              ],
            ),),
        ],
      ),
    );
  }
}
