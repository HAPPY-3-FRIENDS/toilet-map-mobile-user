import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:toiletmap/app/utils/constants.dart';

class QRCodeBuilder extends StatefulWidget {
  final String data;
  final int accountId;

  const QRCodeBuilder({Key? key, required this.data, required this.accountId})
      : super(key: key);

  @override
  State<QRCodeBuilder> createState() => _QRCodeBuilderState();
}

class _QRCodeBuilderState extends State<QRCodeBuilder> {
  int time = 30;
  Timer? timer;
  DateTime date = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() => time--);
      if (time == 0) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        alignment: Alignment.center,
        child: Text("Mã thanh toán ${widget.data}", style: AppText.appbarText2,),
      ),
      titleTextStyle: AppText.alertText,
      elevation: 5,
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppNumber.h60)),
      content: Container(
        height: AppSize.heightScreen / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            QrImage(
              data: '${widget.accountId} - ${widget.data} - $date',
              version: QrVersions.auto,
              gapless: false,
              size: AppSize.widthScreen * 0.7,
            ),
            Text('Mã sẽ biến mất sau $time giây', style: AppText.detailText2,),
          ],
        ),
      )
    );
  }
}